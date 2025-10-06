// Chunk index is an incrementing integer starting from 0. Each chunk increments by 1.
// Chunk content is the string content of the chunk.
// Char start is the starting character index of the chunk in the original source object (inclusive)
// Char end is the ending character index of the chunk in the original source object (exclusive)
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:agentic/ingest/distiller.dart';
import 'package:artifact/artifact.dart';
import 'package:fast_log/fast_log.dart';
import 'package:rxdart/rxdart.dart';

@artifact
class IChunk {
  final int index;
  final String content;
  final String postContent;
  final int charStart;
  final int charEnd;
  final int lod;
  final List<int> from;

  const IChunk({
    required this.index,
    required this.content,
    this.postContent = "",
    this.charStart = 0,
    this.charEnd = 0,
    this.lod = 0,
    this.from = const [],
  });

  String get fullContent => "$content$postContent";
}

class IChunker {
  final int maxChunkSize;
  final int maxPostOverlap;

  const IChunker({this.maxChunkSize = 500, this.maxPostOverlap = 200})
    : assert(maxChunkSize >= 32, "Chunk size must be at least 32 characters"),
      assert(maxPostOverlap >= 0, "Post overlap must be non-negative"),
      assert(
        maxPostOverlap < maxChunkSize,
        "Post overlap must be less than chunk size",
      );

  Stream<IChunk> recursiveDistillChunks({
    required Stream<IChunk> chunks,
    required IDistiller distiller,
    int parallelism = 8,
    int factor = 3,
    bool isBase = true,
  }) async* {
    Queue<IChunk> buffer = Queue<IChunk>();

    Stream<IChunk> distilled =
        distillChunks(
          chunks: chunks.map((i) {
            if (isBase) buffer.add(i);
            return i;
          }),
          distiller: distiller,
          factor: factor,
          parallelism: parallelism,
        ).asBroadcastStream();

    StreamController<IChunk> nextLevelController = StreamController<IChunk>();

    StreamSubscription sub = distilled.listen(nextLevelController.add);

    int c = 0;
    await for (IChunk i in distilled) {
      c++;
      if (isBase) {
        while (buffer.isNotEmpty) {
          yield buffer.removeFirst();
        }
      }
      yield i;
    }

    sub.cancel();
    nextLevelController.close();

    if (c <= factor) {
      return;
    }

    yield* recursiveDistillChunks(
      chunks: nextLevelController.stream,
      distiller: distiller,
      factor: factor,
      parallelism: parallelism,
      isBase: false,
    );
  }

  Stream<IChunk> distillChunks({
    required Stream<IChunk> chunks,
    required IDistiller distiller,
    int parallelism = 8,
    int factor = 3,
  }) async* {
    await for (IChunk i in chunks
        .transform(
          IChunkDistiller(
            distiller: distiller,
            factor: factor,
            parallelism: parallelism,
          ),
        )
        .transform(
          IChunkExploder2(
            factor: factor,
            maxChunkSize: maxChunkSize,
            maxPostOverlap: maxPostOverlap,
          ),
        )) {
      yield i;
    }
  }

  Stream<IChunk> reChunk(Stream<IChunk> chunks) => chunks.transform(
    IChunkExploder2(maxChunkSize: maxChunkSize, maxPostOverlap: maxPostOverlap),
  );

  Stream<IChunk> chunkByteStream(Stream<List<int>> stream) => chunkStringStream(
    stream.transform(utf8.decoder).transform(const LineSplitter()),
  );

  Stream<IChunk> chunkString(String str) =>
      chunkStringStream(Stream.value(str));

  Stream<IChunk> chunkStringStream(Stream<String> str) => str
      .map((v) => "$v\n")
      .transform(TXPieceSplitter(min(maxChunkSize, maxPostOverlap)))
      .transform(TXChunkMerger(maxSize: maxChunkSize, maxPost: maxPostOverlap));

  Stream<IChunk> chunkTextFile(File file) => chunkByteStream(file.openRead());
}

class IChunkDistiller extends StreamTransformerBase<IChunk, IChunk> {
  final int factor;
  final IDistiller distiller;
  final bool lossy;
  final String header;
  final int parallelism;

  const IChunkDistiller({
    this.factor = 3,
    this.header = "",
    this.lossy = true,
    this.parallelism = 1,
    required this.distiller,
  });

