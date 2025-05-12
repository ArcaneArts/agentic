import 'dart:convert';

import 'package:agentic/agentic.dart';
import 'package:agentic/chat/agent/chat_provider.dart';
import 'package:agentic/chat/connector/connected_model.dart';

abstract class RawTransformer<I, O> {
  final String? user;
  final ConnectedChatModel llm;
  final List<Tool> tools;
  final int maxRecursiveToolCalls;
  final String instructions;

  const RawTransformer({
    required this.llm,
    this.user,
    required this.instructions,
    this.tools = const [],
    this.maxRecursiveToolCalls = 1,
  });

  Future<Content> toAgent(I i) => Future.value(Content.text(i.toString()));

  O fromAgent(Map<String, dynamic> s) =>
      throw UnimplementedError(
        "You need to implement fromAgent in $runtimeType to convert '$s' to an $O object!",
      );

  Future<List<Tool>?> getTools() async => null;

  Future<String?> getInstructions() async => null;

  ToolSchema? get outputSchema => null;

  Future<O> call(I i) async {
    List<dynamic> v = await Future.wait([
      getInstructions().then((i) => i ?? instructions),
      toAgent(i),
      getTools().then((i) => i ?? tools),
    ]);
    AgentMessage m = await Agent(
      llm: llm,
      chatProvider: MemoryChatProvider(
        messages: [Message.system(v[0]), UserMessage(content: v[1])],
      ),
      user: user,
    )(tools: v[2], responseFormat: outputSchema);

    if (O is String) {
      return m.content.toString() as O;
    }

    return fromAgent(jsonDecode(m.content.toString()));
  }
}

class StringToStringTransformer extends RawTransformer<String, String> {
  StringToStringTransformer({
    required super.llm,
    required super.instructions,
    super.maxRecursiveToolCalls = 1,
    super.user,
    super.tools = const [],
  });
}

abstract class StringToObjectTransformer<O> extends RawTransformer<String, O> {
  StringToObjectTransformer({
    required super.llm,
    required super.instructions,
    super.maxRecursiveToolCalls = 1,
    super.user,
    super.tools = const [],
  });

  @override
  O fromAgent(Map<String, dynamic> s);

  @override
  ToolSchema? get outputSchema;
}

abstract class ObjectToStringTransformer<I> extends RawTransformer<I, String> {
  ObjectToStringTransformer({
    required super.llm,
    required super.instructions,
    super.maxRecursiveToolCalls = 1,
    super.user,
    super.tools = const [],
  });

  @override
  Future<Content> toAgent(I i);
}

abstract class ObjectToObjectTransformer<I, O> extends RawTransformer<I, O> {
  ObjectToObjectTransformer({
    required super.llm,
    required super.instructions,
    super.maxRecursiveToolCalls = 1,
    super.user,
    super.tools = const [],
  });

  @override
  O fromAgent(Map<String, dynamic> s);

  @override
  ToolSchema? get outputSchema;

  @override
  Future<Content> toAgent(I i);
}
