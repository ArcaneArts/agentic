import 'package:agentic/chat/connector/model.dart';

import 'connector_openai.dart';

class InceptionLabsConnector extends OpenAIConnector {
  const InceptionLabsConnector({
    required super.apiKey,
    super.baseUrl = "https://api.inceptionlabs.ai/v1",
  });

  @override
  List<ChatModel> get supportedModels => const [ChatModel.mercuryCoderSmall];
}
