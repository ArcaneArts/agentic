import 'package:agentic/agentic.dart';

abstract class ChatProvider {
  Future<List<Message>> readMessages();

  Future<void> addMessage(Message message);
}

class MemoryChatProvider extends ChatProvider {
  late final List<Message> messages;

  MemoryChatProvider({List<Message>? messages}) {
    this.messages = messages ?? [];
  }

  @override
  Future<void> addMessage(Message message) async => messages.add(message);

  @override
  Future<List<Message>> readMessages() => Future.value(messages);
}
