import 'package:agentic/agentic.dart';

class ConnectedChatModel {
  final ChatModel model;
  final ChatConnector connector;

  const ConnectedChatModel({required this.model, required this.connector});
}

class ConnectedEmbeddingModel {
  final int? dimensions;
  final String model;
  final EmbedProvider provider;

  const ConnectedEmbeddingModel({
    required this.model,
    required this.provider,
    this.dimensions,
  });

  Future<List<double>> embed(String text) =>
      provider.embed(model: model, text: text, dimensions: dimensions);

  Future<List<List<double>>> embedMultiple(List<String> texts) => provider
      .embedMultiple(model: model, texts: texts, dimensions: dimensions);
}
