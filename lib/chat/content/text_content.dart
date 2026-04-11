import 'package:agentic/agentic.dart';

@dmodel
class TextContent extends Content {
  final String text;

  const TextContent({this.text = ""});

  @override
  String toString() => text;
}
