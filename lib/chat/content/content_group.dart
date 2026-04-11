import 'package:agentic/agentic.dart';

@dmodel
class ContentGroup extends Content {
  final List<Content> contents;

  const ContentGroup({this.contents = const []});
}
