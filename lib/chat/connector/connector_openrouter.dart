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
}
