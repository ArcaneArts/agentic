import 'package:agentic/agentic.dart';
import 'package:decimal/decimal.dart';
import 'package:fast_log/fast_log.dart';
import 'package:http/http.dart' as http;
import 'package:threshold/threshold.dart';
import 'package:toxic/extensions/iterable.dart';

@dmodel
class NagaModelsListResponse {
  final List<NagaModel> data;

  const NagaModelsListResponse({this.data = const []});
}

@dmodel
class NagaModel {
  final String id;
  final int context_length;
  final NagaArchitecture architecture;
  final NagaPricing pricing;
  final List<String> supported_parameters;

  const NagaModel({
    required this.id,
    this.context_length = 200000,
    required this.architecture,
    this.supported_parameters = const [],
    this.pricing = const NagaPricing(),
  });

  ChatModel get toChatModel => ChatModel(
    id: id,
    cost: ChatModelCost(
      input:
          (Decimal.parse(pricing.prompt) * Decimal.fromInt(1_000_000))
              .toDouble() *
          1.06,
      output:
          (Decimal.parse(pricing.completion) * Decimal.fromInt(1_000_000))
              .toDouble() *
          1.06,
    ),
    capabilities: ChatModelCapabilities(
      tools:
          supported_parameters.contains("tools") &&
          supported_parameters.contains("tool_choice"),
      ultraCompatibleMode: false,
      systemMode: ChatModelSystemMode.supported,
      contextWindow: context_length,
      maxTokenOutput: 16384,
      inputModalities:
          architecture.input_modalities
              .map(
                (i) => Modality.values.select(
                  (v) => v.name.toLowerCase() == i.toLowerCase(),
                ),
              )
              .whereType<Modality>()
              .toList(),
      outputModalities:
          architecture.output_modalities
              .map(
                (i) => Modality.values.select(
                  (v) => v.name.toLowerCase() == i.toLowerCase(),
                ),
              )
              .whereType<Modality>()
              .toList(),
      reasoning: supported_parameters.contains("reasoning"),
      structuredOutput: supported_parameters.contains("response_format"),
      streaming: true,
      seesToolMessages:
          supported_parameters.contains("tools") &&
          supported_parameters.contains("tool_choice"),
    ),
  );
}

@dmodel
class NagaArchitecture {
  final List<String> input_modalities;
  final List<String> output_modalities;
  final String? tokenizer;

  const NagaArchitecture({
    this.input_modalities = const [],
    this.output_modalities = const [],
    this.tokenizer,
  });
}

@dmodel
class NagaPricing {
  final String prompt;
  final String completion;
  final String request;
  final String image;
  final String audio;
  final String web_search;
  final String internal_reasoning;

  const NagaPricing({
    this.prompt = "0",
    this.completion = "0",
    this.request = "0",
    this.image = "0",
    this.web_search = "0",
    this.audio = "0",
    this.internal_reasoning = "0",
  });
}

//////////////////////////////////////////////////////////////////////

void main() async {
  print("const String _nagaData = \"${await getLiveNagaData()}\";");
}

Future<String> getLiveNagaData() => http
    .get(Uri.parse("https://api.naga.ac/v1/models"))
    .then(
      (v) => compress(
        $NagaModelsListResponse.from.json(v.body).to.json,
        allowBZip2: false,
        allowZLib: false,
      ),
    )
    .catchError((e, es) {
      warn("Failed to get live Naga data. Using internal fallback.");
      warn("$e, $es");
      return _nagaData;
    });

Future<List<ChatModel>> getLiveNagaModels() async =>
    $NagaModelsListResponse.from
        .json(decompress(await getLiveNagaData()))
        .data
        .map((i) => i.toChatModel)
        .toList();

