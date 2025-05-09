# Agentic

Use ai but easier

# Chat Connectors
Chat connectors are basically just AI gateways

```dart
ChatConnector openai = OpenAIConnector(apiKey: "sk-proj-...");
ChatConnector anthropic = AnthropicConnector(apiKey: "sk-ant-api03-...");
ChatConnector google = GoogleConnector(apiKey: "...");
ChatConnector xai = XaiConnector(apiKey: "xai-...");
ChatConnector ollama = OLlamaConnector();
```

# Chat Models
Most models are already properly defined for you such as `ChatModel.openai4_1;`. However you can define your own models as needed

```dart
const ChatModel openaiO3 = ChatModel(
    // The real model id
    id: "o3",
    
    // The display name if desired (optional)
    displayName: "o3",
    
    // How much the model costs in USD
    cost: ChatModelCost(input: 10, output: 40),
    
    // Capabilities of this model
    capabilities: ChatModelCapabilities(
      
      // Can it use tools?
      tools: true,
      
      // Makes system messages appear as user messages prefixed (system):
      // Also makes tool messages user messages prefixed (tool <id>):
      ultraCompatibleMode: false,
      
      // There are 3 system modes.
      // - supported: Full support can see system messages
      // - merged: System messages are merged into a systemPrompt field
      // - unsupported: System messages are converted into user messages
      systemMode: ChatModelSystemMode.supported,
      
      // The context window in tokens
      contextWindow: 200000,
      
      // The maximum token output
      maxTokenOutput: 100000,
      
      // What modalities this model can use as inputs
      inputModalities: [Modality.text, Modality.image],
      
      // What modalities this model can use as outputs
      outputModalities: [Modality.text],
      
      // Does this model "reason"
      reasoning: true,
      
      // Does this model support structured outputs?
      structuredOutput: true,
      
      // Is this model streamable output?
      streaming: true,
      
      // Can this model see tool messages? If not
      // They will be prefixed user messages
      seesToolMessages: true,
    ),
);
```

# Basic Usage

```dart
ChatResult result = await openai(
  ChatRequest(
    // Some messages
    messages: [
      Message.system("You are a helpful assistant"),
      Message.user("Why is the sky blue?"),
    ],
    
    // And the model
    model: ChatModel.openai4_1Mini,
  ),
);

print(result.message.content);

// Get the real cost by storing as a fraction
Rational realCost = result.realCost;

// Convert to double with some precision loss
double estimateCost = realCost.toDouble();
```

# Agents
Agents make tool calling and multi-step pipelines much easier

```dart
Agent agent = Agent(
    // Our connector will use openai
    connector: openai,

    // We will use a standard model gpt-4.1
    model: ChatModel.openai4_1,

    // Now, let's setup the initial messages for the agent to run
    chatProvider: MemoryChatProvider(
      messages: [
        // You can use full content 
        // with SystemMessage(content: Content.text("..."))
        Message.system("You are a helpful assistant"),
        Message.user("Why is the sky blue?"),
      ],
    ),
);
```

Then you can use the agent

```dart
// Run the agent and get the response message
// Note: The response message is already added to the chat
AgentMessage message = await agent();
agent.addMessage(Message.user("Make a poem out of this"));
AgentMessage message = await agent();
// and so on.
```

Tools and response format can be added in the agent call as well

# Full Example 

```dart
void main() async {
  // First, we setup the agent
  Agent agent = Agent(
    // Our connector will use openai
    connector: OpenAIConnector(apiKey: "sk-proj-..."),

    // We will use a standard model gpt-4.1
    model: ChatModel.openai4_1,

    // Now, let's setup the initial messages for the agent to run
    chatProvider: MemoryChatProvider(
      messages: [
        SystemMessage(content: Content.text("You are a helpful assistant")),
        UserMessage(
          content: Content.text("Do red and yellow confetti on the screen"),
        ),
      ],
    ),
  );

  // Now, we invoke the agent with this state
  // Note how we add our tool (see below) so the agent can use it
  await agent(tools: [ConfettiTool()]);
  await agent.addMessage(
    UserMessage(content: Content.text("Was confetti run?")),
  );
  await agent(
    responseFormat: ToolSchema(
      name: "Output",
      description: "An output of if confetti was run or not",
      schema: $ConfettiCheck.schema,
    ),
  );
  // At THIS point, the agent has run, then the tool ran, then the agent ran again without tools to explain itself.

  // This is just some stuff to print the final chat state but we could run more stuff too
  print("---");
  for (Message i in await agent.readMessages()) {
    print(
      "${i.runtimeType.toString().replaceAll("Message", "")}: ${i.content}",
    );
  }
  print("---");

  print("Total usage: ${agent.totalUsage}");
}

// To make it easy on ourselves, lets actually data model the tool input json
@Artifact(generateSchema: true) // artifact will generate a schema for us
class ConfettiToolSchema {
  // We need to describe parameters so the ai know what the fuck they are for
  @describe("An array of colors to be used for the confetti colors")
  final List<ConfettiColor> colors;

  const ConfettiToolSchema({this.colors = const []});
}

// Now we define the actual color object which the tool can support multiple of
@Artifact(generateSchema: true)
class ConfettiColor {
  @describe("The red channel of this color 0-255")
  final int r;

  @describe("The green channel of this color 0-255")
  final int g;

  @describe("The blue channel of this color 0-255")
  final int b;

  const ConfettiColor({required this.r, required this.g, required this.b});

  @override
  String toString() => "($r,$g,$b)";
}

// Ok finally, we can actually make the tool with ease
class ConfettiTool extends TransformerTool<ConfettiToolSchema, String> {
  // 1. Override the name and description so the ai knows what this tool is
  ConfettiTool({
    super.name = "confetti",
    super.description =
        "Plays confetti on the user's screen with multiple color options",
  });

  // Lets tell the tool what our schema is. Since we're using artifact, this is cake
  @override
  Map<String, dynamic> get schema => $ConfettiToolSchema.schema;

  @override
  Future<String> callTransform(Agent agent, ConfettiToolSchema request) async {
    // 2. Actually do something
    print("Playing Confetti in ${request.colors.join(" AND ")}");

    // 3. Return a string to the ai so it can explain what the tool did, or an output.
    // The ai sees this but not necessarily the the end user depending on ux
    // The ai will use this to explain itself after all tools have been run by the ai
    return "Confetti played in ${request.colors.join(" , ")}";
  }

  // This is how we decode the ai arguments
  @override
  ConfettiToolSchema decodeInput(Map<String, dynamic> input) =>
      $ConfettiToolSchema.fromMap(input);

  // Since we're just returning a string to the ai we dont need to encode it
  @override
  String encodeOutput(String output) => output;
}

// This is used to check if the ai actually played confetti
@Artifact(generateSchema: true)
class ConfettiCheck {
  @describe("If confetti was played")
  final bool played;

  const ConfettiCheck({this.played = false});
}
```

Which results in

```
Playing Confetti in (255,0,0) AND (255,255,0)

---
System: You are a helpful assistant
User: Do red and yellow confetti on the screen
Agent: 
Tool: Confetti played in (255,0,0) , (255,255,0)
Agent: Here's a burst of red and yellow confetti on your screen! 🎉
If you need more celebrations or want to use different colors, just let me know!
User: Was confetti run?
Agent: {"played":true}
---
```