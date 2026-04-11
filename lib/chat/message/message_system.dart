import 'package:agentic/agentic.dart';

@dmodel
class SystemMessage extends Message {
  const SystemMessage({required super.content});

  UserMessage get asUserSystemMessage =>
      UserMessage(content: Content.text("(system): ${content.toString()}"));
}
