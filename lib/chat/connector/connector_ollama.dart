import 'package:agentic/chat/connector/model.dart';

import 'connector_openai.dart';

class OLlamaConnector extends OpenAIConnector {
  const OLlamaConnector({
    super.apiKey = "",
    super.baseUrl = "http://localhost:11434/v1",
  });

  @override
  List<ChatModel> get supportedModels => const [];
}
