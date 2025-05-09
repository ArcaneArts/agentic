import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class ContentGroup extends Content {
  final List<Content> contents;

  const ContentGroup({this.contents = const []});
}
