import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/connector.dart';
import 'package:agentic/chat/connector/model.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/util/codec.dart';
import 'package:langchain/langchain.dart' as lc;
import 'package:langchain_anthropic/langchain_anthropic.dart' as lc;

class AnthropicConnector extends ChatConnector {
  AnthropicConnector({
    required super.apiKey,
    super.baseUrl = "https://api.anthropic.com/v1",
  });

  @override
  List<ChatModel> get supportedModels => const [
    ChatModel.anthropicClaude3_7Sonnet,
    ChatModel.anthropicClaude3_5Haiku,
  ];

  @override
  Future<ChatResult> call(ChatRequest request) async {
    request = request.adapted;

    if (request.model.capabilities.structuredOutput) {
      throw UnsupportedError("Anthropic does not support structured output.");
    }

    lc.ChatResult result = await lc.ChatAnthropic(
      apiKey: apiKey,
      baseUrl: baseUrl,
      defaultOptions: lc.ChatAnthropicOptions(
        model: request.model.id,
        userId: request.user,
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
