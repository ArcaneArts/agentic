import 'dart:convert';

import 'package:agentic/chat/agent/chat_provider.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/chat/content/content.dart';
import 'package:agentic/chat/message/message.dart';
import 'package:agentic/chat/message/message_agent.dart';
import 'package:agentic/chat/message/message_tool.dart';
import 'package:agentic/chat/tool/tool.dart';
import 'package:agentic/chat/tool/tool_call.dart';
import 'package:agentic/chat/tool/tool_schema.dart';
import 'package:artifact/artifact.dart';
import 'package:fast_log/fast_log.dart';
import 'package:rational/rational.dart';
import 'package:toxic/extensions/iterable.dart';

class Agent {
  final ConnectedChatModel llm;
  final String? user;
  final ChatProvider chatProvider;
  final Map<String, dynamic> customData;
  final String? initialSystemMessage;

  Agent({
    this.user,
    required this.llm,
    required this.chatProvider,
    this.initialSystemMessage,
    this.customData = const {},
  });

  Future<List<Message>> readMessages() => chatProvider.readMessages();

  Future<void> addMessage(Message message) => chatProvider.addMessage(message);

  Future<ChatResult> _callChat({
    required List<Message> messages,
    required ToolSchema? schema,
    required List<Tool> tools,
    int backoff = 1,
  }) async {
    try {
      return await llm.connector(
        ChatRequest(
          messages: [
            if (initialSystemMessage != null)
              Message.system(initialSystemMessage!),
            ...messages,
          ],
          model: llm.model,
          responseFormat: schema,
          tools: tools,
          user: user,
        ),
      );
    } catch (e) {
      if (backoff > 512) {
        rethrow;
      }

      if (e.toString().contains("429")) {
        int nextBackoff = backoff * 2;
        warn("${llm.model.id} Rate limited, retrying in $nextBackoff seconds");
        await Future.delayed(Duration(seconds: nextBackoff));
        return _callChat(
          messages: messages,
          schema: schema,
          tools: tools,
          backoff: nextBackoff,
        );
      }

      rethrow;
    }
  }

  Future<AgentMessage> call({
    ToolSchema? responseFormat,
    List<Tool> tools = const [],
    int maxRecursiveToolCalls = 1,
  }) async {
    List<Message> messages = await readMessages();
    ToolSchema? schema = tools.isNotEmpty ? null : responseFormat;
    ChatResult result = await _callChat(
      messages: messages,
      schema: schema,
      tools: tools,
    );

    await Future.wait(
      agentUsageListeners.map(
        (i) =>
            i(AgentUsageEvent(this, result.usage, result.realCost.toRational)),
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

const Artifact dmodel = Artifact(
  compression: true,
  reflection: false,
  generateSchema: false,
);