  @override
  Stream<IChunk> bind(Stream<IChunk> stream) async* {
    Queue<IChunk> chunks = Queue<IChunk>();

    Future<IChunk> onDistill(List<IChunk> chunks) =>
        distiller.distillFrom(header: header, chunks: chunks, index: 0);

    await for (IChunk chunk in stream) {
      chunks.add(chunk);

      if (parallelism > 1) {
        if (chunks.length >= factor * parallelism) {
          List<Future<IChunk>> futures = [];
          for (int i = 0; i < parallelism; i++) {
            futures.add(onDistill(chunks.take(factor).toList()));
            for (int j = 0; j < factor; j++) {
              chunks.removeFirst();
            }
          }

          for (IChunk c in await Future.wait(futures)) {
            yield c;
          }
        }
      } else {
        if (chunks.length >= factor) {
          yield await onDistill(chunks.take(factor).toList());
          for (int i = 0; i < factor; i++) {
            chunks.removeFirst();
          }
        }
      }
    }

    if (parallelism > 1) {
      List<Future<IChunk>> futures = [];
      while (chunks.length >= factor) {
        futures.add(onDistill(chunks.take(factor).toList()));
        for (int i = 0; i < factor; i++) {
          chunks.removeFirst();
        }
      }

      for (IChunk c in await Future.wait(futures)) {
        yield c;
      }
    } else {
      while (chunks.length >= factor) {
        yield await onDistill(chunks.take(factor).toList());
        for (int i = 0; i < factor; i++) {
          chunks.removeFirst();
        }
      }
    }
  }
}

class IChunkExploder2 extends StreamTransformerBase<IChunk, IChunk> {
  final int maxChunkSize;
  final int maxPostOverlap;
  final int factor;

  const IChunkExploder2({
    this.maxChunkSize = 500,
    this.factor = 3,
    this.maxPostOverlap = 200,
  });

  @override
  Stream<IChunk> bind(Stream<IChunk> stream) async* {
    int level = 0;
    BehaviorSubject<String> buffer = BehaviorSubject<String>();
    Queue<int> referenceBuffer = Queue<int>();
    Stream<IChunk> outBuffer = buffer
        .transform(TXPieceSplitter(min(maxChunkSize, maxPostOverlap) ~/ 2))
        .transform(
          TXChunkMerger(maxSize: maxChunkSize, maxPost: maxPostOverlap),
        )
        .map((i) {
          IChunk c = IChunk(
            index: i.index,
            content: i.content,
            postContent: i.postContent,
            charEnd: i.charEnd,
            charStart: i.charStart,
            lod: level,
            from: referenceBuffer.take(factor + 1).toList(),
          );
          if (referenceBuffer.isNotEmpty && referenceBuffer.length > factor) {
            for (int i = 0; i < factor - 1; i++) {
              referenceBuffer.removeFirst();
            }
          }

          return c;
        });
    Queue<IChunk> outQueue = Queue<IChunk>();
    Completer<bool> onDone = Completer<bool>();
    StreamSubscription<IChunk> hotSwap = outBuffer.listen(
      outQueue.add,
      onDone: () => onDone.complete(true),
    );

    await for (IChunk chunk in stream) {
      level = max(level, chunk.lod);
      referenceBuffer.addAll(chunk.from);
      buffer.add(chunk.fullContent);

      while (outQueue.isNotEmpty) {
        try {
          yield outQueue.removeFirst();
        } catch (_) {
          await Future.delayed(Duration.zero);
        }
      }
    }

    await buffer.close();
    await onDone.future;

    while (outQueue.isNotEmpty) {
      try {
        yield outQueue.removeFirst();
      } catch (_) {
        await Future.delayed(Duration.zero);
      }
    }

    await hotSwap.cancel();
  }
}

class IChunkExploder extends StreamTransformerBase<IChunk, String> {
  final int targetBufferSize;

  const IChunkExploder({this.targetBufferSize = 1000});

  @override
  Stream<String> bind(Stream<IChunk> stream) async* {
    StringBuffer buffer = StringBuffer();

    await for (IChunk chunk in stream) {
      buffer.write(chunk.fullContent);

      if (buffer.length > targetBufferSize) {
        yield buffer.toString();
        buffer.clear();
      }
    }

    if (buffer.isNotEmpty) {
      yield buffer.toString();
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
            index: index++,
            content: content,
            postContent: post,
            charStart: startCursor,
            charEnd: buffer.startCursor + post.length,
          );
        }
      }

      if (buffer.isNotEmpty) {
        int startCursor = buffer.startCursor;
        String content = buffer.takeAll();
        yield IChunk(
          index: index++,
          content: content,
          postContent: "",
          charStart: startCursor,
          charEnd: buffer.startCursor,
        );
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
