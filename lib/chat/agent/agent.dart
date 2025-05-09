import 'dart:convert';

import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:toxic/extensions/iterable.dart';

abstract class ChatProvider {
  Future<List<Message>> readMessages();

  Future<void> addMessage(Message message);
}

class MemoryChatProvider extends ChatProvider {
  late final List<Message> messages;

  MemoryChatProvider({List<Message>? messages}) {
    this.messages = messages ?? [];
  }

  @override
  Future<void> addMessage(Message message) async => messages.add(message);

  @override
  Future<List<Message>> readMessages() => Future.value(messages);
}

class Agent {
  final ChatConnector connector;
  final ChatModel model;
  final String? user;
  final ChatProvider chatProvider;
  ChatUsage totalUsage = const ChatUsage();

  Agent({
    this.user,
    required this.connector,
    required this.model,
    required this.chatProvider,
  });

  Future<List<Message>> readMessages() => chatProvider.readMessages();

  Future<void> addMessage(Message message) => chatProvider.addMessage(message);

  Future<AgentMessage> call({
    ToolSchema? responseFormat,
    List<Tool> tools = const [],
    int maxToolCalls = 1,
  }) async {
    List<Message> messages = await readMessages();
    ToolSchema? schema = tools.isNotEmpty ? null : responseFormat;
    ChatResult result = await connector(
      ChatRequest(
        messages: [...messages],
        model: model,
        responseFormat: schema,
        tools: tools,
        user: user,
      ),
    );
    totalUsage += result.usage;
    await addMessage(result.message);

    if (result.message.toolCalls.isNotEmpty) {
      maxToolCalls--;
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

      if (maxToolCalls > 0) {
        return this(
          responseFormat: schema,
          tools: tools,
          maxToolCalls: maxToolCalls,
        );
      }

      return this(responseFormat: responseFormat, tools: []);
    }

    return result.message;
  }
}
