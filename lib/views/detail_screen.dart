import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/controllers/webseries_contoller.dart';
import 'package:movies/widget/search_widget.dart';
import 'package:shimmer/shimmer.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({super.key, required this.title});

  final String title;

  @override
  State<DetailScreen> createState() {
    return _DetailScreenState();
  }
}

class _DetailScreenState extends State<DetailScreen> {
  final MovieController movieController2 = Get.put(MovieController());
  final WebseriesContoller webseriesContoller2 = Get.put(WebseriesContoller());
  final RxInt _selectedIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMovieDetail(widget.title);
      if (movieController2.detailMovie.isNotEmpty) {
        final movie = movieController2.detailMovie[0];
        if (movie.type == 'movie') {
          getMovies(movie.genre!.split(',').first);
        } else {
          getWebSeries(movie.genre!.split(',').first);
        }
      }
    });
  }

  void getMovies(String genre) {
    movieController2.fetchMovies(genre: genre);
    movieController2.update();
  }

  void getWebSeries(String genre) {
    webseriesContoller2.fetchWebSeries(genre: genre);
    movieController2.update();
  }

  void fetchMovieDetail(String title) {
    movieController2.fetchMovies(title: title);
  }

  void fetchWebSeriesDetail(String title) {
    webseriesContoller2.fetchWebSeries(title: title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Obx(
        () {
          if (movieController2.isLoading3.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (movieController2.detailMovie.isEmpty) {
            return const Center(
              child: Text('No Data Found'),
            );
          }
          final movie = movieController2.detailMovie[0];

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: movie.poster != null &&
                            movie.poster!.isNotEmpty &&
                            movie.poster != 'N/A'
                        ? Image.network(
                            movie.poster!,
                            fit: BoxFit.fill,
                            height: 275,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              'assets/images/mugivara.jpeg',
                              fit: BoxFit.fill,
                            ),
                          )
                        : Image.asset(
                            'assets/images/mugivara.jpeg',
                            fit: BoxFit.fill,
                            height: 275,
                            width: double.infinity,
                          ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: Text(
                      movie.title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: Text(
                      movie.genre!,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white38,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.list,
                              size: 45,
                              color: Color.fromARGB(255, 114, 50, 45),
                            ),
                          ),
                          const Text(
                            'List',
                            style: TextStyle(
                              color: Color.fromARGB(213, 255, 255, 255),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.file_download_outlined,
                              size: 45,
                              color: Color.fromARGB(255, 114, 50, 45),
                            ),
                          ),
                          const Text(
                            'Download',
                            style: TextStyle(
                              color: Color.fromARGB(213, 255, 255, 255),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share,
                              size: 45,
                              color: Color.fromARGB(255, 114, 50, 45),
                            ),
                          ),
                          const Text(
                            'Share',
                            style: TextStyle(
                              color: Color.fromARGB(213, 255, 255, 255),
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                    child: Text(
                      'Review',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                    child: Text(
                      '${movie.imdbRating!} / 10',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ToggleButtons(
                    disabledBorderColor: Colors.transparent,
                    selectedBorderColor: const Color.fromARGB(255, 114, 50, 45),
                    onPressed: (index) {
                      _selectedIndex.value = index;
                      print(movie.id);
                    },
                    isSelected: [
                      _selectedIndex.value == 0,
                      _selectedIndex.value == 1
                    ],
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 65),
                        child: Text(
                          'Sypnosis',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 65),
                        child: Text(
                          'Cast',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(() {
                    if (_selectedIndex.value == 0) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.plot!,
                          style: const TextStyle(
                              color: Color.fromARGB(196, 255, 255, 255),
                              fontSize: 16),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          movie.cast!,
                          style: const TextStyle(
                              color: Color.fromARGB(196, 255, 255, 255),
                              fontSize: 16),
                        ),
                      );
                    }
                  }),
                  const SizedBox(
                    height: 8,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                    child: Text(
                      'Recommend',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Obx(() {
                    if (movieController2.isLoading2.value ||
                        webseriesContoller2.isLoading2.value) {
                      return Shimmer.fromColors(
                        baseColor: const Color.fromARGB(255, 37, 35, 35),
                        highlightColor: Colors.white,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  mainAxisExtent: 350),
                          itemCount: 10, // Demo count
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            );
                          },
                        ),
                      );
                    }

                    // Use the history list regardless of the selected index
                    final recommendList = movieController2.history.isNotEmpty
                        ? movieController2.history
                        : webseriesContoller2.history;

                    if (recommendList.isEmpty) {
                      return const Center(child: Text('No Data Found'));
                    }

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 350),
                      itemCount: recommendList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = recommendList[index];

                        return InkWell(
                          onTap: () {
                            Get.back();
                            Get.to(() => DetailScreen(
                                  title: item.title!,
                                ));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                clipBehavior: Clip.antiAlias,
                                child: item.poster != null &&
                                        item.poster!.isNotEmpty &&
                                        item.poster != 'N/A'
                                    ? Image.network(
                                        item.poster!,
                                        fit: BoxFit.cover,
                                        height: 275,
                                        width: double.infinity,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Image.asset(
                                          'assets/images/mugivara.jpeg',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/mugivara.jpeg',
                                        fit: BoxFit.cover,
                                        height: 275,
                                        width: double.infinity,
                                      ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                item.title!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
