import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:agentic/chat/connector/model.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/chat/content/content.dart';

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
  ConnectedEmbeddingModel asEmbedder(String model, {int? dimensions}) =>
      ConnectedEmbeddingModel(
        model: model,
        provider: this,
        dimensions: dimensions,
      );

  Future<List<double>> embed({
    required String model,
    required Content content,
    int? dimensions,
  });

  Future<List<List<double>>> embedMultiple({
    required String model,
    required List<Content> contents,
    int? dimensions,
  });
}
