import 'dart:convert';

import 'package:agentic/chat/connector/connector_openai.dart';
import 'package:agentic/chat/connector/model.dart';
import 'package:agentic/chat/content/content.dart';
import 'package:agentic/chat/content/content_audio.dart';
import 'package:agentic/chat/content/content_group.dart';
import 'package:agentic/chat/content/content_image.dart';
import 'package:agentic/chat/content/text_content.dart';
import 'package:http/http.dart' as http;

enum NvidiaEmbeddingEncodingFormat { float, base64 }

extension NvidiaEmbeddingEncodingFormatX on NvidiaEmbeddingEncodingFormat {
  String get wireValue => name;
}

enum NvidiaEmbeddingTruncate {
  none('NONE'),
  start('START'),
  end('END');

  final String wireValue;

  const NvidiaEmbeddingTruncate(this.wireValue);
}

class NvidiaConnector extends OpenAIConnector {
  final String embeddingInputType;
  final List<String> embeddingModality;
  final NvidiaEmbeddingEncodingFormat embeddingEncodingFormat;
  final NvidiaEmbeddingTruncate embeddingTruncate;

  const NvidiaConnector({
    required super.apiKey,
    super.baseUrl = 'https://integrate.api.nvidia.com/v1',
    this.embeddingInputType = 'query',
    this.embeddingModality = const ['text'],
    this.embeddingEncodingFormat = NvidiaEmbeddingEncodingFormat.float,
    this.embeddingTruncate = NvidiaEmbeddingTruncate.none,
  });

  @override
  List<ChatModel> get supportedModels => const [
    ChatModel.basic('google/gemma-4-31b-it'),
    ChatModel.basic('meta/llama-3.3-70b-instruct'),
    ChatModel.basic('nvidia/llama-3.1-nemotron-ultra-253b-v1'),
  ];

  @override
  Future<List<double>> embed({
    required String model,
    required Content content,
    int? dimensions,
  }) => embedInputs(
    model: model,
    contents: [content],
    dimensions: dimensions,
  ).then((List<List<double>> vectors) => vectors.first);

  @override
  Future<List<List<double>>> embedMultiple({
    required String model,
    required List<Content> contents,
    int? dimensions,
  }) => embedInputs(model: model, contents: contents, dimensions: dimensions);

  Future<List<List<double>>> embedInputs({
    required String model,
    required List<Content> contents,
    int? dimensions,
    String? inputType,
    List<String>? modality,
    NvidiaEmbeddingEncodingFormat? encodingFormat,
    NvidiaEmbeddingTruncate? truncate,
  }) async {
    List<NvidiaEmbeddingValue> embeddingValues =
        contents.map(_toEmbeddingValue).toList();
    String resolvedModality = _resolveModality(
      values: embeddingValues,
      modality: modality,
    );
    String resolvedInputType =
        inputType ?? _defaultInputType(resolvedModality);
    Uri uri = _buildUri('/embeddings');
    http.Response response = await http.post(
      uri,
      headers: <String, String>{
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'input': embeddingValues.map((NvidiaEmbeddingValue i) => i.input).toList(),
        'model': model,
        'input_type': resolvedInputType,
        'modality': [resolvedModality],
        'encoding_format':
            (encodingFormat ?? embeddingEncodingFormat).wireValue,
        'truncate': (truncate ?? embeddingTruncate).wireValue,
        if (dimensions != null) 'dimensions': dimensions,
      }),
    );

    if (response.statusCode == 202) {
      throw NvidiaApiException(
        statusCode: response.statusCode,
        message:
            'NVIDIA embeddings returned 202 pending status. Polling pending requests is not implemented.',
        responseBody: response.body,
      );
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw NvidiaApiException(
        statusCode: response.statusCode,
        message: 'NVIDIA embeddings request failed.',
        responseBody: response.body,
      );
    }

    Object? decoded = jsonDecode(response.body);
    Map<String, dynamic> body = _requireMap(decoded);
    Object? dataValue = body['data'];

