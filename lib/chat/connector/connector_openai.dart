import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/connector.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/util/codec.dart';
import 'package:langchain/langchain.dart' as lc;
import 'package:langchain_openai/langchain_openai.dart' as lc;

class OpenAIConnector extends ChatConnector {
  OpenAIConnector({
    required super.apiKey,
    super.baseUrl = "https://api.openai.com/v1",
  });

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
                : request.tools.map((i) => i.toLangChain).toList(),
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
      realCost: request.model.cost.getRealCost(
        usage.inputTokens,
        usage.outputTokens,
      ),
      metadata: result.metadata,
      finishReason: result.finishReason.toAgentic,
      usage: usage,
    );
  }
}
