import 'dart:convert';
import 'dart:io';

import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/chat_request.dart';
import 'package:agentic/chat/connector/result.dart';
import 'package:test/test.dart';

void main() {
  group('NvidiaConnector', () {
    test('uses the NVIDIA OpenAI-compatible chat completions endpoint', () async {
      HttpServer server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(() => server.close(force: true));

      server.listen((request) async {
        expect(request.method, 'POST');
        expect(request.uri.path, '/v1/chat/completions');
        expect(
          request.headers.value(HttpHeaders.authorizationHeader),
          'Bearer nvapi-test',
        );

        Map<String, dynamic> body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;

        expect(body['model'], 'google/gemma-4-31b-it');
        expect(body['messages'], isA<List<dynamic>>());

        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'id': 'chatcmpl-nvidia-test',
              'object': 'chat.completion',
              'created': 1,
              'model': 'google/gemma-4-31b-it',
              'choices': [
                {
                  'index': 0,
                  'message': {
                    'role': 'assistant',
                    'content': 'Hello from NVIDIA',
                  },
                  'finish_reason': 'stop',
                },
              ],
              'usage': {
                'prompt_tokens': 7,
                'completion_tokens': 3,
                'total_tokens': 10,
              },
            }),
          );

        await request.response.close();
      });

      NvidiaConnector connector = NvidiaConnector(
        apiKey: 'nvapi-test',
        baseUrl: 'http://${server.address.host}:${server.port}/v1',
      );

      ChatResult result = await connector(
        ChatRequest(
          model: ChatModel.basic('google/gemma-4-31b-it'),
          messages: [Message.user('Say hello.')],
        ),
      );

      expect(result.message.content.toString(), contains('Hello from NVIDIA'));
      expect(result.usage.inputTokens, 7);
      expect(result.usage.outputTokens, 3);
    });

    test('sends NVIDIA embeddings payload with NVCloud-specific fields', () async {
      HttpServer server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(() => server.close(force: true));

      server.listen((request) async {
        expect(request.method, 'POST');
        expect(request.uri.path, '/v1/embeddings');
        expect(
          request.headers.value(HttpHeaders.authorizationHeader),
          'Bearer nvapi-test',
        );

        Map<String, dynamic> body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;

        expect(body['model'], 'nvidia/llama-nemotron-embed-vl-1b-v2');
        expect(body['input'], [
          'What is the civil caseload in South Dakota courts?',
        ]);
        expect(body['modality'], ['text']);
        expect(body['input_type'], 'query');
        expect(body['encoding_format'], 'float');
        expect(body['truncate'], 'NONE');

        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'object': 'list',
              'data': [
                {
                  'object': 'embedding',
                  'index': 0,
                  'embedding': [0.1, 0.2, 0.3],
                },
              ],
            }),
          );

        await request.response.close();
      });

      NvidiaConnector connector = NvidiaConnector(
        apiKey: 'nvapi-test',
        baseUrl: 'http://${server.address.host}:${server.port}/v1',
      );

      List<double> vector = await connector.embed(
        model: 'nvidia/llama-nemotron-embed-vl-1b-v2',
        content: Content.text(
          'What is the civil caseload in South Dakota courts?',
        ),
      );

      expect(vector, [0.1, 0.2, 0.3]);
    });

    test('embedInputs supports custom NVIDIA embedding options', () async {
      HttpServer server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(() => server.close(force: true));

      server.listen((request) async {
        expect(request.method, 'POST');
        expect(request.uri.path, '/v1/embeddings');

        Map<String, dynamic> body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;

        expect(body['input'], ['alpha', 'beta']);
        expect(body['input_type'], 'passage');
        expect(body['modality'], ['text']);
        expect(body['encoding_format'], 'base64');
        expect(body['truncate'], 'END');
        expect(body['dimensions'], 256);

        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'object': 'list',
              'data': [
                {
                  'object': 'embedding',
                  'index': 0,
                  'embedding': [1.0, 2.0],
                },
                {
                  'object': 'embedding',
                  'index': 1,
                  'embedding': [3.0, 4.0],
                },
              ],
            }),
          );

        await request.response.close();
      });

      NvidiaConnector connector = NvidiaConnector(
        apiKey: 'nvapi-test',
        baseUrl: 'http://${server.address.host}:${server.port}/v1',
      );

      List<List<double>> vectors = await connector.embedInputs(
        model: 'nvidia/llama-nemotron-embed-vl-1b-v2',
        contents: [Content.text('alpha'), Content.text('beta')],
        inputType: 'passage',
        modality: const ['text'],
        encodingFormat: NvidiaEmbeddingEncodingFormat.base64,
        truncate: NvidiaEmbeddingTruncate.end,
        dimensions: 256,
      );

      expect(vectors, [
        [1.0, 2.0],
        [3.0, 4.0],
      ]);
    });

    test('embed sends image modality for image content', () async {
      HttpServer server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(() => server.close(force: true));

      server.listen((request) async {
        expect(request.method, 'POST');
        expect(request.uri.path, '/v1/embeddings');

        Map<String, dynamic> body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;

        expect(body['input'], ['https://example.com/page.png']);
        expect(body['input_type'], 'passage');
        expect(body['modality'], ['image']);

        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'object': 'list',
              'data': [
                {
                  'object': 'embedding',
                  'index': 0,
                  'embedding': [9.0, 8.0],
                },
              ],
            }),
          );

        await request.response.close();
      });

      NvidiaConnector connector = NvidiaConnector(
        apiKey: 'nvapi-test',
        baseUrl: 'http://${server.address.host}:${server.port}/v1',
      );

      List<double> vector = await connector.embed(
        model: 'nvidia/llama-nemotron-embed-vl-1b-v2',
        content: Content.imageUrl('https://example.com/page.png'),
      );

      expect(vector, [9.0, 8.0]);
    });
  });
}
