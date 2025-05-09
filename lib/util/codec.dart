import 'dart:convert';

import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/chat/tool/tool.dart';
import 'package:langchain/langchain.dart';

import '../chat/content/text_content.dart';

extension XChatMessageContent4LC on ChatMessageContent {
  Content get toAgentic => switch (this) {
    ChatMessageContentMultiModal() => Content.group(
      (this as ChatMessageContentMultiModal).parts
          .map((i) => i.toAgentic)
          .toList(),
    ),
    ChatMessageContentText(text: String t) => Content.text(t),
    ChatMessageContentImage(data: String d) =>
      d.startsWith("http") ? Content.imageUrl(d) : Content.imageBase64(d),
  };
}

extension XChatMessageContent2LC on Content {
  ChatMessageContent get toLangChain => switch (this) {
    ContentGroup() => ChatMessageContentMultiModal(
      parts: (this as ContentGroup).contents.map((i) => i.toLangChain).toList(),
    ),
    TextContent(text: String t) => ChatMessageContent.text(t),
    AudioContent(audioUrl: String? u, base64Audio: String? b) =>
      throw UnimplementedError(
        "Audio content not supported yet on langchain chat content",
      ),
    ImageContent(imageUrl: String? u, base64Image: String? b) =>
      ChatMessageContent.image(data: (u ?? b)!),
    Content() =>
      throw UnimplementedError(
        "base Content type not supported, use a specific one",
      ),
  };
}

extension XChatFinishReason on FinishReason {
  ChatFinishReason get toAgentic => switch (this) {
    FinishReason.stop => ChatFinishReason.stop,
    FinishReason.length => ChatFinishReason.length,
    FinishReason.contentFilter => ChatFinishReason.contentFilter,
    FinishReason.recitation => ChatFinishReason.recitation,
    FinishReason.toolCalls => ChatFinishReason.toolCalls,
    FinishReason.unspecified => ChatFinishReason.unspecified,
  };
}

extension XChatMessage4LC on ChatMessage {
  Message get toAgentic => switch (this) {
    HumanChatMessage(content: var c) => UserMessage(content: c.toAgentic),
    SystemChatMessage(content: var c) => SystemMessage(
      content: Content.text(c),
    ),
    ToolChatMessage(content: var c, toolCallId: var t) => ToolMessage(
      content: Content.text(c),
      toolCallId: t,
    ),
    AIChatMessage(content: var c, toolCalls: var tc) => AgentMessage(
      content: Content.text(c),
      toolCalls: tc.map((i) => i.toAgentic).toList(),
    ),
    _ => throw Exception('Unknown message type: ${this.runtimeType}'),
  };
}

extension XAIChatMessageToolCall4LC on AIChatMessageToolCall {
  ToolCall get toAgentic =>
      ToolCall(id: id, name: name, arguments: argumentsRaw);
}

extension XChatMessageToolCall2LC on ToolCall {
  AIChatMessageToolCall get toLangChain => AIChatMessageToolCall(
    arguments: _tryDecode(arguments),
    id: id,
    name: name,
    argumentsRaw: arguments,
  );

  Map<String, dynamic> _tryDecode(String json) {
    try {
      return jsonDecode(json);
    } catch (e) {
      return {};
    }
  }
}

extension XChatMessage2LC on Message {
  ChatMessage get toLangChain => switch (this) {
    UserMessage(content: var c) => ChatMessage.human(c.toLangChain),
    SystemMessage(content: var c) => ChatMessage.system(c.toString()),
    ToolMessage(content: var c, toolCallId: var tc) => ChatMessage.tool(
      content: c.toString(),
      toolCallId: tc,
    ),
    AgentMessage(content: var c, toolCalls: var tc) => ChatMessage.ai(
      c.toString(),
      toolCalls: tc.map((i) => i.toLangChain).toList(),
    ),
    _ => throw Exception('Unknown message type: ${runtimeType}'),
  };
}

extension XToolSpec2LC on ToolSchema {
  ToolSpec get toLangChain => ToolSpec(
    name: name,
    description: description,
    inputJsonSchema: schema,
    strict: true,
  );
}
