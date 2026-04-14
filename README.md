# Agentic

`agentic` is a Dart package for building AI-powered apps with one consistent API across multiple providers.

It gives you:

- direct chat calls through a shared request/response model
- built-in model metadata for pricing and capabilities
- a stateful `Agent` abstraction for multi-step tool use
- structured output via JSON schema
- embeddings on supported OpenAI-compatible backends, including OpenRouter
- an OpenRouter management-key client for API key lifecycle management
- built-in chunking plus recursive distillation utilities for long-form ingestion

## What This Project Is

Agentic is a lightweight wrapper around several LLM providers that normalizes the parts that are usually annoying to re-implement over and over:

- provider-specific request formatting
- model capability differences
- tool calling
- structured outputs
- token usage and cost tracking
- stateful chat history for agents

Instead of wiring each provider differently, you work with the same `ChatRequest`, `ChatModel`, `Message`, `Content`, `Tool`, and `Agent` types.

## What It Supports

Out of the box, the package includes connectors for:

- OpenAI
- Anthropic
- xAI
- Inception Labs
- Ollama

There are also additional OpenAI-compatible connectors in the repo for:

- OpenRouter
- Naga

Those advanced connectors currently require direct imports instead of the main barrel export.

The package also includes a typed `OpenRouterManagementClient` for managing OpenRouter API keys with a management key.

## Features

- Unified connector interface with `ChatConnector`
- Built-in model catalog with pricing and capability metadata
- Exact cost tracking using `Rational`
- Text and image chat inputs through the shared `Content` model
- Stateful agents with recursive tool execution
- Tool schemas with strict JSON-schema-based arguments
- Structured outputs with `ToolSchema`
- Embeddings on supported OpenAI-compatible connectors, including OpenRouter
- OpenRouter management-key client for creating, listing, updating, and deleting API keys
- Local model support through Ollama
- Built-in document chunking, text-file ingestion, rechunking, distillation, and recursive summarization
- Generated codecs for Agentic's own data models via `artifact`

## Installation

```bash
dart pub add agentic
```

If you want generated schemas/codecs for your own tool input/output models, also add:

```bash
dart pub add artifact
dart pub add dev:build_runner
dart pub add dev:artifact_gen
```

Then run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Core Concepts

- `ChatConnector`: a provider client such as `OpenAIConnector` or `AnthropicConnector`
- `ChatModel`: a model definition with id, pricing, and capabilities
- `ChatRequest`: the normalized request object sent to a connector
- `Message` and `Content`: shared chat/message primitives
- `Agent`: a stateful wrapper that reads history, calls the model, runs tools, and appends results
- `Tool`: a callable unit the model can invoke
- `ToolSchema`: a JSON schema for structured model output
- `IChunker` and `IDistiller`: built-in helpers for chunking and LLM-backed distillation

## Basic Usage

```dart
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/agentic.dart';

Future<void> main() async {
  OpenAIConnector openai = OpenAIConnector(apiKey: 'sk-proj-...');

  ChatResult result = await openai(
    ChatRequest(
      model: ChatModel.openai4_1Mini,
      messages: [
        Message.system('You are brief and helpful.'),
        Message.user('Give me three weekend side-project ideas.'),
      ],
    ),
  );

  print(result.message.content);
  print('Input tokens: ${result.usage.inputTokens}');
  print('Output tokens: ${result.usage.outputTokens}');
  print('Approx cost: \$${result.realCost.toDouble()}');
}
```

What this does:

- sends a normalized `ChatRequest`
- returns an `AgentMessage` inside `ChatResult`
- tracks token usage and exact estimated cost

## Connector Examples

```dart
import 'package:agentic/agentic.dart';

OpenAIConnector openai = OpenAIConnector(apiKey: 'sk-proj-...');
AnthropicConnector anthropic = AnthropicConnector(apiKey: 'sk-ant-...');
XaiConnector xai = XaiConnector(apiKey: 'xai-...');
InceptionLabsConnector inception = InceptionLabsConnector(apiKey: '...');
OLlamaConnector ollama = OLlamaConnector();
```

If you want a connected model object for agents, use `connect`:

```dart
import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/connected_model.dart';

ConnectedChatModel llm = OpenAIConnector(apiKey: 'sk-proj-...')
    .connect(ChatModel.openai4_1Mini);
```

