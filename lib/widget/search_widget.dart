import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movie_controller.dart';
import 'package:movies/controllers/webseries_contoller.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/views/detail_screen.dart';

class SearchWidget extends SearchDelegate<String> {
  final MovieController movieController3 = Get.put(MovieController());
  final WebseriesContoller webseriesContoller3 = Get.put(WebseriesContoller());

  List<Map<String, String>> getNames() {
    final movieTitles = movieController3.movies.map(
      (movie) {
        return {'title': movie.title!, 'image': movie.poster!};
      },
    ).toList();
    final webSeriesTitles = webseriesContoller3.movies.map(
      (webseries) {
        return {'title': webseries.title!, 'image': webseries.poster!};
      },
    ).toList();
    final movieElse = movieController3.history.map(
      (element) {
        return {'title': element.title!, 'image': element.poster!};
      },
    ).toList();
    final webSeriesElse = webseriesContoller3.history.map(
      (element) {
        return {'title': element.title!, 'image': element.poster!};
      },
    ).toList();
    return [...movieTitles, ...webSeriesTitles, ...movieElse, ...webSeriesElse];
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final names = getNames();
    final results = names
        .where((name) =>
            name['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]['title']!),
          onTap: () {
            close(context,
                results[index]['title']!); // Return the selected result
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final names = getNames();
    final suggestions = names
        .where((name) =>
            name['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white54),
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(124, 56, 52, 52),
          ),
          child: ListTile(
            title: Text(suggestions[index]['title']!),
            leading: Image.network(
              fit: BoxFit.cover,
              width: 50,
              height: double.infinity,
              suggestions[index]['image']!,
              errorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/luffy.jpg',
                fit: BoxFit.cover,
                width: 50,
                height: double.infinity,
              ),
            ),
            onTap: () {
              query = suggestions[index]['title']!;
              showResults(context);
              close(context, suggestions[index]['title']!);
              Get.to(DetailScreen(title: query));
            },
          ),
        );
      },
    );
  }
}
