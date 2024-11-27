import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/controllers/webseries_contoller.dart';
import 'package:movies/views/genre_screen.dart';
import 'package:movies/widget/movie_card_widget.dart';
import 'package:shimmer/shimmer.dart';

class MoviesWidget extends StatefulWidget {
  const MoviesWidget({
    super.key,
  });
  // final String type;
  @override
  State<MoviesWidget> createState() {
    return _MoviesWidgetState();
  }
}

class _MoviesWidgetState extends State<MoviesWidget> {
  final RxInt _selectedIndex = 0.obs;

  final MovieController movieController = Get.put(MovieController());
  final WebseriesContoller webseriesContoller = Get.put(WebseriesContoller());

  List<String> genre = [
    'Action',
    'Adventure',
    'Animation',
    'Biography',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Sport',
    'Thriller',
    'War',
    'Western'
  ];

  @override
  void initState() {
    super.initState();
    movieController.fetchMovies(something: 'trending movies');

    movieController.fetchMovies(genre: 'Comedy');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(114, 133, 29, 21),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: ToggleButtons(
                  fillColor: Colors.red,
                  disabledColor: const Color.fromARGB(162, 171, 64, 56),
                  renderBorder: false, // Disable the border of ToggleButtons
                  onPressed: (index) {
                    _selectedIndex.value = index;
                    if (index == 0) {
                      movieController.fetchMovies(something: 'trending movies');

                      movieController.fetchMovies(genre: 'Comedy');
                    } else if (index == 1) {
                      webseriesContoller.fetchWebSeries(
                          somthing: 'trending webseries');
                      webseriesContoller.fetchWebSeries(genre: 'Action');
                    }
                  },
                  isSelected: [
                    _selectedIndex.value == 0,
                    _selectedIndex.value == 1
                  ],
                  borderRadius: BorderRadius.circular(13),
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 65),
                      child: Text(
                        'Movies',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 65),
                      child: Text(
                        'WebSeries',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: genre.map(
                      (e) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Get.to(() => GenreScreen(
                                      genre: e,
                                      index: _selectedIndex.value,
                                    ));
                              },
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                // trending
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 1, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Trending',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.red,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Obx(
                  () {
                    if (movieController.isLoading.value ||
                        webseriesContoller.isLoading.value) {
                      const demoitem = 10;
                      return SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 37, 35, 35),
                          highlightColor: Colors.white,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: demoitem,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    final items = _selectedIndex == 0.obs
                        ? movieController.movies
                        : webseriesContoller.movies;

                    if (items.isEmpty) {
                      return const Center(child: Text('No Data found'));
                    }

                    return SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: MovieCardWidget(
                              posterUrl: item.poster!,
                              title: item.title!,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                // history
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 1, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'History',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.red,
                            size: 30,
                          ))
                    ],
                  ),
                ),
                Obx(
                  () {
                    if (movieController.isLoading2.value ||
                        webseriesContoller.isLoading2.value) {
                      const demoitem = 10;
                      return SizedBox(
                        height: 150,
                        width: double.infinity,
                        child: Shimmer.fromColors(
                          baseColor: const Color.fromARGB(255, 37, 35, 35),
                          highlightColor: Colors.white,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: demoitem,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 150,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                    print(
                        'final loading 2    ${movieController.isLoading2.value}   ${webseriesContoller.isLoading2.value} ');
                    final items1 = _selectedIndex == 0.obs
                        ? movieController.history
                        : webseriesContoller.history;

                    if (items1.isEmpty) {
                      return const Center(child: Text('No Data found'));
                    }

                    return SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items1.length,
                        itemBuilder: (context, index) {
                          final item = items1[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: MovieCardWidget(
                              posterUrl: item.poster!,
                              title: item.title!,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
