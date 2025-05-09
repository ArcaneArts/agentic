import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class AgentMessage extends Message {
  final List<ToolCall> toolCalls;

  const AgentMessage({required super.content, this.toolCalls = const []});
}
