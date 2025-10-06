import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:agentic/chat/connector/model.dart';
import 'package:agentic/chat/connector/result.dart';

abstract class ChatConnector {
  final String apiKey;
  final String baseUrl;

  const ChatConnector({required this.apiKey, required this.baseUrl});

  Future<ChatResult> call(ChatRequest request);

  List<ChatModel> get supportedModels;

  ConnectedChatModel connect(ChatModel model) =>
      ConnectedChatModel(connector: this, model: model);
}

mixin EmbedProvider {
  Future<List<double>> embed({
    required String model,
    required String text,
    int? dimensions,
  });

  Future<List<List<double>>> embedMultiple({
    required String model,
    required List<String> texts,
    int? dimensions,
  });
}
