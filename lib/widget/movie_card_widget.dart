import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movies/views/detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  const MovieCardWidget(
      {super.key, required this.posterUrl, required this.title});
  final String posterUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    print(posterUrl);
    return Container(
      height: 150,
      width: 100,
      child: InkWell(
        onTap: () {
          Get.to(() => DetailScreen(
                title: title,
              ));
        },
        child: posterUrl.isNotEmpty && posterUrl != 'N/A'
            ? Image.network(posterUrl,
                height: 150,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                      'assets/images/luffy.jpg',
                      fit: BoxFit.cover,
                    ))
            : Image.asset(
                'assets/images/luffy.jpg',
                height: 150,
                width: 100,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
