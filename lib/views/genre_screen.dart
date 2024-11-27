import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/controllers/webseries_contoller.dart';
import 'package:movies/views/detail_screen.dart';
import 'package:movies/widget/search_widget.dart';
import 'package:shimmer/shimmer.dart';

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key, required this.genre, required this.index});
  final String genre;
  final int index;
  @override
  State<GenreScreen> createState() {
    return _GenreScreenState();
  }
}

class _GenreScreenState extends State<GenreScreen> {
  final ScrollController _scrollController = ScrollController();
  final RxInt _selectedIndex = 0.obs;
  final RxString _selectedGenre = ''.obs;
  final MovieController movieController1 = Get.put(MovieController());
  final WebseriesContoller webseriesContoller1 = Get.put(WebseriesContoller());

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
    _selectedGenre.value = widget.genre;
    _selectedIndex.value = widget.index;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMovies(_selectedGenre.value);
    });
    _scrollToSelectedGenre();
  }

  void getMovies(String genre) {
    movieController1.fetchMovies(genre: genre);
  }

  void getWebSeries(String genre) {
    webseriesContoller1.fetchWebSeries(genre: genre);
  }

  void _scrollToSelectedGenre() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        int selectedIndex = genre.indexOf(_selectedGenre.value);
        const double itemWidth = 100.0;
        const double itemPadding = 8.0;

        double scrollPosition =
            (selectedIndex * (itemWidth + itemPadding)) + 90;

        _scrollController.jumpTo(scrollPosition);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchWidget());
            },
            icon: const Icon(
              Icons.search,
              color: Color.fromARGB(255, 114, 50, 45),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                        renderBorder:
                            false, // Disable the border of ToggleButtons
                        onPressed: (index) {
                          _selectedIndex.value = index;
                          if (_selectedIndex.value == 0) {
                            getMovies(widget.genre);
                          } else {
                            getWebSeries(widget.genre);
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
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Obx(() {
                      print("object =>");
                      return Row(
                        children: genre.map(
                          (e) {
                            bool isSelected = _selectedGenre.value == e;
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.04,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.red
                                      : Colors.transparent,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.red,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    _selectedGenre.value = e;
                                    if (_selectedIndex.value == 0) {
                                      getMovies(e);
                                    } else {
                                      getWebSeries(e);
                                    }
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
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Obx(
              () {
                if (movieController1.isLoading2.value ||
                    webseriesContoller1.isLoading2.value) {
                  const demoitem = 20;

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
                      itemCount: demoitem,
                      itemBuilder: (context, index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        );
                      },
                    ),
                  );
                }
                final itemList = _selectedIndex == 0.obs
                    ? movieController1.history
                    : webseriesContoller1.history;

                if (itemList.isEmpty) {
                  return const Center(child: Text('No Data found'));
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 350),
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    final item = itemList[index];

                    return InkWell(
                      onTap: () {
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
