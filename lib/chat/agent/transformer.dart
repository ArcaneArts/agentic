// Represents a transformer that takes an input to an agent then returns an output back
import 'dart:convert';

import 'package:agentic/agentic.dart';

abstract class Transformer<I, O> {
  const Transformer();

  Content inputToAgentMessage(I input);

  O decodeOutput(Map<String, dynamic> output);

  String get instructions;

  ToolSchema? get responseFormat;

  List<Tool> get tools;

  Future<O> call(Agent agent, I input) async {
    if (responseFormat == null && O is! String) {
      throw Exception("Response format is required for non-string output type");
    }

    await agent.addMessage(SystemMessage(content: Content.text(instructions)));
    await agent.addMessage(UserMessage(content: inputToAgentMessage(input)));

    AgentMessage message = await agent(
      responseFormat: responseFormat,
      tools: tools,
    );

    if (responseFormat != null) {
      return decodeOutput(jsonDecode(message.content.toString()));
    }

    return message.content.toString() as O;
  }
}

class StringTransformer extends Transformer<String, String> {
  @override
  final List<Tool> tools;

  @override
  final String instructions;

  const StringTransformer({this.tools = const [], required this.instructions});

  @override
  ToolSchema? get responseFormat => null;

  @override
  Content inputToAgentMessage(String input) => Content.text(input);

  @override
  String decodeOutput(Map<String, dynamic> output) => output.toString();
}

abstract class StringToObjectTransformer<O> extends Transformer<String, O> {
  @override
  final List<Tool> tools;

  @override
  final String instructions;

  const StringToObjectTransformer({
    this.tools = const [],
    required this.instructions,
  });

  @override
  ToolSchema? get responseFormat => null;

  @override
  Content inputToAgentMessage(String input) => Content.text(input);
}

abstract class ObjectToObjectTransformer<I, O> extends Transformer<I, O> {
  @override
  final List<Tool> tools;

  @override
  final String instructions;

  const ObjectToObjectTransformer({
    this.tools = const [],
    required this.instructions,
  });

  @override
  ToolSchema get responseFormat;
}
