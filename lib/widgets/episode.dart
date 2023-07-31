import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  final String webtoonId, id, title, rating, date;
  const Episode({
    super.key,
    required this.webtoonId,
    required this.id,
    required this.title,
    required this.rating,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        //! trim() = 문자열에서 앞,뒤 공백을 지워줌 // isNotEmpty = 문자열이 있을때.

        // const episodeId = int.parse;
        await launchUrlString('https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=$id');
      },
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey[100]),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Sans Serif',
                      fontSize: 20,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
