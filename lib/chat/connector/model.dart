import 'package:agentic/util/cost.dart';
import 'package:artifact/artifact.dart';
import 'package:rational/rational.dart';

@artifact
class ChatModel {
  final String id;
  final String? displayName;
  final ChatModelCost cost;
  final ChatModelCapabilities capabilities;

  const ChatModel({
    required this.id,
    this.displayName,
    required this.cost,
    required this.capabilities,
  });
}

@artifact
class ChatModelCapabilities {
  /// First all tool response messages are converted to system response messages prefixed with (tool <tool_id> called): <tool_response>
  /// Then, all system messages are replaced into user messages prefixed with (system): <system_message>
  final bool ultraCompatibleMode;

  /// Does this model support tool calling?
  final bool tools;

  /// Can this model see tool response messages? If not they will be replaced with system messages
  final bool seesToolMessages;

  /// Does this model support reasoning?
  final bool reasoning;

  /// Does this model support structured output? via JSON or other formats
  final bool structuredOutput;

  /// Does this model support streaming?
  final bool streaming;

  /// The system mode of the model, see [ChatModelSystemMode]
  final ChatModelSystemMode systemMode;

  /// The maximum number of tokens the model can process in a single call
  final int contextWindow;

  /// The maximum number of tokens the model can output in a single call
  final int maxTokenOutput;

  /// The input modalities supported by the model
  final List<Modality> inputModalities;

  /// The output modalities supported by the model
  final List<Modality> outputModalities;

  const ChatModelCapabilities({
    required this.tools,
    required this.ultraCompatibleMode,
    required this.systemMode,
    required this.contextWindow,
    required this.maxTokenOutput,
    required this.inputModalities,
    required this.outputModalities,
    required this.reasoning,
    required this.structuredOutput,
    required this.streaming,
    required this.seesToolMessages,
  });
}

enum Modality { text, image, audio, video }

enum ChatModelSystemMode {
  /// System messages are supported as messages
  supported,

  /// System messages are not supported as messages
  /// They are supported as a separate field in the call
  /// So we need to merge the messages into the system prompt field
  merged,

  /// There is no system message support
  /// Nor is there a system prompt field in the call
  /// We need to use user messages prefixed with (system):
  unsupported,
}

@artifact
class ChatModelCost {
  // USD per 1m input tokens
  final double input;

  // USD per 1m input tokens
  final double output;

  const ChatModelCost({required this.input, required this.output});

  factory ChatModelCost.free() => const ChatModelCost(input: 0, output: 0);

  factory ChatModelCost.io(double input, double output) =>
      ChatModelCost(input: input, output: output);

  Rational getRealCost(int inputTokens, int outputTokens) =>
      (TokenCost.rational(inputTokens, input) +
          TokenCost.rational(outputTokens, output));

  double getEstimatedCost(int inputTokens, int outputTokens) =>
      getRealCost(inputTokens, outputTokens).toDouble();
}
