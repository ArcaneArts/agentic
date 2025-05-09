import 'connector_openai.dart';

class InceptionLabsConnector extends OpenAIConnector {
  InceptionLabsConnector({
    required super.apiKey,
    super.baseUrl = "https://api.inceptionlabs.ai/v1",
  });
}