    if (dataValue is! List) {
      throw NvidiaApiException(
        statusCode: response.statusCode,
        message:
            'Expected NVIDIA embeddings response to contain a data array.',
        responseBody: response.body,
      );
    }

    return dataValue.map(_parseEmbedding).toList();
  }

  Uri _buildUri(String path) {
    String normalizedBaseUrl = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';
    Uri base = Uri.parse(normalizedBaseUrl);
    return base.resolve(path.startsWith('/') ? path.substring(1) : path);
  }

  Map<String, dynamic> _requireMap(Object? value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    throw NvidiaApiException(
      message: 'Expected a JSON object from NVIDIA API.',
      responseBody: value?.toString(),
    );
  }

  List<double> _parseEmbedding(Object? value) {
    Map<String, dynamic> entry = _requireMap(value);
    Object? embeddingValue = entry['embedding'];

    if (embeddingValue is! List) {
      throw NvidiaApiException(
        message: 'Expected each NVIDIA embedding entry to contain a list.',
        responseBody: entry.toString(),
      );
    }

    return embeddingValue.map(_toDouble).toList();
  }

  double _toDouble(Object? value) {
    if (value is num) {
      return value.toDouble();
    }

    throw NvidiaApiException(
      message: 'Expected NVIDIA embedding values to be numeric.',
      responseBody: value?.toString(),
    );
  }

  String _resolveModality({
    required List<NvidiaEmbeddingValue> values,
    required List<String>? modality,
  }) {
    if (modality != null && modality.isNotEmpty) {
      if (modality.length != 1) {
        throw UnsupportedError(
          'NVIDIA embedding requests currently support a single modality per batch.',
        );
      }

      return modality.first;
    }

    List<String> distinctModalities =
        values.map((NvidiaEmbeddingValue i) => i.modality).toSet().toList();

    if (distinctModalities.length != 1) {
      throw UnsupportedError(
        'NVIDIA embedding batches must use one modality at a time.',
      );
    }

    return distinctModalities.first;
  }

  String _defaultInputType(String modality) =>
      modality == 'text' ? embeddingInputType : 'passage';

  NvidiaEmbeddingValue _toEmbeddingValue(Content content) {
    if (content is TextContent) {
      return NvidiaEmbeddingValue(input: content.text, modality: 'text');
    }

    if (content is ImageContent) {
      return NvidiaEmbeddingValue(
        input: content.imageUrl ?? content.base64Image ?? '',
        modality: 'image',
      );
    }

    if (content is AudioContent) {
      throw UnsupportedError('NVIDIA audio embeddings are not supported.');
    }

    if (content is ContentGroup) {
      List<Content> parts = content.explode().toList();
      bool isTextOnly = parts.every((Content i) => i is TextContent);
      bool isImageOnly =
          parts.length == 1 && parts.first is ImageContent;

      if (isTextOnly) {
        return NvidiaEmbeddingValue(
          input: parts.whereType<TextContent>().map((TextContent i) => i.text).join(
            ' ',
          ),
          modality: 'text',
        );
      }

      if (isImageOnly) {
        return _toEmbeddingValue(parts.first);
      }

      throw UnsupportedError(
        'Combined image + text NVIDIA embeddings are not implemented yet.',
      );
    }

    throw UnsupportedError(
      'Unsupported content type for NVIDIA embeddings: ${content.runtimeType}.',
    );
  }
}

class NvidiaEmbeddingValue {
  final Object input;
  final String modality;

  const NvidiaEmbeddingValue({required this.input, required this.modality});
}

class NvidiaApiException implements Exception {
  final String message;
  final int? statusCode;
  final String? responseBody;

  const NvidiaApiException({
    required this.message,
    this.statusCode,
    this.responseBody,
  });

  @override
  String toString() {
    String status = statusCode == null ? '' : ' (status $statusCode)';
    String body = responseBody == null ? '' : '\n$responseBody';
    return 'NvidiaApiException$status: $message$body';
  }
}
