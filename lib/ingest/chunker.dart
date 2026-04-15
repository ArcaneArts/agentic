import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:agentic/chat/agent/agent.dart';
import 'package:agentic/ingest/distiller.dart';
import 'package:bpe/bpe.dart';
import 'package:fast_log/fast_log.dart';
import 'package:fire_api/fire_api.dart';
import 'package:rxdart/rxdart.dart';

@dmodel
class Chunk {
  final int index;
  final String content;
  final String postContent;
  final int charStart;
  final int charEnd;
  final int lod;
  final int? up;
  final List<int>? down;
  final String? record;
  final Map<String, dynamic> metadata;
  final VectorValue? vector;

  const Chunk({
    required this.index,
    required this.content,
    this.record,
    this.vector,
    this.metadata = const {},
    this.postContent = "",
    this.charStart = 0,
    this.charEnd = 0,
    this.lod = 0,
    this.down,
    this.up,
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

  int get _contentChunkSize => max(1, maxChunkSize - maxPostOverlap);

  int get _cleanChunkSize => max(1, _contentChunkSize ~/ 2);

  int get _cleanChunkGrace => max(1, _contentChunkSize ~/ 4);

  Stream<Chunk> _adaptChunkStream(Stream<SourceChunk> chunks) async* {
    SourceChunk? previous;

    await for (SourceChunk chunk in chunks) {
      if (previous != null) {
        yield _adaptChunk(previous, next: chunk);
      }

      previous = chunk;
    }

    if (previous != null) {
      yield _adaptChunk(previous);
    }
  }

  Stream<SourceChunk> _chunkStream(Stream<String> rawFeed) async* {
    int start = 0;
    int lengthBuffer = 0;
    List<String> buffer = [];
    int index = 0;

    await for (String piece in rawFeed.cleanChunks(
      size: _cleanChunkSize,
      grace: _cleanChunkGrace,
    )) {
      buffer.add(piece);
      lengthBuffer += piece.length;

      if (lengthBuffer >= _contentChunkSize &&
          lengthBuffer - piece.length <= _contentChunkSize) {
        String content = buffer.sublist(0, buffer.length - 1).join();
        SourceChunk chunk = SourceChunk(
          index: index++,
          start: start,
          length: lengthBuffer - piece.length,
          content: content,
        );

        start += chunk.length;
        lengthBuffer = piece.length;
        buffer = [piece];
        yield chunk;
      }
    }

    if (buffer.isNotEmpty) {
      yield SourceChunk(
        index: index++,
        start: start,
        length: lengthBuffer,
        content: buffer.join(),
      );
    }
  }

  Chunk _adaptChunk(SourceChunk chunk, {SourceChunk? next}) {
    String postContent = _buildPostContent(next?.content ?? "");

    return Chunk(
      index: chunk.index,
      content: chunk.content,
      postContent: postContent,
      charStart: chunk.start,
      charEnd: chunk.start + chunk.length + postContent.length,
      lod: 0,
    );
  }

  String _buildPostContent(String nextContent) {
    if (maxPostOverlap <= 0 || nextContent.isEmpty) {
      return "";
    }

    if (nextContent.length <= maxPostOverlap) {
      return nextContent;
    }

    String capped = nextContent.substring(0, maxPostOverlap);
    int whitespace = capped.lastIndexOf(RegExp(r'\s'));

    if (whitespace <= 0) {
      return capped;
    }

    return capped.substring(0, whitespace + 1);
  }

  Stream<Chunk> recursiveDistillChunks({
    required Stream<Chunk> chunks,
    required IDistiller distiller,
    int parallelism = 8,
    int factor = 3,
    bool isBase = true,
  }) async* {
    Queue<Chunk> buffer = Queue<Chunk>();

    Stream<Chunk> distilled =
        distillChunks(
          chunks: chunks.map((i) {
            if (isBase) buffer.add(i);
            return i;
          }),
          distiller: distiller,
          factor: factor,
          parallelism: parallelism,
        ).asBroadcastStream();

    StreamController<Chunk> nextLevelController = StreamController<Chunk>();

    StreamSubscription sub = distilled.listen(nextLevelController.add);

    int c = 0;
    await for (Chunk i in distilled) {
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

  Stream<Chunk> distillChunks({
    required Stream<Chunk> chunks,
    required IDistiller distiller,
    int parallelism = 8,
    int factor = 3,
  }) async* {
    await for (Chunk i in chunks
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

  Stream<Chunk> reChunk(Stream<Chunk> chunks) => chunks.transform(
    IChunkExploder2(maxChunkSize: maxChunkSize, maxPostOverlap: maxPostOverlap),
  );

  Stream<Chunk> chunkByteStream(Stream<List<int>> stream) =>
      _adaptChunkStream(_chunkStream(stream.transform(utf8.decoder)));

  Stream<Chunk> chunkString(String str) =>
      _adaptChunkStream(_chunkStream(Stream.value(str)));

  Stream<Chunk> chunkStringStream(Stream<String> str) => _adaptChunkStream(
    _chunkStream(str.map((value) => value.endsWith('\n') ? value : "$value\n")),
  );

  Stream<Chunk> chunkTextFile(File file) => chunkStringStream(
    file.openRead().transform(utf8.decoder).transform(const LineSplitter()),
  );
}

class SourceChunk {
  final int index;
  final int start;
  final int length;
  final String content;

  const SourceChunk({
    required this.index,
    required this.start,
    required this.length,
    required this.content,
  });
}

class IChunkDistiller extends StreamTransformerBase<Chunk, Chunk> {
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

  Future<Chunk> _distill(List<Chunk> chunks) =>
      distiller.distillFrom(header: header, chunks: chunks, index: 0);

  @override
  Stream<Chunk> bind(Stream<Chunk> stream) async* {
    Queue<Chunk> chunks = Queue<Chunk>();

    await for (Chunk chunk in stream) {
      chunks.add(chunk);

      if (parallelism > 1) {
        if (chunks.length >= factor * parallelism) {
          List<Future<Chunk>> futures = [];
          for (int i = 0; i < parallelism; i++) {
            futures.add(_distill(chunks.take(factor).toList()));
            for (int j = 0; j < factor; j++) {
              chunks.removeFirst();
            }
          }

          for (Chunk c in await Future.wait(futures)) {
            yield c;
          }
        }
      } else {
        if (chunks.length >= factor) {
          yield await _distill(chunks.take(factor).toList());
          for (int i = 0; i < factor; i++) {
            chunks.removeFirst();
          }
        }
      }
    }

    if (parallelism > 1) {
      List<Future<Chunk>> futures = [];
      while (chunks.length >= factor) {
        futures.add(_distill(chunks.take(factor).toList()));
        for (int i = 0; i < factor; i++) {
          chunks.removeFirst();
        }
      }

      for (Chunk c in await Future.wait(futures)) {
        yield c;
      }
    } else {
      while (chunks.length >= factor) {
        yield await _distill(chunks.take(factor).toList());
        for (int i = 0; i < factor; i++) {
          chunks.removeFirst();
        }
      }
    }
  }
}

class IChunkExploder2 extends StreamTransformerBase<Chunk, Chunk> {
  final int maxChunkSize;
  final int maxPostOverlap;
  final int factor;

  const IChunkExploder2({
    this.maxChunkSize = 500,
    this.factor = 3,
    this.maxPostOverlap = 200,
  });

  @override
  Stream<Chunk> bind(Stream<Chunk> stream) async* {
    int level = 0;
    BehaviorSubject<String> buffer = BehaviorSubject<String>();
    Queue<int> referenceBuffer = Queue<int>();
    Stream<Chunk> outBuffer = buffer
        .transform(TXPieceSplitter(min(maxChunkSize, maxPostOverlap) ~/ 2))
        .transform(
          TXChunkMerger(maxSize: maxChunkSize, maxPost: maxPostOverlap),
        )
        .map((i) {
          Chunk c = Chunk(
            index: i.index,
            content: i.content,
            postContent: i.postContent,
            charEnd: i.charEnd,
            charStart: i.charStart,
            lod: level,
            down: referenceBuffer.take(factor + 1).toList(),
          );
          if (referenceBuffer.isNotEmpty && referenceBuffer.length > factor) {
            for (int i = 0; i < factor - 1; i++) {
              referenceBuffer.removeFirst();
            }
          }

          return c;
        });
    Queue<Chunk> outQueue = Queue<Chunk>();
    Completer<bool> onDone = Completer<bool>();
    StreamSubscription<Chunk> hotSwap = outBuffer.listen(
      outQueue.add,
      onDone: () => onDone.complete(true),
    );

    await for (Chunk chunk in stream) {
      level = max(level, chunk.lod);
      referenceBuffer.addAll(chunk.down ?? []);
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

class IChunkExploder extends StreamTransformerBase<Chunk, String> {
  final int targetBufferSize;

  const IChunkExploder({this.targetBufferSize = 1000});

  @override
  Stream<String> bind(Stream<Chunk> stream) async* {
    StringBuffer buffer = StringBuffer();

    await for (Chunk chunk in stream) {
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

class TXChunkMerger extends StreamTransformerBase<String, Chunk> {
  final int maxSize;
  final int maxPost;

  const TXChunkMerger({required this.maxSize, required this.maxPost});

  @override
  Stream<Chunk> bind(Stream<String> stream) async* {
    try {
      PieceQueue buffer = PieceQueue();
      int index = 0;

      await for (String piece in stream) {
        buffer.add(piece);

        if (buffer.canTake(maxSize)) {
          int startCursor = buffer.startCursor;
          String content = buffer.take(maxSize - maxPost);
          String post = buffer.peek(maxPost);

          yield Chunk(
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
        yield Chunk(
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
