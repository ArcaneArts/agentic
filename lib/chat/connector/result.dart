import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';
import 'package:rational/rational.dart';

@artifact
class ChatResult {
  final AgentMessage message;
  final ChatFinishReason finishReason;
  final Map<String, dynamic> metadata;
  final ChatUsage usage;
  final Rational realCost;

  const ChatResult({
    required this.message,
    required this.realCost,
    this.finishReason = ChatFinishReason.unspecified,
    this.metadata = const {},
    this.usage = const ChatUsage(),
  });
}

@artifact
class ChatUsage {
  final int inputTokens;
  final int outputTokens;

  const ChatUsage({this.inputTokens = 0, this.outputTokens = 0});

  operator +(ChatUsage other) => ChatUsage(
    inputTokens: inputTokens + other.inputTokens,
    outputTokens: outputTokens + other.outputTokens,
  );
}

enum ChatFinishReason {
  stop,
  length,
  contentFilter,
  recitation,
  toolCalls,
  unspecified,
}
