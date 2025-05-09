import 'package:agentic/agentic.dart';
import 'package:agentic/chat/content/text_content.dart';
import 'package:artifact/artifact.dart';

@artifact
class Content {
  const Content();

  @override
  String toString() => explode().whereType<TextContent>().join(" ");

  Content and(Content other) =>
      Content.group(explode().followedBy(other.explode()).toList());

  Iterable<Content> explode() sync* {
    if (this is ContentGroup) {
      for (final content in (this as ContentGroup).contents) {
        yield* content.explode();
      }
    } else {
      yield this;
    }
  }

  factory Content.group(List<Content> contents) =>
      ContentGroup(contents: contents);

  factory Content.text(String text) => TextContent(text: text);

  factory Content.imageBase64(String base64Image) =>
      ImageContent(base64Image: base64Image);

  factory Content.imageUrl(String imageUrl) => ImageContent(imageUrl: imageUrl);

  factory Content.audioBase64(String base64Audio) =>
      AudioContent(base64Audio: base64Audio);

  factory Content.audioUrl(String audioUrl) => AudioContent(audioUrl: audioUrl);
}
