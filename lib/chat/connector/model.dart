import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:artifact/artifact.dart';

@artifact
class ChatModel {
  final String id;
  final String? displayName;
  final ChatModelCost cost;
  final ChatModelCapabilities capabilities;
  final bool deprecated;

  const ChatModel({
    required this.id,
    this.displayName,
    required this.cost,
    required this.capabilities,
    this.deprecated = false,
  });

  ConnectedChatModel connect(ChatConnector connector) =>
      ConnectedChatModel(model: this, connector: connector);

  static const ChatModel mercuryCoder = ChatModel(
    id: "mercury-coder",
    displayName: "Mercury Coder",
    cost: ChatModelCost(input: 0.25, output: 1),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 32000,
      maxTokenOutput: 8192,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: false,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel mercury = ChatModel(
    id: "mercury",
    displayName: "Mercury",
    cost: ChatModelCost(input: 0.25, output: 1),
    capabilities: ChatModelCapabilities(
      tools: false,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 32000,
      maxTokenOutput: 8192,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: false,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel xaiGrok4 = ChatModel(
    id: "grok-4",
    displayName: "Grok 4",
    cost: ChatModelCost(input: 6, output: 30),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 256000,
      maxTokenOutput: 16385,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel xaiGrok3 = ChatModel(
    id: "grok-3",
    displayName: "Grok 3",
    cost: ChatModelCost(input: 3, output: 15),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 131072,
      maxTokenOutput: 16385,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel xaiGrok3Fast = ChatModel(
    id: "grok-3-fast",
    displayName: "Grok 3 Fast",
    cost: ChatModelCost(input: 5, output: 25),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 131072,
      maxTokenOutput: 16385,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel xaiGrok3Mini = ChatModel(
    id: "grok-3-mini",
    displayName: "Grok 3 Mini",
    cost: ChatModelCost(input: 0.30, output: 0.50),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 131072,
      maxTokenOutput: 16385,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel xaiGrok3MiniFast = ChatModel(
    id: "grok-3-mini-fast",
    displayName: "Grok 3 Mini Fast",
    cost: ChatModelCost(input: 0.60, output: 4),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 131072,
      maxTokenOutput: 16385,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel googleGemini2_5Pro = ChatModel(
    id: "gemini-2.5-pro",
    displayName: "Gemini 2.5 Pro",
    cost: ChatModelCost(input: 2.50, output: 15),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1048576,
      maxTokenOutput: 65536,
      inputModalities: [
        Modality.text,
        Modality.image,
        Modality.audio,
        Modality.video,
      ],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel googleGemini2_5Flash = ChatModel(
    id: "gemini-2.5-flash",
    displayName: "Gemini 2.5 Flash",
    cost: ChatModelCost(input: 0.15, output: 0.60),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1048576,
      maxTokenOutput: 65536,
      inputModalities: [
        Modality.text,
        Modality.image,
        Modality.audio,
        Modality.video,
      ],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel googleGemini2Flash = ChatModel(
    id: "gemini-2.0-flash",
    deprecated: true,
    displayName: "Gemini 2.0 Flash",
    cost: ChatModelCost(input: 0.1, output: 0.40),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1048576,
      maxTokenOutput: 8192,
      inputModalities: [
        Modality.text,
        Modality.image,
        Modality.audio,
        Modality.video,
      ],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel googleGemini2_5FlashLite = ChatModel(
    id: "gemini-2.5-flash-lite-preview-06-17",
    deprecated: true,
    displayName: "Gemini 2.5 Flash Lite",
    cost: ChatModelCost(input: 0.10, output: 0.40),
    capabilities: ChatModelCapabilities(
      tools: false,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1000000,
      maxTokenOutput: 64000,
      inputModalities: [
        Modality.text,
        Modality.image,
        Modality.audio,
        Modality.video,
      ],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel googleGemini2FlashLite = ChatModel(
    id: "gemini-2.0-flash-lite",
    deprecated: true,
    displayName: "Gemini 2.0 Flash Lite",
    cost: ChatModelCost(input: 0.075, output: 0.30),
    capabilities: ChatModelCapabilities(
      tools: false,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1048576,
      maxTokenOutput: 8192,
      inputModalities: [
        Modality.text,
        Modality.image,
        Modality.audio,
        Modality.video,
      ],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel anthropicClaude4Opus = ChatModel(
    id: "claude-opus-4-0",
    displayName: "Claude 4 Opus",
    cost: ChatModelCost(input: 15, output: 75),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 32000,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: false,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel anthropicClaude4Sonnet = ChatModel(
    id: "	claude-sonnet-4-0",
    displayName: "Claude 4 Sonnet",
    cost: ChatModelCost(input: 3, output: 15),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 64000,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: false,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel anthropicClaude3_7Sonnet = ChatModel(
    id: "claude-3-7-sonnet-latest",
    displayName: "Claude 3.7 Sonnet",
    cost: ChatModelCost(input: 3, output: 15),
    deprecated: true,
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 64000,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: false,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel anthropicClaude3_5Haiku = ChatModel(
    id: "claude-3-5-haiku-latest",
    displayName: "Claude 3.5 Haiku",
    cost: ChatModelCost(input: 0.8, output: 4),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 8192,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: false,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openaiO4Mini = ChatModel(
    id: "o4-mini",
    displayName: "o4 Mini",
    cost: ChatModelCost(input: 1.10, output: 4.40),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 100000,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openaiO3 = ChatModel(
    id: "o3",
    displayName: "o3",
    cost: ChatModelCost(input: 2, output: 8),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 100000,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openaiO3Mini = ChatModel(
    id: "o3-mini",
    deprecated: true,
    displayName: "o3 Mini",
    cost: ChatModelCost(input: 1.10, output: 4.40),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 100000,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openaiO1Pro = ChatModel(
    id: "o1-pro",
    deprecated: true,
    displayName: "o1 Pro",
    cost: ChatModelCost(input: 150, output: 600),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 100000,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openaiO1 = ChatModel(
    id: "o1",
    deprecated: true,
    displayName: "o1",
    cost: ChatModelCost(input: 15, output: 60),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 200000,
      maxTokenOutput: 100000,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openaiO1Mini = ChatModel(
    id: "o1-mini",
    deprecated: true,
    displayName: "o1 Mini",
    cost: ChatModelCost(input: 1.10, output: 4.40),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 128000,
      maxTokenOutput: 65536,
      inputModalities: [Modality.text],
      outputModalities: [Modality.text],
      reasoning: true,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openai4_1 = ChatModel(
    id: "gpt-4.1",
    displayName: "4.1",
    cost: ChatModelCost(input: 2, output: 8),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1047576,
      maxTokenOutput: 32768,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openai4_1Mini = ChatModel(
    id: "gpt-4.1-mini",
    displayName: "4.1 Mini",
    cost: ChatModelCost(input: 0.40, output: 1.60),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1047576,
      maxTokenOutput: 32768,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openai4_1Nano = ChatModel(
    id: "gpt-4.1-nano",
    displayName: "4.1 Nano",
    cost: ChatModelCost(input: 0.10, output: 0.40),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 1047576,
      maxTokenOutput: 32768,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openai4o = ChatModel(
    id: "gpt-4o",
    deprecated: true,
    displayName: "4o",
    cost: ChatModelCost(input: 2.50, output: 10),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 128000,
      maxTokenOutput: 16384,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );

  static const ChatModel openai4oMini = ChatModel(
    id: "gpt-4o-mini",
    deprecated: true,
    displayName: "4o Mini",
    cost: ChatModelCost(input: 0.15, output: 0.60),
    capabilities: ChatModelCapabilities(
      tools: true,
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: 128000,
      maxTokenOutput: 16384,
      inputModalities: [Modality.text, Modality.image],
      outputModalities: [Modality.text],
      reasoning: false,
      structuredOutput: true,
      streaming: true,
      seesToolMessages: true,
    ),
  );
}
