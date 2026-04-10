import 'dart:convert';

import 'package:http/http.dart' as http;

enum OpenRouterApiKeyLimitReset { daily, weekly, monthly }

extension OpenRouterApiKeyLimitResetX on OpenRouterApiKeyLimitReset {
  String get wireValue => name;

  static OpenRouterApiKeyLimitReset? fromWireValue(String? value) {
    if (value == null) {
      return null;
    }

    for (final candidate in OpenRouterApiKeyLimitReset.values) {
      if (candidate.wireValue == value) {
        return candidate;
      }
    }

    return null;
  }
}

class OpenRouterManagementClient {
  final String managementKey;
  final String baseUrl;
  final http.Client _httpClient;
  final bool _ownsHttpClient;

  OpenRouterManagementClient(
    this.managementKey, {
    this.baseUrl = 'https://openrouter.ai/api/v1',
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client(),
       _ownsHttpClient = httpClient == null;

  Future<OpenRouterCurrentApiKey> getCurrentKey() async {
    final response = await _send(
      method: 'GET',
      path: '/key',
      expectedStatusCodes: const {200},
    );

    return OpenRouterCurrentApiKey.fromMap(
      _requireMap(response['data'], 'data'),
    );
  }

  Future<OpenRouterCurrentApiKey> getCurrentApiKey() => getCurrentKey();

  Future<List<OpenRouterManagedApiKey>> listKeys({
    int? offset,
    bool? includeDisabled,
  }) async {
    final response = await _send(
      method: 'GET',
      path: '/keys',
      queryParameters: {
        if (offset != null) 'offset': offset,
        if (includeDisabled != null) 'include_disabled': includeDisabled,
      },
      expectedStatusCodes: const {200},
    );

    return _requireList(response['data'], 'data')
        .map(
          (entry) =>
              OpenRouterManagedApiKey.fromMap(_requireMap(entry, 'data[]')),
        )
        .toList();
  }

  Future<List<OpenRouterManagedApiKey>> listApiKeys({
    int? offset,
    bool? includeDisabled,
  }) => listKeys(offset: offset, includeDisabled: includeDisabled);

  Future<OpenRouterManagedApiKey> getKey(String hash) async {
    final response = await _send(
      method: 'GET',
      path: '/keys/${Uri.encodeComponent(hash)}',
      expectedStatusCodes: const {200},
    );

    return OpenRouterManagedApiKey.fromMap(
      _requireMap(response['data'], 'data'),
    );
  }

  Future<OpenRouterManagedApiKey> getApiKey(String hash) => getKey(hash);

  Future<OpenRouterCreatedApiKey> createKey(
    OpenRouterCreateApiKeyRequest request,
  ) async {
    final response = await _send(
      method: 'POST',
      path: '/keys',
      body: request.toMap(),
      expectedStatusCodes: const {201},
    );

    return OpenRouterCreatedApiKey.fromMap(response);
  }

  Future<OpenRouterCreatedApiKey> createApiKey(
    OpenRouterCreateApiKeyRequest request,
  ) => createKey(request);

  Future<OpenRouterCreatedApiKey> createRecurringKey({
    required String name,
    required double limit,
    required OpenRouterApiKeyLimitReset reset,
    String? creatorUserId,
    DateTime? expiresAt,
    bool? includeByokInLimit,
  }) => createKey(
    OpenRouterCreateApiKeyRequest.recurring(
      name: name,
      limit: limit,
      limitReset: reset,
      creatorUserId: creatorUserId,
      expiresAt: expiresAt,
      includeByokInLimit: includeByokInLimit,
    ),
  );

  Future<OpenRouterCreatedApiKey> createOneTimeBurnKey({
    required String name,
    required double limit,
    String? creatorUserId,
    DateTime? expiresAt,
    bool? includeByokInLimit,
  }) => createKey(
    OpenRouterCreateApiKeyRequest.oneTimeUseBurn(
      name: name,
      limit: limit,
      creatorUserId: creatorUserId,
      expiresAt: expiresAt,
      includeByokInLimit: includeByokInLimit,
    ),
  );

  Future<OpenRouterCreatedApiKey> createOneTimeUseBurnKey({
    required String name,
    required double limit,
    String? creatorUserId,
    DateTime? expiresAt,
    bool? includeByokInLimit,
  }) => createOneTimeBurnKey(
    name: name,
    limit: limit,
    creatorUserId: creatorUserId,
    expiresAt: expiresAt,
    includeByokInLimit: includeByokInLimit,
  );

  Future<OpenRouterManagedApiKey> updateKey(
    String hash,
    OpenRouterUpdateApiKeyRequest request,
  ) async {
    final response = await _send(
      method: 'PATCH',
      path: '/keys/${Uri.encodeComponent(hash)}',
      body: request.toMap(),
      expectedStatusCodes: const {200},
    );

    return OpenRouterManagedApiKey.fromMap(
      _requireMap(response['data'], 'data'),
    );
  }

  Future<OpenRouterManagedApiKey> updateApiKey(
    String hash,
    OpenRouterUpdateApiKeyRequest request,
  ) => updateKey(hash, request);

  Future<OpenRouterManagedApiKey> setRecurringLimit(
    String hash, {
    required double limit,
    required OpenRouterApiKeyLimitReset reset,
    String? name,
    bool? disabled,
    bool? includeByokInLimit,
  }) => updateKey(
    hash,
    OpenRouterUpdateApiKeyRequest.recurring(
      name: name,
      limit: limit,
      limitReset: reset,
      disabled: disabled,
      includeByokInLimit: includeByokInLimit,
    ),
  );

  Future<OpenRouterManagedApiKey> setOneTimeBurnLimit(
    String hash, {
    required double limit,
    String? name,
    bool? disabled,
    bool? includeByokInLimit,
  }) => updateKey(
    hash,
    OpenRouterUpdateApiKeyRequest.oneTimeUseBurn(
      name: name,
      limit: limit,
      disabled: disabled,
      includeByokInLimit: includeByokInLimit,
    ),
  );

  Future<OpenRouterManagedApiKey> setOneTimeUseBurnLimit(
    String hash, {
    required double limit,
    String? name,
    bool? disabled,
    bool? includeByokInLimit,
  }) => setOneTimeBurnLimit(
    hash,
    limit: limit,
    name: name,
    disabled: disabled,
    includeByokInLimit: includeByokInLimit,
  );

  Future<OpenRouterManagedApiKey> enableKey(String hash) =>
      updateKey(hash, const OpenRouterUpdateApiKeyRequest(disabled: false));

  Future<OpenRouterManagedApiKey> disableKey(String hash) =>
      updateKey(hash, const OpenRouterUpdateApiKeyRequest(disabled: true));

  Future<OpenRouterDeleteApiKeyResponse> deleteKey(String hash) async {
    final response = await _send(
      method: 'DELETE',
      path: '/keys/${Uri.encodeComponent(hash)}',
      expectedStatusCodes: const {200},
    );

    return OpenRouterDeleteApiKeyResponse.fromMap(response);
  }

  Future<OpenRouterDeleteApiKeyResponse> deleteApiKey(String hash) =>
      deleteKey(hash);

  Future<OpenRouterDeleteApiKeyResponse> removeKey(String hash) =>
      deleteKey(hash);

  Future<OpenRouterDeleteApiKeyResponse> removeApiKey(String hash) =>
      deleteKey(hash);

  void close() {
    if (_ownsHttpClient) {
      _httpClient.close();
    }
  }

  Future<Map<String, dynamic>> _send({
    required String method,
    required String path,
    Map<String, Object?>? queryParameters,
    Map<String, dynamic>? body,
    Set<int> expectedStatusCodes = const {200},
  }) async {
    final request = http.Request(method, _buildUri(path, queryParameters));
    request.headers['Authorization'] = 'Bearer $managementKey';
    request.headers['Accept'] = 'application/json';

    if (body != null) {
      request.headers['Content-Type'] = 'application/json';
      request.body = jsonEncode(body);
    }

    final streamed = await _httpClient.send(request);
    final response = await http.Response.fromStream(streamed);

    if (!expectedStatusCodes.contains(response.statusCode)) {
      throw OpenRouterManagementApiException.fromResponse(response);
    }

    if (response.body.isEmpty) {
      return const {};
    }

    final decoded = jsonDecode(response.body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw OpenRouterManagementApiException(
      statusCode: response.statusCode,
      message:
          'Expected a JSON object from OpenRouter Management API but received ${decoded.runtimeType}.',
      responseBody: response.body,
    );
  }

  Uri _buildUri(String path, Map<String, Object?>? queryParameters) {
    final normalizedBaseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    final base = Uri.parse(normalizedBaseUrl);
    final resolved = base.resolve(
      path.startsWith('/') ? path.substring(1) : path,
    );

    if (queryParameters == null || queryParameters.isEmpty) {
      return resolved;
    }

    return resolved.replace(
      queryParameters: {
        for (final entry in queryParameters.entries)
          if (entry.value != null) entry.key: entry.value.toString(),
      },
    );
  }
}

class OpenRouterCreateApiKeyRequest {
  final String name;
  final String? creatorUserId;
  final DateTime? expiresAt;
  final bool? includeByokInLimit;
  final double? limit;
  final OpenRouterApiKeyLimitReset? limitReset;

  const OpenRouterCreateApiKeyRequest({
    required this.name,
    this.creatorUserId,
    this.expiresAt,
    this.includeByokInLimit,
    this.limit,
    this.limitReset,
  });

  factory OpenRouterCreateApiKeyRequest.recurring({
    required String name,
    required double limit,
    required OpenRouterApiKeyLimitReset limitReset,
    String? creatorUserId,
    DateTime? expiresAt,
    bool? includeByokInLimit,
  }) => OpenRouterCreateApiKeyRequest(
    name: name,
    creatorUserId: creatorUserId,
    expiresAt: expiresAt,
    includeByokInLimit: includeByokInLimit,
    limit: limit,
    limitReset: limitReset,
  );

  factory OpenRouterCreateApiKeyRequest.oneTimeUseBurn({
    required String name,
    required double limit,
    String? creatorUserId,
    DateTime? expiresAt,
    bool? includeByokInLimit,
  }) => OpenRouterCreateApiKeyRequest(
    name: name,
    creatorUserId: creatorUserId,
    expiresAt: expiresAt,
    includeByokInLimit: includeByokInLimit,
    limit: limit,
  );

  factory OpenRouterCreateApiKeyRequest.unlimited({
    required String name,
    String? creatorUserId,
    DateTime? expiresAt,
    bool? includeByokInLimit,
  }) => OpenRouterCreateApiKeyRequest(
    name: name,
    creatorUserId: creatorUserId,
    expiresAt: expiresAt,
    includeByokInLimit: includeByokInLimit,
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    if (creatorUserId != null) 'creator_user_id': creatorUserId,
    if (expiresAt != null) 'expires_at': _toUtcIso8601(expiresAt!),
    if (includeByokInLimit != null) 'include_byok_in_limit': includeByokInLimit,
    if (limit != null) 'limit': limit,
    if (limitReset != null) 'limit_reset': limitReset!.wireValue,
  };
}

class OpenRouterUpdateApiKeyRequest {
  final String? name;
  final bool? disabled;
  final bool? includeByokInLimit;
  final double? limit;
  final OpenRouterApiKeyLimitReset? limitReset;
  final bool clearLimit;
  final bool clearLimitReset;

  const OpenRouterUpdateApiKeyRequest({
    this.name,
    this.disabled,
    this.includeByokInLimit,
    this.limit,
    this.limitReset,
    this.clearLimit = false,
    this.clearLimitReset = false,
  });

  factory OpenRouterUpdateApiKeyRequest.recurring({
    String? name,
    bool? disabled,
    bool? includeByokInLimit,
    required double limit,
    required OpenRouterApiKeyLimitReset limitReset,
  }) => OpenRouterUpdateApiKeyRequest(
    name: name,
    disabled: disabled,
    includeByokInLimit: includeByokInLimit,
    limit: limit,
    limitReset: limitReset,
  );

  factory OpenRouterUpdateApiKeyRequest.oneTimeUseBurn({
    String? name,
    bool? disabled,
    bool? includeByokInLimit,
    required double limit,
  }) => OpenRouterUpdateApiKeyRequest(
    name: name,
    disabled: disabled,
    includeByokInLimit: includeByokInLimit,
    limit: limit,
    clearLimitReset: true,
  );

  factory OpenRouterUpdateApiKeyRequest.unlimited({
    String? name,
    bool? disabled,
    bool? includeByokInLimit,
  }) => OpenRouterUpdateApiKeyRequest(
    name: name,
    disabled: disabled,
    includeByokInLimit: includeByokInLimit,
    clearLimit: true,
    clearLimitReset: true,
  );

  Map<String, dynamic> toMap() => {
    if (name != null) 'name': name,
    if (disabled != null) 'disabled': disabled,
    if (includeByokInLimit != null) 'include_byok_in_limit': includeByokInLimit,
    if (limit != null || clearLimit) 'limit': limit,
    if (limitReset != null || clearLimitReset)
      'limit_reset': limitReset?.wireValue,
  };
}

class OpenRouterManagedApiKey {
  final double? byokUsage;
  final double? byokUsageDaily;
  final double? byokUsageWeekly;
  final double? byokUsageMonthly;
  final DateTime? createdAt;
  final String? creatorUserId;
  final bool disabled;
  final String hash;
  final bool? includeByokInLimit;
  final String? label;
  final double? limit;
  final double? limitRemaining;
  final OpenRouterApiKeyLimitReset? limitReset;
  final String? name;
  final DateTime? updatedAt;
  final double? usage;
  final double? usageDaily;
  final double? usageWeekly;
  final double? usageMonthly;
  final DateTime? expiresAt;

  const OpenRouterManagedApiKey({
    required this.hash,
    this.name,
    this.label,
    this.creatorUserId,
    this.createdAt,
    this.updatedAt,
    this.expiresAt,
    this.limit,
    this.limitRemaining,
    this.limitReset,
    this.includeByokInLimit,
    this.usage,
    this.usageDaily,
    this.usageWeekly,
    this.usageMonthly,
    this.byokUsage,
    this.byokUsageDaily,
    this.byokUsageWeekly,
    this.byokUsageMonthly,
    this.disabled = false,
  });

  factory OpenRouterManagedApiKey.fromJson(String json) =>
      OpenRouterManagedApiKey.fromMap(jsonDecode(json));

  factory OpenRouterManagedApiKey.fromMap(Map<String, dynamic> map) =>
      OpenRouterManagedApiKey(
        hash: _requireString(map['hash'], 'hash'),
        name: _asString(map['name']),
        label: _asString(map['label']),
        creatorUserId: _asString(map['creator_user_id']),
        createdAt: _asDateTime(map['created_at']),
        updatedAt: _asDateTime(map['updated_at']),
        expiresAt: _asDateTime(map['expires_at']),
        limit: _asDouble(map['limit']),
        limitRemaining: _asDouble(map['limit_remaining']),
        limitReset: OpenRouterApiKeyLimitResetX.fromWireValue(
          _asString(map['limit_reset']),
        ),
        includeByokInLimit: _asBool(map['include_byok_in_limit']),
        usage: _asDouble(map['usage']),
        usageDaily: _asDouble(map['usage_daily']),
        usageWeekly: _asDouble(map['usage_weekly']),
        usageMonthly: _asDouble(map['usage_monthly']),
        byokUsage: _asDouble(map['byok_usage']),
        byokUsageDaily: _asDouble(map['byok_usage_daily']),
        byokUsageWeekly: _asDouble(map['byok_usage_weekly']),
        byokUsageMonthly: _asDouble(map['byok_usage_monthly']),
        disabled: _asBool(map['disabled']) ?? false,
      );

  Map<String, dynamic> toMap() => {
    'hash': hash,
    if (name != null) 'name': name,
    if (label != null) 'label': label,
    if (creatorUserId != null) 'creator_user_id': creatorUserId,
    if (createdAt != null) 'created_at': _toUtcIso8601(createdAt!),
    if (updatedAt != null) 'updated_at': _toUtcIso8601(updatedAt!),
    if (expiresAt != null) 'expires_at': _toUtcIso8601(expiresAt!),
    'disabled': disabled,
    if (includeByokInLimit != null) 'include_byok_in_limit': includeByokInLimit,
    if (limit != null) 'limit': limit,
    if (limitRemaining != null) 'limit_remaining': limitRemaining,
    if (limitReset != null) 'limit_reset': limitReset!.wireValue,
    if (usage != null) 'usage': usage,
    if (usageDaily != null) 'usage_daily': usageDaily,
    if (usageWeekly != null) 'usage_weekly': usageWeekly,
    if (usageMonthly != null) 'usage_monthly': usageMonthly,
    if (byokUsage != null) 'byok_usage': byokUsage,
    if (byokUsageDaily != null) 'byok_usage_daily': byokUsageDaily,
    if (byokUsageWeekly != null) 'byok_usage_weekly': byokUsageWeekly,
    if (byokUsageMonthly != null) 'byok_usage_monthly': byokUsageMonthly,
  };

  String toJson() => jsonEncode(toMap());
}

class OpenRouterCreatedApiKey {
  final OpenRouterManagedApiKey data;
  final String key;

  const OpenRouterCreatedApiKey({required this.data, required this.key});

  factory OpenRouterCreatedApiKey.fromJson(String json) =>
      OpenRouterCreatedApiKey.fromMap(jsonDecode(json));

  factory OpenRouterCreatedApiKey.fromMap(Map<String, dynamic> map) =>
      OpenRouterCreatedApiKey(
        data: OpenRouterManagedApiKey.fromMap(_requireMap(map['data'], 'data')),
        key: _requireString(map['key'], 'key'),
      );

  Map<String, dynamic> toMap() => {'data': data.toMap(), 'key': key};

  String toJson() => jsonEncode(toMap());
}

class OpenRouterDeleteApiKeyResponse {
  final bool deleted;

  const OpenRouterDeleteApiKeyResponse({required this.deleted});

  factory OpenRouterDeleteApiKeyResponse.fromJson(String json) =>
      OpenRouterDeleteApiKeyResponse.fromMap(jsonDecode(json));

  factory OpenRouterDeleteApiKeyResponse.fromMap(Map<String, dynamic> map) =>
      OpenRouterDeleteApiKeyResponse(deleted: _asBool(map['deleted']) ?? false);

  Map<String, dynamic> toMap() => {'deleted': deleted};

  String toJson() => jsonEncode(toMap());
}

class OpenRouterCurrentApiKey {
  final double? byokUsage;
  final double? byokUsageDaily;
  final double? byokUsageWeekly;
  final double? byokUsageMonthly;
  final String? creatorUserId;
  final bool? includeByokInLimit;
  final bool? isFreeTier;
  final bool? isManagementKey;
  final bool? isProvisioningKey;
  final String? label;
  final double? limit;
  final double? limitRemaining;
  final OpenRouterApiKeyLimitReset? limitReset;
  final double? usage;
  final double? usageDaily;
  final double? usageWeekly;
  final double? usageMonthly;
  final OpenRouterCurrentApiKeyRateLimit? rateLimit;
  final DateTime? expiresAt;

  const OpenRouterCurrentApiKey({
    this.byokUsage,
    this.byokUsageDaily,
    this.byokUsageWeekly,
    this.byokUsageMonthly,
    this.creatorUserId,
    this.includeByokInLimit,
    this.isFreeTier,
    this.isManagementKey,
    this.isProvisioningKey,
    this.label,
    this.limit,
    this.limitRemaining,
    this.limitReset,
    this.usage,
    this.usageDaily,
    this.usageWeekly,
    this.usageMonthly,
    this.rateLimit,
    this.expiresAt,
  });

  factory OpenRouterCurrentApiKey.fromJson(String json) =>
      OpenRouterCurrentApiKey.fromMap(jsonDecode(json));

  factory OpenRouterCurrentApiKey.fromMap(Map<String, dynamic> map) =>
      OpenRouterCurrentApiKey(
        byokUsage: _asDouble(map['byok_usage']),
        byokUsageDaily: _asDouble(map['byok_usage_daily']),
        byokUsageWeekly: _asDouble(map['byok_usage_weekly']),
        byokUsageMonthly: _asDouble(map['byok_usage_monthly']),
        creatorUserId: _asString(map['creator_user_id']),
        includeByokInLimit: _asBool(map['include_byok_in_limit']),
        isFreeTier: _asBool(map['is_free_tier']),
        isManagementKey: _asBool(map['is_management_key']),
        isProvisioningKey: _asBool(map['is_provisioning_key']),
        label: _asString(map['label']),
        limit: _asDouble(map['limit']),
        limitRemaining: _asDouble(map['limit_remaining']),
        limitReset: OpenRouterApiKeyLimitResetX.fromWireValue(
          _asString(map['limit_reset']),
        ),
        usage: _asDouble(map['usage']),
        usageDaily: _asDouble(map['usage_daily']),
        usageWeekly: _asDouble(map['usage_weekly']),
        usageMonthly: _asDouble(map['usage_monthly']),
        rateLimit:
            map['rate_limit'] is Map<String, dynamic>
                ? OpenRouterCurrentApiKeyRateLimit.fromMap(
                  map['rate_limit'] as Map<String, dynamic>,
                )
                : null,
        expiresAt: _asDateTime(map['expires_at']),
      );

  Map<String, dynamic> toMap() => {
    if (byokUsage != null) 'byok_usage': byokUsage,
    if (byokUsageDaily != null) 'byok_usage_daily': byokUsageDaily,
    if (byokUsageWeekly != null) 'byok_usage_weekly': byokUsageWeekly,
    if (byokUsageMonthly != null) 'byok_usage_monthly': byokUsageMonthly,
    if (creatorUserId != null) 'creator_user_id': creatorUserId,
    if (includeByokInLimit != null) 'include_byok_in_limit': includeByokInLimit,
    if (isFreeTier != null) 'is_free_tier': isFreeTier,
    if (isManagementKey != null) 'is_management_key': isManagementKey,
    if (isProvisioningKey != null) 'is_provisioning_key': isProvisioningKey,
    if (label != null) 'label': label,
    if (limit != null) 'limit': limit,
    if (limitRemaining != null) 'limit_remaining': limitRemaining,
    if (limitReset != null) 'limit_reset': limitReset!.wireValue,
    if (usage != null) 'usage': usage,
    if (usageDaily != null) 'usage_daily': usageDaily,
    if (usageWeekly != null) 'usage_weekly': usageWeekly,
    if (usageMonthly != null) 'usage_monthly': usageMonthly,
    if (rateLimit != null) 'rate_limit': rateLimit!.toMap(),
    if (expiresAt != null) 'expires_at': _toUtcIso8601(expiresAt!),
  };

  String toJson() => jsonEncode(toMap());
}

class OpenRouterCurrentApiKeyRateLimit {
  final String? interval;
  final String? note;
  final int? requests;

  const OpenRouterCurrentApiKeyRateLimit({
    this.interval,
    this.note,
    this.requests,
  });

  factory OpenRouterCurrentApiKeyRateLimit.fromMap(Map<String, dynamic> map) =>
      OpenRouterCurrentApiKeyRateLimit(
        interval: _asString(map['interval']),
        note: _asString(map['note']),
        requests: _asInt(map['requests']),
      );

  Map<String, dynamic> toMap() => {
    if (interval != null) 'interval': interval,
    if (note != null) 'note': note,
    if (requests != null) 'requests': requests,
  };
}

class OpenRouterManagementApiException implements Exception {
  final int statusCode;
  final String message;
  final String responseBody;
  final Map<String, dynamic>? responseJson;

  const OpenRouterManagementApiException({
    required this.statusCode,
    required this.message,
    required this.responseBody,
    this.responseJson,
  });

  factory OpenRouterManagementApiException.fromResponse(
    http.Response response,
  ) {
    Map<String, dynamic>? json;

    if (response.body.isNotEmpty) {
      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          json = decoded;
        }
      } catch (_) {
        // Leave json null when the API does not respond with JSON.
      }
    }

    final message =
        _asString(
          json?['error'] is Map<String, dynamic>
              ? (json!['error'] as Map<String, dynamic>)['message']
              : json?['message'],
        ) ??
        'OpenRouter Management API request failed with status ${response.statusCode}.';

    return OpenRouterManagementApiException(
      statusCode: response.statusCode,
      message: message,
      responseBody: response.body,
      responseJson: json,
    );
  }

  @override
  String toString() =>
      'OpenRouterManagementApiException($statusCode): $message';
}

String _toUtcIso8601(DateTime value) => value.toUtc().toIso8601String();

DateTime? _asDateTime(dynamic value) {
  if (value is! String || value.isEmpty) {
    return null;
  }

  return DateTime.tryParse(value);
}

double? _asDouble(dynamic value) {
  if (value is num) {
    return value.toDouble();
  }

  if (value is String) {
    return double.tryParse(value);
  }

  return null;
}

int? _asInt(dynamic value) {
  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.toInt();
  }

  if (value is String) {
    return int.tryParse(value);
  }

  return null;
}

bool? _asBool(dynamic value) {
  if (value is bool) {
    return value;
  }

  if (value is String) {
    switch (value.toLowerCase()) {
      case 'true':
        return true;
      case 'false':
        return false;
    }
  }

  return null;
}

String? _asString(dynamic value) => value is String ? value : null;

String _requireString(dynamic value, String fieldName) {
  final stringValue = _asString(value);
  if (stringValue == null || stringValue.isEmpty) {
    throw FormatException('Expected non-empty string for "$fieldName".');
  }

  return stringValue;
}

Map<String, dynamic> _requireMap(dynamic value, String fieldName) {
  if (value is Map<String, dynamic>) {
    return value;
  }

  throw FormatException('Expected object for "$fieldName".');
}

List<dynamic> _requireList(dynamic value, String fieldName) {
  if (value is List<dynamic>) {
    return value;
  }

  throw FormatException('Expected list for "$fieldName".');
}
