// Chunk index is an incrementing integer starting from 0. Each chunk increments by 1.
// Chunk content is the string content of the chunk.
// Char start is the starting character index of the chunk in the original source object (inclusive)
// Char end is the ending character index of the chunk in the original source object (exclusive)
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fast_log/fast_log.dart';

class IChunk {
  final int index;
  final String content;
  final int charStart;
  final int charEnd;

  IChunk(this.index, this.content, this.charStart, this.charEnd);
}

class IChunker {
  static Stream<IChunk> chunkTextFile({
    required File file,
    required int maxChunkSize,
    required int maxPostOverlap,
  }) async* {
    _checkSizing(maxChunkSize, maxPostOverlap);
    yield* file
        .openRead()
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .map((v) => "$v\n")
        .transform(TXPieceSplitter(min(maxChunkSize, maxPostOverlap)))
        .transform(
          TXChunkMerger(maxSize: maxChunkSize, maxPost: maxPostOverlap),
        );
  }

  static void _checkSizing(int size, int post) {
    if (size < 32) {
      throw ArgumentError("Chunk size must be at least 10 characters");
    }
    if (post < 0) {
      throw ArgumentError("Post overlap must be non-negative");
    }
    if (post >= size) {
      throw ArgumentError("post overlap must be less than chunk size");
    }
  }
}

class TXChunkMerger extends StreamTransformerBase<String, IChunk> {
  final int maxSize;
  final int maxPost;

  const TXChunkMerger({required this.maxSize, required this.maxPost});

  @override
  Stream<IChunk> bind(Stream<String> stream) async* {
    try {
      PieceQueue buffer = PieceQueue();
      int index = 0;

      await for (String piece in stream) {
        buffer.add(piece);

        if (buffer.canTake(maxSize)) {
          int startCursor = buffer.startCursor;
          String content = buffer.take(maxSize - maxPost);
          String post = buffer.peek(maxPost);

          yield IChunk(
            index++,
            "$content$post",
            startCursor,
            buffer.startCursor + post.length,
          );
        }
      }

      if (buffer.isNotEmpty) {
        int startCursor = buffer.startCursor;
        String content = buffer.takeAll();
        yield IChunk(index++, content, startCursor, buffer.startCursor);
      }
    } catch (e, es) {
      error(e);
      error(es);
    }
  }
}

class PieceQueue {
  final Queue<String> queue = Queue<String>();
  int charLength = 0;
  int startCursor = 0;
  int endCursor = 0;

  PieceQueue();

  bool canTake(int length) => charLength >= length;

  String peek(int length) {
    if (length < 0) {
      return "";
    }

    if (!canTake(length)) {
      throw StateError("Not enough characters in queue to peek $length");
    }

    StringBuffer sb = StringBuffer();

    for (String piece in queue) {
      if (sb.length + piece.length > length) {
        break;
      }

      sb.write(piece);
    }

    return sb.toString();
  }

  String takeAll() => take(charLength);

  String take(int length) {
    if (length < 0) {
      return "";
    }

    if (!canTake(length)) {
      throw StateError("Not enough characters in queue to take $length");
    }

    StringBuffer sb = StringBuffer();
    while (sb.length < length && queue.isNotEmpty) {
      String piece = queue.first;
      if (sb.length + piece.length < length) {
        sb.write(removeFirst());
      } else {
        break;
      }
    }

    return sb.toString();
  }

  void add(String piece) {
    queue.addLast(piece);
    charLength += piece.length;
    endCursor += piece.length;
  }

  void clear() {
    queue.clear();
    charLength = 0;
    startCursor = 0;
    endCursor = 0;
  }

  String removeLast() {
    if (queue.isNotEmpty) {
      String piece = queue.removeLast();
      charLength -= piece.length;
      endCursor -= piece.length;
      return piece;
    }

    throw StateError("No pieces in queue to remove");
  }

  String removeFirst() {
    if (queue.isNotEmpty) {
      String piece = queue.removeFirst();
      charLength -= piece.length;
      startCursor += piece.length;
      return piece;
    }

    throw StateError("No pieces in queue to remove");
  }

  bool get isEmpty => queue.isEmpty;
  bool get isNotEmpty => queue.isNotEmpty;
  int get queueLength => queue.length;
}

class TXPieceSplitter extends StreamTransformerBase<String, String> {
  final int? maxPieceSize;

  TXPieceSplitter(this.maxPieceSize);

  @override
  Stream<String> bind(Stream<String> stream) =>
      stream.smartPieces(maxPieceSize).map((v) {
        return v;
      });
}

extension XStreamDistiller on Stream<String> {
  Stream<String> smartPieces([int? maxPieceSize]) async* {
    List<List<String>> partBuffer = [];
    await for (String piece in this) {
      partBuffer.add(piece.smartSplit(maxPieceSize).toList());

      if (partBuffer.length > 1) {
        partBuffer[1].insertAll(
          0,
          "${partBuffer[0].removeLast()}${partBuffer[1].removeAt(0)}"
              .smartSplit(maxPieceSize)
              .toList(),
        );
        yield* Stream.fromIterable(partBuffer.removeAt(0));
      }
    }

    yield* Stream.fromIterable(partBuffer.expand((v) => v));
  }
}

extension XSTRIT on Iterable<String> {
  Iterable<String> smartExpand([int? maxPieceSize]) sync* {
    if (maxPieceSize != null) {
      for (String i in this) {
        if (i.length <= maxPieceSize) {
          yield i;
        } else {
          for (int j = 0; j < i.length; j += maxPieceSize) {
            yield i.substring(
              j,
              j + maxPieceSize < i.length ? j + maxPieceSize : i.length,
            );
          }
        }
      }
    } else {
      yield* this;
    }
  }
}

extension XSTR on String {
  Iterable<String> smartSplit([int? maxPieceSize]) => multiSplitW(const [
    "\n",
    " ",
    ".",
    ",",
    ";",
    "\"",
    ":",
    "!",
    "?",
    "(",
    ")",
    "[",
    "]",
    "{",
    "}",
    "\r",
    "\t",
    "-",
    "_",
    "'",
    "—",
    "–",
    "…",
    "‘",
    "’",
    "“",
    "”",
    "«",
    "»",
    "‹",
    "›",
    ">",
    "<",
    "/",
    "=",
    "\\",
    "+",
    "*",
    "&",
    "@",
    "#",
    "%",
    "\$",
    "^",
    "|",
    "`",
    "~",
  ]).smartExpand(maxPieceSize);

  Iterable<String> multiSplitW(List<String> seps) sync* {
    Iterable<String> pieces = [this];

    for (String i in seps) {
      pieces = pieces.expand((v) => v.splitW(i));
    }

    yield* pieces;
  }

  Iterable<String> splitW(String sep) sync* {
    if (!contains(sep)) {
      yield this;
      return;
    }

    List<String> pieces = split(sep);
    for (int i = 0; i < pieces.length; i++) {
      if (i == pieces.length - 1) {
        yield pieces[i];
      } else {
        yield "${pieces[i]}$sep";
      }
    }

    if (pieces.isEmpty) {
      yield this;
    }
  }
}
