import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class Message {
  final Content content;

  const Message({required this.content});
}
