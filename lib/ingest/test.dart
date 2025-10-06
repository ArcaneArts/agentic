import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:agentic/ingest/distiller.dart';
import 'package:fast_log/fast_log.dart';

String rawText = """
test data
""";

void main() async {
  IChunker c = IChunker(maxChunkSize: 500, maxPostOverlap: 100);
  int factor = 5;
  try {
    ConnectedChatModel llm = OLlamaConnector().connect(
      ChatModel.basic("gpt-oss:20b"),
    );
    IDistiller distiller = IDistiller(llm: llm, targetOutputSize: 500);
    c
        .recursiveDistillChunks(
          chunks: c.chunkString(rawText),
          distiller: distiller,
          factor: factor,
          parallelism: 8,
        )
        .map((i) {
          printChunk(i);
        })
        .toList();
  } catch (e, es) {
    error(e);
    error(es);
  }
}

void printChunk(IChunk c) {
  print(
    "L${c.lod}#${c.index} (${c.charStart}-${c.charEnd})[${c.content.length}+${c.postContent.length}=${c.fullContent.length}]<${c.from.join(",")}> => ${c.fullContent.replaceAll("\n", "\\n")}",
  );
}
