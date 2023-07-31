import 'package:flutter/material.dart';
import 'package:toonix2/screens/detail_screen.dart';

class WebtoonWidget extends StatelessWidget {
  final String id, title, thumb;

  const WebtoonWidget({
    super.key,
    required this.id,
    required this.title,
    required this.thumb,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(id: id, title: title, thumb: thumb),
          ),
        );
      },
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(
                  thumb,
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 17, overflow: TextOverflow.ellipsis, fontFamily: 'Sans Serif'),
            ),
          ],
        ),
      ),
    );
  }
}
