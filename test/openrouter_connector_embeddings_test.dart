import 'dart:convert';
import 'dart:io';

import 'package:agentic/chat/content/content.dart';
import 'package:agentic/chat/connector/connector_openrouter.dart';
import 'package:test/test.dart';

void main() {
  group('OpenRouterConnector embeddings', () {
    test(
      'embed forwards to the OpenAI-compatible embeddings endpoint',
      () async {
        HttpServer server = await HttpServer.bind(
          InternetAddress.loopbackIPv4,
          0,
        );
        addTearDown(() => server.close(force: true));

        server.listen((request) async {
          expect(request.method, 'POST');
          expect(request.uri.path, '/api/v1/embeddings');
          expect(
            request.headers.value(HttpHeaders.authorizationHeader),
            'Bearer sk-or-test',
          );

          Map<String, dynamic> body =
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

        OpenRouterConnector connector = OpenRouterConnector(
          apiKey: 'sk-or-test',
          baseUrl: 'http://${server.address.host}:${server.port}/api/v1',
        );

        List<double> vector = await connector.embed(
          model: 'perplexity/pplx-embed-v1-4b',
          content: Content.text('hello world'),
          dimensions: 128,
        );

        expect(vector, [0.1, 0.2, 0.3]);
      },
    );

    test('embedMultiple returns multiple vectors', () async {
      HttpServer server = await HttpServer.bind(
        InternetAddress.loopbackIPv4,
        0,
      );
      addTearDown(() => server.close(force: true));

      server.listen((request) async {
        expect(request.method, 'POST');
        expect(request.uri.path, '/api/v1/embeddings');

        Map<String, dynamic> body =
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

      OpenRouterConnector connector = OpenRouterConnector(
        apiKey: 'sk-or-test',
        baseUrl: 'http://${server.address.host}:${server.port}/api/v1',
      );

      List<List<double>> vectors = await connector.embedMultiple(
        model: 'perplexity/pplx-embed-v1-4b',
        contents: [Content.text('alpha'), Content.text('beta')],
      );

      expect(vectors, [
        [1.0, 2.0],
        [3.0, 4.0],
      ]);
    });

    test('embed rejects non-text content for OpenAI-compatible embeddings', () {
      OpenRouterConnector connector = OpenRouterConnector(apiKey: 'sk-or-test');

      expect(
        () => connector.embed(
          model: 'perplexity/pplx-embed-v1-4b',
          content: Content.imageUrl('https://example.com/document.png'),
        ),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });
}
