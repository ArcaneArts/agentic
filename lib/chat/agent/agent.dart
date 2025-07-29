import 'dart:convert';

import 'package:agentic/agentic.dart';
import 'package:agentic/chat/agent/chat_provider.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:rational/rational.dart';
import 'package:toxic/extensions/iterable.dart';

class Agent {
  final ConnectedChatModel llm;
  final String? user;
  final ChatProvider chatProvider;
  final Map<String, dynamic> customData;

  Agent({
    this.user,
    required this.llm,
    required this.chatProvider,
    this.customData = const {},
  });

  Future<List<Message>> readMessages() => chatProvider.readMessages();

  Future<void> addMessage(Message message) => chatProvider.addMessage(message);

  Future<AgentMessage> call({
    ToolSchema? responseFormat,
    List<Tool> tools = const [],
    int maxRecursiveToolCalls = 1,
  }) async {
    List<Message> messages = await readMessages();
    ToolSchema? schema = tools.isNotEmpty ? null : responseFormat;
    ChatResult result = await llm.connector(
      ChatRequest(
        messages: [...messages],
        model: llm.model,
        responseFormat: schema,
        tools: tools,
        user: user,
      ),
    );

    await Future.wait(
      agentUsageListeners.map(
        (i) => i(AgentUsageEvent(this, result.usage, result.realCost)),
      ),
    );

    await addMessage(result.message);

    if (result.message.toolCalls.isNotEmpty) {
      maxRecursiveToolCalls--;
      for (ToolCall tc in result.message.toolCalls) {
        String output = "";
        Tool? tool = tools.select((i) => i.name == tc.name);

        if (tool == null) {
          output = "Tool not found: ${tc.name}";
          continue;
        }

        try {
          output = await tool(agent: this, arguments: jsonDecode(tc.arguments));
        } catch (e, es) {
          output = "Error calling tool: ${e.toString()}";
          print("Tool Call Exception ${tool.name}(${tc.arguments}) => $e $es");
        }

        await addMessage(
          ToolMessage(content: Content.text(output), toolCallId: tc.id),
        );
      }

      if (maxRecursiveToolCalls > 0) {
        return this(
          responseFormat: schema,
          tools: tools,
          maxRecursiveToolCalls: maxRecursiveToolCalls,
        );
      }

      return this(responseFormat: responseFormat, tools: []);
    }

    return result.message;
  }
}

class AgentUsageEvent {
  final Agent agent;
  final ChatUsage usage;
  final Rational cost;

  const AgentUsageEvent(this.agent, this.usage, this.cost);
}

List<Future<void> Function(AgentUsageEvent)> agentUsageListeners = [];
