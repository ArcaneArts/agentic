import 'package:agentic/agentic.dart';

@dmodel
class AgentMessage extends Message {
  final List<ToolCall> toolCalls;

  const AgentMessage({required super.content, this.toolCalls = const []});
}
