import 'package:agentic/chat/agent/agent.dart';

@dmodel
class ToolSchema {
  final String name;
  final String description;
  final Map<String, dynamic> schema;

  const ToolSchema({
    required this.name,
    required this.description,
    required this.schema,
  });
}
