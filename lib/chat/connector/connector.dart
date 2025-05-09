import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/result.dart';

abstract class ChatConnector {
  final String apiKey;
  final String baseUrl;

  const ChatConnector({required this.apiKey, required this.baseUrl});

  Future<ChatResult> call(ChatRequest request);
}
