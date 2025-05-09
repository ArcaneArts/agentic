import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class ToolMessage extends Message {
  final String toolCallId;

  const ToolMessage({required super.content, required this.toolCallId});

  SystemMessage get toolAsSystemMessage => SystemMessage(
    content: Content.text("(tool $toolCallId called): $content"),
  );
}
