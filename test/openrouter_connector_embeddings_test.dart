import 'dart:convert';
import 'dart:io';

import 'package:agentic/chat/connector/connector_openrouter.dart';
import 'package:test/test.dart';

void main() {
  group('OpenRouterConnector embeddings', () {
    test(
      'embed forwards to the OpenAI-compatible embeddings endpoint',
      () async {
        final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        addTearDown(() => server.close(force: true));

        server.listen((request) async {
          expect(request.method, 'POST');
          expect(request.uri.path, '/api/v1/embeddings');
          expect(
            request.headers.value(HttpHeaders.authorizationHeader),
            'Bearer sk-or-test',
          );

          final body =
              jsonDecode(await utf8.decoder.bind(request).join())
                  as Map<String, dynamic>;

          expect(body['model'], 'perplexity/pplx-embed-v1-4b');
          expect(body['dimensions'], 128);
          expect(body['input'], ['hello world']);

          request.response
            ..statusCode = 200
            ..headers.contentType = ContentType.json
            ..write(
              jsonEncode({
                'object': 'list',
                'model': 'perplexity/pplx-embed-v1-4b',
                'data': [
                  {
                    'object': 'embedding',
                    'index': 0,
                    'embedding': [0.1, 0.2, 0.3],
                  },
                ],
                'usage': {'prompt_tokens': 2, 'total_tokens': 2},
              }),
            );

          await request.response.close();
        });

        final connector = OpenRouterConnector(
          apiKey: 'sk-or-test',
          baseUrl: 'http://${server.address.host}:${server.port}/api/v1',
        );

        final vector = await connector.embed(
          model: 'perplexity/pplx-embed-v1-4b',
          text: 'hello world',
          dimensions: 128,
        );

        expect(vector, [0.1, 0.2, 0.3]);
      },
    );

    test('embedMultiple returns multiple vectors', () async {
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));

      server.listen((request) async {
        expect(request.method, 'POST');
        expect(request.uri.path, '/api/v1/embeddings');

        final body =
            jsonDecode(await utf8.decoder.bind(request).join())
                as Map<String, dynamic>;

        expect(body['model'], 'perplexity/pplx-embed-v1-4b');
        expect(body['input'], ['alpha', 'beta']);

        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({
              'object': 'list',
              'model': 'perplexity/pplx-embed-v1-4b',
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

      final connector = OpenRouterConnector(
        apiKey: 'sk-or-test',
        baseUrl: 'http://${server.address.host}:${server.port}/api/v1',
      );

      final vectors = await connector.embedMultiple(
        model: 'perplexity/pplx-embed-v1-4b',
        texts: const ['alpha', 'beta'],
      );

      expect(vectors, [
        [1.0, 2.0],
        [3.0, 4.0],
      ]);
    });
  });
}
