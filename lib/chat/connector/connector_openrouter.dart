import 'package:agentic/chat/connector/model.dart';
import 'package:agentic/util/open_router_models.dart';

import 'connector_openai.dart';

class OpenRouterConnector extends OpenAIConnector {
  const OpenRouterConnector({
    required super.apiKey,
    super.baseUrl = "https://openrouter.ai/api/v1",
  });

  @override
  List<ChatModel> get supportedModels => openRouterChatModels;

  @override
  Future<List<double>> embed({
    required String model,
    required String text,
    int? dimensions,
  }) =>
      throw UnimplementedError(
        "openrouter doesnt support this directly, use openai or ollama or naga providers",
      );

  @override
  Future<List<List<double>>> embedMultiple({
    required String model,
    required List<String> texts,
    int? dimensions,
  }) =>
      throw UnimplementedError(
        "openrouter doesnt support this directly, use openai or ollama naga providers",
      );
}
