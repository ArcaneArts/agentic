import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class AudioContent extends Content {
  final String? audioUrl;
  final String? base64Audio;

  const AudioContent({this.audioUrl, this.base64Audio})
    : assert(
        audioUrl != null || base64Audio != null,
        'Either audioUrl or base64Audio must be provided',
      );

  @override
  String toString() => (audioUrl ?? base64Audio)!;
}
