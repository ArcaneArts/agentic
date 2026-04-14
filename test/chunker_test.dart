import 'dart:convert';
import 'dart:io';

import 'package:agentic/ingest/chunker.dart';
import 'package:test/test.dart';

const String _sampleText = '''
Agentic should break long text into ordered chunks.
Each chunk should carry content and a small overlap into the next chunk.
This makes later distillation and retrieval workflows easier to reason about.
These tests are intentionally small so we can swap in larger fixtures later.
''';

Future<List<IChunk>> _collectChunkString({
  required IChunker chunker,
  required String text,
}) => chunker.chunkString(text).toList();

Future<List<IChunk>> _collectChunkStringStream({
  required IChunker chunker,
  required List<String> lines,
}) => chunker.chunkStringStream(Stream<String>.fromIterable(lines)).toList();

Future<List<IChunk>> _collectChunkBytes({
  required IChunker chunker,
  required String text,
}) =>
    chunker
        .chunkByteStream(
          Stream<List<int>>.fromIterable(<List<int>>[utf8.encode(text)]),
        )
        .toList();

Future<List<IChunk>> _collectChunkFile({
  required IChunker chunker,
  required String text,
}) async {
  Directory directory = await Directory.systemTemp.createTemp(
    'agentic-chunker-',
  );
  File file = File('${directory.path}/sample.txt');
  await file.writeAsString(text);
  List<IChunk> chunks = await chunker.chunkTextFile(file).toList();
  await directory.delete(recursive: true);
  return chunks;
}

void _expectBasicChunkInvariants({
  required List<IChunk> chunks,
  required int maxPostOverlap,
}) {
  expect(chunks, isNotEmpty);

  for (int index = 0; index < chunks.length; index++) {
    IChunk chunk = chunks[index];

    expect(chunk.index, index);
    expect(chunk.content, isNotEmpty);
    expect(chunk.charStart, greaterThanOrEqualTo(0));
    expect(chunk.charEnd, chunk.charStart + chunk.fullContent.length);
    expect(chunk.postContent.length, lessThanOrEqualTo(maxPostOverlap));

    if (index == 0) {
      expect(chunk.charStart, 0);
    } else {
      IChunk previous = chunks[index - 1];
      expect(chunk.charStart, previous.charStart + previous.content.length);
    }

    if (index == chunks.length - 1) {
      expect(chunk.postContent, isEmpty);
    } else {
      IChunk next = chunks[index + 1];
      expect(next.content.startsWith(chunk.postContent), isTrue);
    }
  }
}

void main() {
  group('IChunker', () {
    test('keeps short text in a single chunk without overlap', () async {
      IChunker chunker = IChunker(maxChunkSize: 120, maxPostOverlap: 20);
      List<IChunk> chunks = await _collectChunkString(
        chunker: chunker,
        text: 'Short text stays together.',
      );

      expect(chunks, hasLength(1));
      expect(chunks.first.content, 'Short text stays together.');
      expect(chunks.first.postContent, isEmpty);
      expect(chunks.first.charStart, 0);
      expect(chunks.first.charEnd, chunks.first.content.length);
    });

    test(
      'chunks longer text with ordered metadata and bounded overlap',
      () async {
        IChunker chunker = IChunker(maxChunkSize: 64, maxPostOverlap: 16);
        List<IChunk> chunks = await _collectChunkString(
          chunker: chunker,
          text: _sampleText,
        );

        expect(chunks.length, greaterThan(1));
        _expectBasicChunkInvariants(chunks: chunks, maxPostOverlap: 16);
      },
    );

    test(
      'chunkStringStream matches newline-normalized string chunking',
      () async {
        IChunker chunker = IChunker(maxChunkSize: 64, maxPostOverlap: 16);
        List<String> lines = <String>[
          'first line',
          'second line',
          'third line',
          'fourth line',
        ];
        String normalized =
            'first line\nsecond line\nthird line\nfourth line\n';

        List<IChunk> fromStream = await _collectChunkStringStream(
          chunker: chunker,
          lines: lines,
        );
        List<IChunk> fromString = await _collectChunkString(
          chunker: chunker,
          text: normalized,
        );

        expect(
          fromStream.map((chunk) => chunk.fullContent).toList(),
          fromString.map((chunk) => chunk.fullContent).toList(),
        );
        expect(
          fromStream.map((chunk) => chunk.charStart).toList(),
          fromString.map((chunk) => chunk.charStart).toList(),
        );
      },
    );

    test(
      'chunkByteStream matches direct string chunking for utf8 text',
      () async {
        IChunker chunker = IChunker(maxChunkSize: 64, maxPostOverlap: 16);
        List<IChunk> fromBytes = await _collectChunkBytes(
          chunker: chunker,
          text: _sampleText,
        );
        List<IChunk> fromString = await _collectChunkString(
          chunker: chunker,
          text: _sampleText,
        );

        expect(
          fromBytes.map((chunk) => chunk.fullContent).toList(),
          fromString.map((chunk) => chunk.fullContent).toList(),
        );
      },
    );

    test(
      'chunkTextFile reads utf8 text files through the same chunking path',
      () async {
        IChunker chunker = IChunker(maxChunkSize: 64, maxPostOverlap: 16);
        String text =
            'line one\nline two\nline three\nline four\nline five\nline six\n';

        List<IChunk> fromFile = await _collectChunkFile(
          chunker: chunker,
          text: text,
        );
        List<IChunk> fromStream = await _collectChunkStringStream(
          chunker: chunker,
          lines: <String>[
            'line one',
            'line two',
            'line three',
            'line four',
            'line five',
            'line six',
          ],
        );

        expect(
          fromFile.map((chunk) => chunk.fullContent).toList(),
          fromStream.map((chunk) => chunk.fullContent).toList(),
        );
        _expectBasicChunkInvariants(chunks: fromFile, maxPostOverlap: 16);
      },
    );
  });
}
