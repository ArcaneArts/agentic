import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class Message {
  final Content content;

  const Message({required this.content});

  factory Message.user(String content) =>
      UserMessage(content: Content.text(content));

  factory Message.agent(String content) =>
      AgentMessage(content: Content.text(content));

  factory Message.system(String content) =>
      SystemMessage(content: Content.text(content));

  factory Message.tool(String content, String toolCallId) =>
      ToolMessage(content: Content.text(content), toolCallId: toolCallId);
}
