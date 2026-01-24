import 'package:dio/dio.dart';
import 'package:example/core/model/anime_model.dart';

Future<AnimeModel?> getAnimeList({
  required int page,
  Map<String, dynamic>? queryParameters,
}) async {
  try {
    String url = "https://api.jikan.moe/v4/anime";

    final response = await Dio().get(url, queryParameters: queryParameters).then(
      (value) {
        return value;
      },
    );
    if (response.statusCode != 200) {
      throw Exception(response.statusMessage);
    }
    return AnimeModel.fromJson(response.data);
  } catch (exception) {
    throw Exception(exception);
  }
}
