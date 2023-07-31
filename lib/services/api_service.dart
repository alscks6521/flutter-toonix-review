import 'dart:convert';

import 'package:toonix2/models/detail_model.dart';
import 'package:toonix2/models/episode_model.dart';
import 'package:toonix2/models/webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";

  static Future<List<WebtoonModel>> getWebtoons() async {
    List<WebtoonModel> instance = [];
    final url = Uri.parse("$baseUrl/today");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);

      for (var webtoon in webtoons) {
        instance.add(WebtoonModel.fromJson(webtoon));
      }
      return instance;
    }
    throw Error();
  }

  static Future<DetailModel> getWebtoonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return DetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<EpisodeModel>> getWebtoonEpisode(String id) async {
    List<EpisodeModel> episodeInstance = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodeInstance.add(EpisodeModel.fromJson(episode));
      }
      return episodeInstance;
    }
    throw Error();
  }
}
