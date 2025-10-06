import 'package:agentic/agentic.dart';
import 'package:agentic/chat/agent/chat_provider.dart';
import 'package:agentic/chat/connector/connected_model.dart';
import 'package:toxic/extensions/iterable.dart';

class IDistiller {
  final ConnectedChatModel llm;
  final int targetOutputSize;
  final String? organization;

  const IDistiller({
    this.targetOutputSize = 500,
    required this.llm,
    this.organization,
  });

  Future<IChunk> distillFrom({
    required String header,
    required List<IChunk> chunks,
    int index = 0,
    bool summarize = false,
  }) async => IChunk(
    index: index,
    lod: chunks.first.lod + 1,
    from: chunks.map((i) => i.index).toList(),
    content: await distill(
      input: chunks
          .mapIndexed(
            (i, index) =>
                index == chunks.length - 1 ? i.fullContent : i.content,
          )
          .join(""),
      header: header,
      prompt:
          summarize
              ? """
Your job is to summarize all of the information in the content provided into a clean concise representation of the information.
* Find the overall meaning and distill it into a few paragraphs or less.
* Only output the response, this is not a chat, do not include any extra commentary or formatting.
* Your output should be about $targetOutputSize characters.
          """.trim()
              : """
Your job is to distill all of the information in the content provided into a clean concise representation of the information without any loss of meaning.
* Strip out formatting, special characters, and other non-essential information. I.e. strip out json keys and just represent the information in written way.
* If the content has a lot of diacritics (OCR errors), do your best to make sense of them or correct them, if unsure, keep them as they are
* Only output the response, this is not a chat, do not include any extra commentary or formatting.
* Your output should be about $targetOutputSize characters.
          """.trim(),
    ),
  );

  Future<String> distill({
    required String input,
    required String header,
    String prompt = """
Your job is to distill all of the information in the content provided into a clean concise representation of the information without any loss of meaning.
* Strip out formatting, special characters, and other non-essential information. I.e. strip out json keys and just represent the information in written way.
* If the content has a lot of diacritics (OCR errors), do your best to make sense of them or correct them, if unsure, keep them as they are
* Only output the response, this is not a chat, do not include any extra commentary or formatting.
          """,
  }) async {
    Agent agent = Agent(
      user: organization,
      llm: llm,
      chatProvider: MemoryChatProvider(
        messages: [
          Message.system(prompt.trim()),
          Message.user("$header\n\n${input.trim()}".trim()),
        ],
      ),
    );

    AgentMessage r = await agent();
    return r.content.toString();
  }
}
