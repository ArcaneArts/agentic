import 'package:agentic/chat/connector/model.dart';
import 'package:agentic/util/naga_models.dart';

import 'connector_openai.dart';

class NagaConnector extends OpenAIConnector {
  const NagaConnector({
    required super.apiKey,
    super.baseUrl = "https://api.naga.ac/v1",
  });

  @override
  List<ChatModel> get supportedModels => nagaChatModels;
}
