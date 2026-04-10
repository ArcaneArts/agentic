import 'dart:convert';

import 'package:agentic/agentic.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('OpenRouterManagementClient', () {
    test('creates recurring keys and parses the returned secret key', () async {
      final client = OpenRouterManagementClient(
        'sk-management-key',
        httpClient: MockClient((request) async {
          expect(request.method, 'POST');
          expect(request.url.toString(), 'https://openrouter.ai/api/v1/keys');
          expect(request.headers['Authorization'], 'Bearer sk-management-key');

          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['name'], 'Analytics Service Key');
          expect(body['limit'], 100.0);
          expect(body['limit_reset'], 'weekly');
          expect(body['include_byok_in_limit'], isFalse);

          return http.Response(
            jsonEncode({
              'data': {
                'hash': 'hash-123',
                'name': 'Analytics Service Key',
                'label': 'Production API Key',
                'disabled': false,
                'include_byok_in_limit': false,
                'limit': 100,
                'limit_remaining': 88,
                'limit_reset': 'weekly',
                'usage': 12,
                'usage_daily': 1,
                'usage_weekly': 3,
                'usage_monthly': 8,
                'byok_usage': 12,
                'byok_usage_daily': 1,
                'byok_usage_weekly': 3,
                'byok_usage_monthly': 8,
                'created_at': '2024-06-01T09:15:00Z',
                'updated_at': '2024-06-15T14:45:00Z',
                'expires_at': '2029-11-30T23:59:59Z',
              },
              'key': 'sk-or-v1-secret',
            }),
            201,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      final created = await client.createRecurringKey(
        name: 'Analytics Service Key',
        limit: 100,
        reset: OpenRouterApiKeyLimitReset.weekly,
        includeByokInLimit: false,
      );

      expect(created.key, 'sk-or-v1-secret');
      expect(created.data.hash, 'hash-123');
      expect(created.data.limitReset, OpenRouterApiKeyLimitReset.weekly);
      expect(created.data.limitRemaining, 88);
    });

    test('lists keys with offset and includeDisabled filters', () async {
      final client = OpenRouterManagementClient(
        'sk-management-key',
        httpClient: MockClient((request) async {
          expect(request.method, 'GET');
          expect(request.url.path, '/api/v1/keys');
          expect(request.url.queryParameters['offset'], '40');
          expect(request.url.queryParameters['include_disabled'], 'true');

          return http.Response(
            jsonEncode({
              'data': [
                {
                  'hash': 'hash-1',
                  'name': 'Key 1',
                  'disabled': false,
                  'limit_reset': 'monthly',
                },
                {'hash': 'hash-2', 'name': 'Key 2', 'disabled': true},
              ],
            }),
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      final keys = await client.listApiKeys(offset: 40, includeDisabled: true);

      expect(keys, hasLength(2));
      expect(keys.first.hash, 'hash-1');
      expect(keys.first.limitReset, OpenRouterApiKeyLimitReset.monthly);
      expect(keys.last.disabled, isTrue);
    });

    test('one-time burn update clears recurring reset', () async {
      final client = OpenRouterManagementClient(
        'sk-management-key',
        httpClient: MockClient((request) async {
          expect(request.method, 'PATCH');
          expect(
            request.url.toString(),
            'https://openrouter.ai/api/v1/keys/hash-1',
          );

          final body = jsonDecode(request.body) as Map<String, dynamic>;
          expect(body['name'], 'Burn Key');
          expect(body['limit'], 25.0);
          expect(body.containsKey('limit_reset'), isTrue);
          expect(body['limit_reset'], isNull);

          return http.Response(
            jsonEncode({
              'data': {
                'hash': 'hash-1',
                'name': 'Burn Key',
                'disabled': false,
                'limit': 25,
                'limit_remaining': 25,
                'limit_reset': null,
              },
            }),
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      final key = await client.setOneTimeUseBurnLimit(
        'hash-1',
        name: 'Burn Key',
        limit: 25,
      );

      expect(key.hash, 'hash-1');
      expect(key.limit, 25);
      expect(key.limitReset, isNull);
    });

    test('reads current key metadata including management key flag', () async {
      final client = OpenRouterManagementClient(
        'sk-management-key',
        httpClient: MockClient((request) async {
          expect(request.method, 'GET');
          expect(request.url.toString(), 'https://openrouter.ai/api/v1/key');

          return http.Response(
            jsonEncode({
              'data': {
                'label': 'sk-or-v1-mgmt...123',
                'is_management_key': true,
                'is_provisioning_key': false,
                'is_free_tier': false,
                'limit': 100,
                'limit_remaining': 74.5,
                'limit_reset': 'monthly',
                'rate_limit': {
                  'interval': '1h',
                  'note': 'deprecated',
                  'requests': 1000,
                },
              },
            }),
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      final current = await client.getCurrentApiKey();

      expect(current.isManagementKey, isTrue);
      expect(current.isProvisioningKey, isFalse);
      expect(current.limitReset, OpenRouterApiKeyLimitReset.monthly);
      expect(current.rateLimit?.requests, 1000);
    });

    test('removes keys through the delete endpoint', () async {
      final client = OpenRouterManagementClient(
        'sk-management-key',
        httpClient: MockClient((request) async {
          expect(request.method, 'DELETE');
          expect(
            request.url.toString(),
            'https://openrouter.ai/api/v1/keys/hash-xyz',
          );

          return http.Response(
            jsonEncode({'deleted': true}),
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );

      final deleted = await client.removeApiKey('hash-xyz');
      expect(deleted.deleted, isTrue);
    });
  });
}
