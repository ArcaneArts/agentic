import 'package:agentic/agentic.dart';
import 'package:rational/rational.dart';

@dmodel
class ARational {
  final String n;
  final String d;

  const ARational({required this.n, this.d = "1"});

  Rational get toRational => Rational(
    BigInt.tryParse(n) ?? BigInt.zero,
    BigInt.tryParse(d) ?? BigInt.one,
  );

  static ARational fromRational(Rational r) =>
      ARational(n: r.numerator.toString(), d: r.denominator.toString());
}

@dmodel
class ChatResult {
  final AgentMessage message;
  final ChatFinishReason finishReason;
  final Map<String, dynamic> metadata;
  final ChatUsage usage;
  final ARational realCost;

  const ChatResult({
    required this.message,
    required this.realCost,
    this.finishReason = ChatFinishReason.unspecified,
    this.metadata = const {},
    this.usage = const ChatUsage(),
  });
}

@dmodel
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
