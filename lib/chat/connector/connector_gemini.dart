import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/connector.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/util/codec.dart';
import 'package:langchain/langchain.dart' as lc;
import 'package:langchain_google/langchain_google.dart' as lc;

class AnthropicConnector extends ChatConnector {
  AnthropicConnector({
    required super.apiKey,
    super.baseUrl = "https://generativelanguage.googleapis.com/v1beta",
  });

  @override
  Future<ChatResult> call(ChatRequest request) async {
    request = request.adapted;

    lc.ChatResult result = await lc.ChatGoogleGenerativeAI(
      apiKey: apiKey,
      baseUrl: baseUrl,
      defaultOptions: lc.ChatGoogleGenerativeAIOptions(
        model: request.model.id,
        responseMimeType:
            request.responseFormat != null ? "application/json" : null,
        responseSchema: request.responseFormat?.schema,
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
