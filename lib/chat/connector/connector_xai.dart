import 'package:agentic/chat/connector/model.dart';

import 'connector_openai.dart';

class XaiConnector extends OpenAIConnector {
  const XaiConnector({
    required super.apiKey,
    super.baseUrl = "https://api.x.ai/v1",
  });

  @override
  List<ChatModel> get supportedModels => const [
    ChatModel.xaiGrok3,
    ChatModel.xaiGrok3Fast,
    ChatModel.xaiGrok3Mini,
    ChatModel.xaiGrok3MiniFast,
  ];
}