## OpenRouter Management Keys

`OpenRouterManagementClient` is a separate utility client for OpenRouter's management-key API. You pass it a management key such as `sk-management-...` and use it to create, list, inspect, update, enable, disable, and delete OpenRouter API keys.

Unlike `OpenRouterConnector`, this is not a chat connector. It is an HTTP client for key administration.

```dart
import 'package:agentic/agentic.dart';

Future<void> main() async {
  OpenRouterManagementClient client = OpenRouterManagementClient(
    'sk-management-key',
  );

  OpenRouterCreatedApiKey recurring = await client.createRecurringKey(
    name: 'Analytics Service Key',
    limit: 100,
    reset: OpenRouterApiKeyLimitReset.weekly,
    includeByokInLimit: false,
  );

  print('New key secret: ${recurring.key}');
  print('New key hash: ${recurring.data.hash}');

  OpenRouterCreatedApiKey oneTime = await client.createOneTimeUseBurnKey(
    name: 'Temporary Burn Key',
    limit: 15,
    expiresAt: DateTime.utc(2029, 11, 30, 23, 59, 59),
  );

  List<OpenRouterManagedApiKey> keys = await client.listApiKeys(
    includeDisabled: true,
  );
  print('Managed key count: ${keys.length}');

  OpenRouterCurrentApiKey current = await client.getCurrentApiKey();
  print('Is management key: ${current.isManagementKey}');

  OpenRouterManagedApiKey updated = await client.setRecurringLimit(
    recurring.data.hash,
    name: 'Updated Analytics Key',
    limit: 75,
    reset: OpenRouterApiKeyLimitReset.daily,
  );

  print('Updated limit reset: ${updated.limitReset}');

  await client.disableKey(oneTime.data.hash);
  await client.removeApiKey(oneTime.data.hash);

  client.close();
}
```

Common methods:

- `getCurrentApiKey()` or `getCurrentKey()`
- `listApiKeys()` or `listKeys()`
- `getApiKey(hash)` or `getKey(hash)`
- `createApiKey(request)` or `createKey(request)`
- `createRecurringKey(...)`
- `createOneTimeUseBurnKey(...)`
- `updateApiKey(hash, request)` or `updateKey(hash, request)`
- `setRecurringLimit(...)`
- `setOneTimeUseBurnLimit(...)`
- `enableKey(hash)`
- `disableKey(hash)`
- `removeApiKey(hash)` or `deleteApiKey(hash)`

Request helpers:

- `OpenRouterCreateApiKeyRequest.recurring(...)` creates a key with a recurring budget reset such as daily, weekly, or monthly
- `OpenRouterCreateApiKeyRequest.oneTimeUseBurn(...)` creates a fixed-spend burn key with no recurring reset
- `OpenRouterCreateApiKeyRequest.unlimited(...)` creates a key with no spending limit
- `OpenRouterUpdateApiKeyRequest.recurring(...)` changes a key to a recurring budget
- `OpenRouterUpdateApiKeyRequest.oneTimeUseBurn(...)` changes a key to a one-time burn budget
- `OpenRouterUpdateApiKeyRequest.unlimited(...)` clears spending limits and recurring resets

Notes:

- `createRecurringKey` and `createOneTimeUseBurnKey` return an `OpenRouterCreatedApiKey`, which includes both the created key metadata and the actual secret key string.
- The secret key value is only returned at creation time by OpenRouter, so you should store it when you create it.
- `expiresAt` is sent as a UTC ISO 8601 timestamp.
- `limitReset` uses `OpenRouterApiKeyLimitReset.daily`, `.weekly`, or `.monthly`.

## Stateful Agents

`Agent` is the higher-level abstraction in this package. It keeps chat history in a `ChatProvider`, calls the model, executes tools, appends tool responses, and can continue recursively.

`MemoryChatProvider` is available, but it currently needs a direct import:

