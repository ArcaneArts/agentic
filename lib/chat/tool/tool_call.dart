import 'package:agentic/chat/agent/agent.dart';

@dmodel
class ToolCall {
  final String id;
  final String name;
  final String arguments;

  const ToolCall({
    required this.id,
    required this.name,
    required this.arguments,
  });
}
