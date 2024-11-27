import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:movies/controllers/movie_controller.dart';

import 'package:shimmer/shimmer.dart';

class SlidingImage extends StatelessWidget {
  SlidingImage({super.key, required this.movieController});
  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        try {
          if (movieController.isLoading1.value) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Shimmer.fromColors(
                  baseColor: const Color.fromARGB(255, 37, 35, 35),
                  highlightColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey,
                      ),
                    ),
                  )),
            );
          }
          if (movieController.poster.isEmpty) {
            return const Center(child: Text('No Data found'));
          }
          return Column(
            children: [
              CarouselSlider(
                items: movieController.poster.map(
                  (Movie) {
                    return Builder(
                      builder: (context) {
                        final posterurl = Movie.poster ?? '';
                        if (posterurl.isEmpty) {
                          return Container(
                            color: Colors.black,
                            child: const Center(
                              child: Text(
                                'No Image found',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  posterurl,
                                  fit: BoxFit.fill,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                  viewportFraction: 1.0,
                  aspectRatio: 16 / 9,
                  height: MediaQuery.of(context).size.height * 0.3,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    movieController.currentIndex.value = index;
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: movieController.poster.asMap().entries.map(
                  (e) {
                    return GestureDetector(
                      onTap: () => movieController.currentIndex.value = e.key,
                      child: Container(
                        height: 6,
                        width: movieController.currentIndex.value == e.key
                            ? 16
                            : 6,
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (movieController.currentIndex.value == e.key
                              ? Colors.red
                              : Colors.grey),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ],
          );
        } catch (error) {
          print(error);
          return Center(
            child: Text(error.toString()),
          );
        }
      },
    );
  }
}
