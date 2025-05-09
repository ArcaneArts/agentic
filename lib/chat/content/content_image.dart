import 'package:agentic/agentic.dart';
import 'package:artifact/artifact.dart';

@artifact
class ImageContent extends Content {
  final String? imageUrl;
  final String? base64Image;

  const ImageContent({this.imageUrl, this.base64Image})
    : assert(
        imageUrl != null || base64Image != null,
        'Either imageUrl or base64Image must be provided',
      );

  @override
  String toString() => (imageUrl ?? base64Image)!;
}