```dart
import 'package:agentic/agentic.dart';
import 'package:agentic/chat/agent/chat_provider.dart';

Future<void> main() async {
  Agent agent = Agent(
    llm: OpenAIConnector(apiKey: 'sk-proj-...')
        .connect(ChatModel.openai4_1Mini),
    chatProvider: MemoryChatProvider(
      messages: [
        Message.system('You are a helpful assistant.'),
        Message.user('Explain what this library does in one sentence.'),
      ],
    ),
  );

  AgentMessage firstReply = await agent();
  print(firstReply.content);

  await agent.addMessage(
    Message.user('Now rewrite that for a README tagline.'),
  );

  AgentMessage secondReply = await agent();
  print(secondReply.content);
}
```

## Tool Example

```dart
import 'package:agentic/agentic.dart';
import 'package:agentic/chat/agent/chat_provider.dart';

class UppercaseTool extends Tool {
  UppercaseTool()
      : super(
          name: 'uppercase',
          description: 'Convert a string to uppercase.',
        );

  @override
  Map<String, dynamic> get schema => {
        'type': 'object',
        'additionalProperties': false,
        'required': ['text'],
        'properties': {
          'text': {
            'type': 'string',
            'description': 'The text to convert to uppercase.',
          },
        },
      };

  @override
  Future<String> call({
    required Agent agent,
    required Map<String, dynamic> arguments,
  }) async {
    return (arguments['text'] as String).toUpperCase();
  }
}

Future<void> main() async {
  Agent agent = Agent(
    llm: OpenAIConnector(apiKey: 'sk-proj-...')
        .connect(ChatModel.openai4_1Mini),
    chatProvider: MemoryChatProvider(
      messages: [
        Message.system('Use tools when they help.'),
        Message.user('Turn "agentic makes wrappers easier" into uppercase.'),
      ],
    ),
  );

  AgentMessage reply = await agent(tools: [UppercaseTool()]);
  print(reply.content);
}
```

## Structured Output Example

Use `responseFormat` when you want a strict JSON object back instead of free-form text.

```dart
import 'dart:convert';

import 'package:agentic/agentic.dart';
import 'package:agentic/chat/connector/result.dart';

Future<void> main() async {
  OpenAIConnector openai = OpenAIConnector(apiKey: 'sk-proj-...');

  ChatResult result = await openai(
    ChatRequest(
      model: ChatModel.openai4_1Mini,
      messages: [
        Message.user('Summarize Agentic in one sentence and give it 3 tags.'),
      ],
      responseFormat: const ToolSchema(
        name: 'project_summary',
        description: 'A short summary and tags for the project.',
        schema: {
          'type': 'object',
          'additionalProperties': false,
          'required': ['summary', 'tags'],
          'properties': {
            'summary': {'type': 'string'},
            'tags': {
              'type': 'array',
              'items': {'type': 'string'},
            },
          },
        },
      ),
    ),
  );

  Map<String, dynamic> json = jsonDecode(result.message.content.toString())
      as Map<String, dynamic>;

  print(json['summary']);
  print(json['tags']);
}
```

This is currently a good fit for connectors in this package that support structured output, such as OpenAI and xAI.

## Multimodal Example

For multimodal prompts, build a `UserMessage` manually with grouped content:

```dart
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/agentic.dart';

Future<void> main() async {
  OpenAIConnector openai = OpenAIConnector(apiKey: 'sk-proj-...');

  ChatResult result = await openai(
    ChatRequest(
      model: ChatModel.openai4_1Mini,
      messages: [
        Message.system('Answer in one sentence.'),
        UserMessage(
          content: Content.group([
            Content.text('What is happening in this image?'),
            Content.imageUrl('https://example.com/example.png'),
          ]),
        ),
      ],
    ),
  );

  print(result.message.content);
}
```

## Local Models With Ollama

For local or custom OpenAI-compatible models, define the model yourself:

```dart
import 'package:agentic/chat/connector/result.dart';
import 'package:agentic/agentic.dart';

Future<void> main() async {
  OLlamaConnector ollama = OLlamaConnector();

  ChatResult result = await ollama(
    ChatRequest(
      model: ChatModel.basic('gpt-oss:20b'),
      messages: [
        Message.user('Write a haiku about clean APIs.'),
      ],
    ),
  );

  print(result.message.content);
}
```

Use:

- `ChatModel.basic(...)` when the backend behaves like a modern tool/JSON-capable model
- `ChatModel.safe(...)` when you want a conservative fallback with fewer assumptions

