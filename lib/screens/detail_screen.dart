import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toonix2/models/detail_model.dart';
import 'package:toonix2/models/episode_model.dart';
import 'package:toonix2/services/api_service.dart';
import 'package:toonix2/widgets/episode.dart';

class DetailScreen extends StatefulWidget {
  final String id, title, thumb;

  const DetailScreen({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<DetailModel> webtoon;
  late Future<List<EpisodeModel>> episodes;

  @override
  void initState() {
    super.initState();
    webtoon = ApiService.getWebtoonById(widget.id);
    episodes = ApiService.getWebtoonEpisode(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(widget.title),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                  widget.thumb,
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                  height: 300,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: webtoon,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(
                      snapshot.data!.about,
                      style: const TextStyle(fontFamily: 'Sans Serif', fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(snapshot.data!.genre),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: episodes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: makeList(snapshot),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<EpisodeModel>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var episode = snapshot.data![index];
        return Episode(
          webtoonId: widget.id,
          id: episode.id,
          title: episode.title,
          rating: episode.rating,
          date: episode.date,
        );
      },
    );
  }
}