const String _nagaData =
    "*H4sIAAAAAAACE-1d63KjOBN9F367XUhA7ORVtrZcAmRbn0FihPA4OzXv_pUAX5I42WQHOxL0_tnJxGPsPrr05fTpX0HODAue_voViDx4CjZFCfE8ASb001pzHsyCTEnDD2ZVcLkx2-CJhva_WcB0thWGZ6bRPHj6FQhZNWZVqpwVwgheB09_BfYfBn_PAtWY9375exbUTVUpbXi-qphmJTdcty8o2WGVqbIquBFKrozacVkHs0BzVisp5GbF12ulTTALDC8rrln7WWaBUapYZVslsuNPdfv_alXZT1NpkQm5sR-60qqsTPAUhO03PT6r_wvNfzS8Pv5alGzD-z__5Omq5tYE_V-wJhfq-EJpuJasWJ0-aPuL379nvZUlL5XRSkIEdVNxDYSGKTBCU5eNXldK1ny1Vrpk_tncruxkTr7Vtuv2y8nseVVxyQrzHMyCQm2EWaWC1d0PlVap_eN7ONh3LAperDqDs6K1c6V5LrLWjO0PNZcZv3jKlS3zFtDaqMo7XEshRckOUNL5wpfTajSmr41mBdQlKwqgD2E0BADHTzjoLht6N40Cv01lIJnHIJlUQyI3C9aiGBjAdSNbQFqMLn6uXx-h33huXoX7DNFKVd0ndgl7e3wi9hPD3rpCYBqdKrfdoXfxnJKDs9FqB_GchpByw5y4Yb-2zz4Fzecxcf5IrTTeptO8TRH2KcIeQbZtvwJiPyXsuXWdIZoTWBes3kIhDIdK873gP4ddDN3n-tNFcd_8hD-4tW_93cCdXLIPAGxfscqUXIvNB_t0angez2CV84Oz-Sc8fYdFveY815zZONaeu_fA_d83aC3-4a6dcZVWeCk5f4hlBWtyDrWSkhuI5w_OHmSYn3mN3Y-fXEbzBKLHha3hLlI_sPtMqXFKMBotpDDPUDB9dgexHH-Hsm2CNfmxpaxtgQFRHRmqvZOiqqZGF8U_FwV4mfI8F3IDy_SWm_P0nPpD6HJRclk744LvRClgN9Bt5Ib7hufXC4TXRXMAOnR5bgTpgt4wJTugYa4ZZl1wtMxVy-wKLiTEKVrnjf8bzxddgcF_P3hSoUtbTqBYTphUOcE6yH0hkCaE3nLLenSMXViF58JY0xA86a_XoeL7BA4emeYiw0fwDvQtfRd_czcNgvbl7VYq2FP0OT3cb325vickYbneB85R5xeReQI0pAkQCuTBDQ8gZdluo1Uj83aD1btgFvxo7FvYbeROkHyMtJA8O1HidJuLPW8fgqtgmqsAV8C0VwDpsm33KkAg8g5pB3R0q6GSbqgdcC_8cs6rmvMd7KM5RarPqKk-XYhDSOj8_YzUn3dzC9bVxlYnv9MOnRIAgTWrDZxf5aMkwBj7_1_AI5VEiFxt_sS2KI96O0_h4cBSRRgf-pIZQNSnhjrWBCaLfZcNJkAiXAHTWgF9CwaYrZC7gbxmZDHcn--FuPmE27aRzw07Ej0j5L6-InYirfNaanjLxK4554ZDzA17mxum8-RSCutuwRYmgv-0eFqq3H4ToSTQ-D7c_PMjP8LNBSPtuRQZh0ZmXNZK89w5t-ReheUrS9yJKShqz9pE7J44nR__4rmxc2vUjDVyK02JVr6xlUuRDbaY0byvQ8vuxlum9qYLJ3uU-zwfJgkfkOPlFX5s8xrBR9x5_nTwPWAizkPS3UkEtEuthI_0EVMrXtNjgR8q3Ir-CaZZ7oGGqmhqJ136T11fnmckL4cqQPjYnog3OA2PHxMJWwPjh9D5Al135O0LoFGSAqM0HbQOfzv26vhOwStQCFkb3WQGofhuCaTwEQvCb3lbw_M0kbDlPmHrFOVYvqYNdQgYrkshv9ljxnjnP-WLEgTNv8GwvnUbjbj1y6e-vFHC8HMr6orrXlRgHw0y4_oPw8uCyU3TQ-hIZCH5wcAyTIFFKZKtPU5QvgByyBDRPSBHhNpAMjcYvn--oyR8DEc8j2isReyr9ORbtG0jTfl2XrFNDHWOMYFwSZPRTdPzKDszpSNwzJ5feyYuqNs-33TdvKJgJQNL_CAkhb2wQ87cquCgm_5hGkH8w3RelEBheaA0xYjK7XE93QVXMGOfgCWo6alGgGSyF5IOlxAucBHcZBG4g3cXGCLek970iP-U8Vd1DTQcaPLkjSnxGNl-BVWCsI5XS7rT9wqXYYJNLf6SIZEC-XYaMoGd5gxyvkcJpU5CybC04JCL9bppU2BRR8z4VvO4UwZ-y7O37GKcuuhroxgC5x9w5z2IW28UvYLYYOZs0H50kjp47jXsy0MvsjdQpRUa6MMd_7TWHHe822m6GAgJH4YlbY0oQTv6VnBepjzPbXAzkETse7ifHlR_iH4uSi5r1yTPkZvqZ-9VuLhPOzASG9_GblHX94DUN-f2RTTYqKb7KMVN62I-zWkgmO_wb2vhrnJc-Si8VK66zVgEjE-HwYwXfM8llE1hRCFsm24BezpYVuE9eHrwPsDntdFdTL7guvZBhW3gJCICNWyHllVV5hDd_MjxTE4qVh3D15jagdP42LnT5wOvLMiK89xNxXWCet0--PbtO8lhZo2N4AxQLUswBkKBLMbBE7w9gfvVgnf64qszLdIBRtKMSZunj0b2EcYe715rLGX2VqN4q3nC0LF90EAXKQinG5-nm7DvSSd1tpW8KDAQecV2H0JADtWavsQXCR-GmvyOPBEPciCdWEYMdaYaA2SRAnngI1TLwEawPrPTRnZhAkPt8hG27Y59ykQ0Bk0V3NCth4RqlvfWlYJF6LDyFzIEX4uARajT5nK80YZ4vVcSQ_iIXslEY5BWsA9PVl_SBIQm2FYyua2qyEn8yx7WQKgD4DsXXS9h2FnruDm8yqWVbM-1yHZdOo0up51PG5FeAYmx38UpWGolmR6KZek8L9-56eqVVnuuYU9xV7iY-3iZqrp5cflmQE3srtkxmQtZ757hxjMjvFDr0jzTbG1uTMzywhRtCxoF1mil2eStoUopoLTSX8w-7RSS0od7eNnnB7tup5dzaMKIxlj88_-SOKHavYBrCBO6RCELP9V5o3kCtZKSm_YYIyGl49XnHQVwqrLF954YLXmpgMZuShj-5y03BY60lQ49DKaXgfvtZkBV4tButW62NI0JcTaXihvtg2Z_JdWp159gq807ZSSjmeyatLBD66INKf-farTkz5OPfd9qu88TVHfvHLOon0wUA8Ei7D3DYmfrsj-3oq647n2H_SB6D2M6WI_E1qWP7Ku3q9vVstmxLEOcNjRmbD6LotM8cJxR-6pq0s-BJpRQ_yLHafGouqboObk1scO_4QQ43eok2ZNztdGshD29fZe4HzGh5UK5SfIYMxmqHRZyltmPOvEvlNq_TtU7_RZJe_e2f34o8O64TLJ2b3BsYumzRhEQ4lDWyDk-2vdL1Dg4vg6jP2ejv_LZbJXV2y8okAiRchepN47UzesZfjpSR8pQN9Lb0oVCSh_dXtjTW80XxK4tE7sGeV0-dRRZdiXY79i-DYYp9w1TUAbxei4UmsJ8M_HfHcOc6zBxmGAhxh-tU0zqv-LEdQo4t22i9JMN95q4gZyNM80pPglxINcJuU6f1HMdfGQ3Uk_uH1O2cX_c7vwwIfF4A8qx9u7ZRsy-BlEwY58w9ZyAF2PC0Gu9HJaE5ugbk7YCYtQ_cU6hcE5AMqnODnKMDvL0xgL3K-FlqIQrAVdCvxIGD4hwOXixHI6d-yXPRVPaoWYJ9hP7WF-9qK6GkZsCDFgGP2qbYNLC976nTcN0DnY0bDq6gYJjRU5Fl14PgYigYPuUSwRvppRH6Pr4lt5o3w3uooHz77m4lGW7jVaNzFvI6l0wC3409i2s1V3roetnrWL6shfAKksmc2C29cHeEM550H9-KUxrKNyPccz3G7XkXHcB0yQkOErdiy6S3mUaVn0OcbsbC39xIa-ahJQ8YgLC0_nFF-OnFkCWmLuf7LjAyHkFHiSwvT8kjRCgIe7eye3eoxBsUxhxUoJF7vuH150x9fca6HjI9kv_yvqsOM_dsBvvPIR5COuC1VsIw1sIOsz-tJvgvRNjYsnott8SOyy_gQmDdCi8hV_ewqjHfrLT37__DxSst-ubYQEA";

List<NagaModel> rawNagaModels =
    $NagaModelsListResponse.from.json(decompress(_nagaData)).data;
List<ChatModel> nagaChatModels =
    rawNagaModels.map((i) => i.toChatModel).toList();
