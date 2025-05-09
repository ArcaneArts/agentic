import 'connector_openai.dart';

class XaiConnector extends OpenAIConnector {
  XaiConnector({required super.apiKey, super.baseUrl = "https://api.x.ai/v1"});
}
