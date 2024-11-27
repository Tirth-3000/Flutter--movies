import 'package:get/get.dart';
import 'package:movies/models/movie.dart';

import 'package:movies/services/web_service.dart';

class WebseriesContoller extends GetxController {
  var movies = <Movie>[].obs;
  var history = <Movie>[].obs;

  var isLoading = false.obs;
  var isLoading2 = false.obs;

  var currentIndex = 0.obs;

  void fetchWebSeries({String? somthing, String? title, String? genre}) async {
    try {
      if (genre != null) {
        isLoading2(true);
      }
      isLoading(true);
      List<Movie> movieList = [];

      if (title != null) {
        movieList = await WebService.fetchWebSeriesByTitle(title);
      } else if (genre != null) {
        movieList = await WebService.fetchWebSeriesByGenre(genre);
      } else if (somthing != null) {
        movieList = await WebService.fetchWebSeriesBySomething(somthing);
      }

      if (genre != null) {
        history.assignAll(movieList);
      } else {
        movies.assignAll(movieList);
      }
    } finally {
      isLoading2(false);

      isLoading(false);
    }
  }
}
