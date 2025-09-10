import 'package:agentic/agentic.dart';
import 'package:agentic/chat/agent/chat_provider.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:agentic/util/tools/expression.dart';

Future<void> main() async {
  ConnectedChatModel model = OLlamaConnector().connect(
    ChatModel(
      id: "gpt-oss:20b",
      cost: ChatModelCost(input: 0, output: 0),
      capabilities: ChatModelCapabilities(
        tools: true,
        ultraCompatibleMode: false,
        systemMode: ChatModelSystemMode.supported,
        contextWindow: 128000,
        maxTokenOutput: 32000,
        inputModalities: [Modality.text],
        outputModalities: [Modality.text],
        reasoning: true,
        structuredOutput: true,
        streaming: true,
        seesToolMessages: true,
      ),
    ),
  );

  Agent agent = Agent(
    llm: model,
    chatProvider: MemoryChatProvider(messages: []),
  );

  await agent.addMessage(
    Message.user("""
Whats sin(4 * cos(45)) ^ 4? (Use the expression tool to calculate this for me)
  """),
  );
  AgentMessage msg = await agent(tools: [ToolExpression()]);
  print(msg.content.toString());
}
