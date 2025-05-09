import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class TextContent extends Content {
  final String text;

  const TextContent({this.text = ""});

  @override
  String toString() => text;
}
