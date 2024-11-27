import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
// import 'package:movies/models/genre.dart';
import 'package:movies/views/genre_screen.dart';

import 'package:movies/widget/main_drawer.dart';
import 'package:movies/widget/movies_widget.dart';
import 'package:movies/widget/search_widget.dart';
// import 'package:movies/widget/movies_widget.dart';
import 'package:movies/widget/sliding_image.dart';
// import 'package:movies/services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieController movieController = Get.put(MovieController());
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieController.fetchMovies(genre: 'Marvel', type: 'poster');
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
      drawer: MainDrawer(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SlidingImage(movieController: movieController),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Flexible(child: MoviesWidget())
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.red,
          iconSize: 30, // Adjust icon size
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.download_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
            if (_currentIndex == 1) {
              Get.to(
                () => const GenreScreen(
                  genre: 'Action',
                  index: 0,
                ),
              );

              setState(() {
                _currentIndex = 0;
              });
            }
          },
        ),
      ),
    );
  }
}
