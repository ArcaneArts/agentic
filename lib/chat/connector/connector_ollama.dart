import 'connector_openai.dart';

class OLlamaConnector extends OpenAIConnector {
  OLlamaConnector({
    super.apiKey = "",
    super.baseUrl = "http://localhost:11434/v1",
  });
}
