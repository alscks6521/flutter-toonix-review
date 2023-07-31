import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toonix2/models/webtoon_model.dart';
import 'package:toonix2/services/api_service.dart';
import 'package:toonix2/widgets/webtoon.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<WebtoonModel>> webtoons = ApiService.getWebtoons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        middle: Text("Toonix 공부"),
      ),
      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error occurred'),
            );
          } else if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: makeList(snapshot),
                )
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  GridView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 한 행에 2개의 항목이 들어가도록 설정
        crossAxisSpacing: 5, // 가로 간격
        mainAxisSpacing: 20, // 세로 간격
      ),
      shrinkWrap: true,
      itemCount: snapshot.data!.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Container(
            child: WebtoonWidget(id: webtoon.id, title: webtoon.title, thumb: webtoon.thumb));
      },
    );
  }
}