## Embeddings Example

OpenAI-compatible connectors that implement embeddings expose `embed` and `embedMultiple`.

```dart
import 'package:agentic/agentic.dart';

Future<void> main() async {
  OpenAIConnector openai = OpenAIConnector(apiKey: 'sk-proj-...');

  List<double> vector = await openai.embed(
    model: 'text-embedding-3-small',
    text: 'Agentic wraps multiple providers behind one Dart API.',
    dimensions: 256,
  );

  print('Embedding dimensions: ${vector.length}');
}
```

OpenRouter embeddings are also supported through `OpenRouterConnector`, which currently needs a direct import:

```dart
import 'package:agentic/chat/connector/connector_openrouter.dart';

Future<void> main() async {
  OpenRouterConnector openrouter = OpenRouterConnector(
    apiKey: 'sk-or-v1-...',
  );

  List<double> vector = await openrouter.embed(
    model: 'perplexity/pplx-embed-v1-4b',
    text: 'Agentic wraps multiple providers behind one Dart API.',
    dimensions: 256,
  );

  print('OpenRouter embedding dimensions: ${vector.length}');
}
```

## Chunking And Distillation

`IChunker` is built into Agentic and uses BPE-assisted splitting to break long text into chunk content plus a small post-overlap window. `IDistiller` uses an LLM to recursively compress or summarize those chunks.

`IDistiller` currently needs a direct import:

```dart
import 'package:agentic/agentic.dart';
import 'package:agentic/ingest/distiller.dart';

const longDocumentText = '''
Put a long body of text here.
It can be OCR output, a transcript, notes, or raw document text.
''';

Future<void> main() async {
  IChunker chunker = IChunker(maxChunkSize: 500, maxPostOverlap: 100);
  IDistiller distiller = IDistiller(
    llm: OpenAIConnector(apiKey: 'sk-proj-...')
        .connect(ChatModel.openai4_1Mini),
    targetOutputSize: 400,
  );

  await for (IChunk chunk in chunker.recursiveDistillChunks(
    chunks: chunker.chunkString(longDocumentText),
    distiller: distiller,
    factor: 4,
    parallelism: 4,
  )) {
    print('L${chunk.lod} #${chunk.index}: ${chunk.fullContent}');
  }
}
```

This is useful for:

- hierarchical summarization
- document ingestion pipelines
- cleaning up noisy OCR text
- compressing large inputs before later prompts

## Advanced Imports

The main barrel export is:

```dart
import 'package:agentic/agentic.dart';
```

A few useful pieces currently live behind direct imports:

```dart
import 'package:agentic/chat/agent/chat_provider.dart';
import 'package:agentic/chat/connector/connector_naga.dart';
import 'package:agentic/chat/connector/connector_openrouter.dart';
import 'package:agentic/ingest/distiller.dart';
import 'package:agentic/util/naga_models.dart';
import 'package:agentic/util/open_router_models.dart';
```

That gives you access to:

- `MemoryChatProvider`
- `NagaConnector`
- `OpenRouterConnector`
- `IDistiller`
- live or cached model catalogs for Naga and OpenRouter

## Notes And Limitations

- `AnthropicConnector` in this package does not currently support `responseFormat`; it throws if structured output is requested.
- `OpenRouterConnector` supports embeddings through the same `embed` and `embedMultiple` interface as other OpenAI-compatible connectors.
- `OpenRouterManagementClient` is for management-key administration, not chat completions.
- `chunkTextFile(...)` is intended for UTF-8 text files; richer document parsing lives outside Agentic.
- Audio content types exist in the shared content model, but the current LangChain bridge only wires text and images for chat requests.
- `OpenRouterConnector` and `NagaConnector` are present in the repo, but they are not exported from the main `agentic.dart` barrel yet.

## Why Use It

Agentic is a good fit if you want a small Dart-first library that lets you:

- swap providers without rewriting your application code
- build tool-using agents without wiring a loop from scratch
- keep model metadata and cost tracking close to your call site
- use local and hosted models through the same abstractions
- add chunking, text-file ingestion, and distillation without pulling in a second ingestion package

If you want one package that covers direct prompting, agents, tools, structured output, cost tracking, and ingestion utilities, that is what this repo is built for.
