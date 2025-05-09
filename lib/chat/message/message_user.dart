import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class UserMessage extends Message {
  const UserMessage({required super.content});
}
