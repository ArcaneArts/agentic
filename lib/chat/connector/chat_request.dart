import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/model.dart';
import 'package:agentic/chat/tool/tool.dart';
import 'package:artifact/artifact.dart';

@artifact
class ChatRequest {
  final List<Message> messages;
  final List<ToolSchema> tools;
  final ChatModel model;
  final String? user;
  final String? systemPrompt;
  final ToolSchema? responseFormat;

  const ChatRequest({
    required this.messages,
    required this.tools,
    required this.model,
    this.systemPrompt,
    this.user,
    this.responseFormat,
  });

  ChatRequest get ultraCompatible => copyWith(
    model: model.copyWith(
      capabilities: model.capabilities.copyWith(
        systemMode: ChatModelSystemMode.unsupported,
        seesToolMessages: false,
      ),
    ),
  );

  ChatRequest get adapted {
    ChatRequest r = this;

    if (model.capabilities.ultraCompatibleMode) {
      r = r.ultraCompatible;
    }

    if (!model.capabilities.seesToolMessages &&
        r.messages.any((i) => i is ToolMessage)) {
      r = r.copyWith(
        messages:
            r.messages
                .map((i) => i is ToolMessage ? i.toolAsSystemMessage : i)
                .toList(),
      );
    }

    r = r.copyWith(
      messages: switch (model.capabilities.systemMode) {
        ChatModelSystemMode.supported =>
          systemPrompt != null
              ? [
                SystemMessage(content: Content.text(systemPrompt!)),
                ...messages,
              ]
              : messages,
        ChatModelSystemMode.merged =>
          messages.where((i) => i is! SystemMessage).toList(),
        ChatModelSystemMode.unsupported =>
          messages
              .map((i) => i is SystemMessage ? i.asUserSystemMessage : i)
              .toList(),
      },
      deleteSystemPrompt: switch (model.capabilities.systemMode) {
        ChatModelSystemMode.supported ||
        ChatModelSystemMode.unsupported => true,
        ChatModelSystemMode.merged => false,
      },
      deleteResponseFormat: !model.capabilities.structuredOutput,
      systemPrompt:
          model.capabilities.systemMode == ChatModelSystemMode.merged
              ? messages
                  .whereType<SystemMessage>()
                  .map((i) => i.content)
                  .followedBy([
                    if (systemPrompt != null) Content.text(systemPrompt!),
                  ])
                  .join('\n')
              : systemPrompt,
      tools: model.capabilities.tools ? tools : [],
    );

    return r;
  }
}
