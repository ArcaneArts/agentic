import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/chat/content/text_content.dart';
import 'package:agentic/util/codec.dart';
import 'package:langchain/langchain.dart' as lc;
import 'package:langchain_openai/langchain_openai.dart' as lc;

class OpenAIConnector extends ChatConnector with EmbedProvider {
  const OpenAIConnector({
    required super.apiKey,
    super.baseUrl = "https://api.openai.com/v1",
  });

  @override
  List<ChatModel> get supportedModels => const [
    ChatModel.openaiO4Mini,
    ChatModel.openaiO3,
    ChatModel.openaiO3Mini,
    ChatModel.openaiO1Pro,
    ChatModel.openaiO1,
    ChatModel.openaiO1Mini,
    ChatModel.openai4_1,
    ChatModel.openai4_1Mini,
    ChatModel.openai4_1Nano,
    ChatModel.openai4o,
    ChatModel.openai4oMini,
  ];

  @override
  Future<ChatResult> call(ChatRequest request) async {
    request = request.adapted;
    lc.ChatResult result = await lc.ChatOpenAI(
      apiKey: apiKey,
      baseUrl: baseUrl,
      defaultOptions: lc.ChatOpenAIOptions(
        model: request.model.id,
        user: request.user,
        responseFormat:
            request.responseFormat != null
                ? lc.ChatOpenAIResponseFormat.jsonSchema(
                  lc.ChatOpenAIJsonSchema(
                    name: request.responseFormat!.name,
                    strict: true,
                    description: request.responseFormat!.description,
                    schema: request.responseFormat!.schema,
                  ),
                )
                : null,
        toolChoice: request.tools.isNotEmpty ? lc.ChatToolChoiceAuto() : null,
        tools:
            request.tools.isEmpty
                ? null
                : request.tools.map((i) => i.toolSchema.toLangChain).toList(),
      ),
    ).invoke(
      lc.PromptValue.chat([for (Message i in request.messages) i.toLangChain]),
    );

    ChatUsage usage = ChatUsage(
      inputTokens: result.usage.promptTokens ?? 0,
      outputTokens: result.usage.responseTokens ?? 0,
    );

    return ChatResult(
      message: result.output.toAgentic as AgentMessage,
      realCost: ARational.fromRational(
        request.model.cost.getRealCost(usage.inputTokens, usage.outputTokens),
      ),
      metadata: result.metadata,
      finishReason: result.finishReason.toAgentic,
      usage: usage,
    );
  }

  @override
  Future<List<double>> embed({
    required String model,
    required Content content,
    int? dimensions,
  }) => embedMultiple(
    model: model,
    contents: [content],
    dimensions: dimensions,
  ).then((List<List<double>> values) => values.first);

  @override
  Future<List<List<double>>> embedMultiple({
    required String model,
    required List<Content> contents,
    int? dimensions,
  }) => lc.OpenAIEmbeddings(
    model: model,
    apiKey: apiKey,
    baseUrl: baseUrl,
    dimensions: dimensions,
  ).embedDocuments(
    contents
        .map(
          (Content i) => lc.Document(pageContent: _requireTextEmbeddingInput(i)),
        )
        .toList(),
  );

  String _requireTextEmbeddingInput(Content content) {
    List<Content> parts = content.explode().toList();
    bool hasNonText = parts.any((Content i) => i is! TextContent);

    if (hasNonText) {
      throw UnsupportedError(
        'This embedding connector only supports text content. Use Content.text(...) or a text-only Content.group(...).',
      );
    }

    return parts.whereType<TextContent>().map((TextContent i) => i.text).join(
      ' ',
    );
  }
}
