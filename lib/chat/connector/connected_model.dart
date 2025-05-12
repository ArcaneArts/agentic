import 'package:agentic/agentic.dart';

class ConnectedChatModel {
  final ChatModel model;
  final ChatConnector connector;

  const ConnectedChatModel({required this.model, required this.connector});
}
