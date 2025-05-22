import 'package:agentic/agentic.dart';
import 'package:yaml_edit/yaml_edit.dart';

@pragma('vm:entry-point')
abstract class Tool {
  final String name;
  final String description;

  Map<String, dynamic> get schema;

  ToolSchema get toolSchema =>
      ToolSchema(name: name, description: description, schema: schema);

  const Tool({required this.name, required this.description});

  Future<String> call({
    required Agent agent,
    required Map<String, dynamic> arguments,
  });
}

@pragma('vm:entry-point')
abstract class TransformerTool<I, O> extends Tool {
  TransformerTool({required super.name, required super.description});

  Future<O> callTransform(Agent agent, I i);

  I decodeInput(Map<String, dynamic> input);

  dynamic encodeOutput(O output);

  @override
  Future<String> call({
    required Agent agent,
    required Map<String, dynamic> arguments,
  }) async {
    I input = decodeInput(arguments);
    O output = await callTransform(agent, input);
    dynamic o = encodeOutput(output);

    if (o is String) {
      return o;
    }

    return (YamlEditor("")..update([], o)).toString();
  }
}
