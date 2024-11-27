import 'package:get/get.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/services/movie_service.dart';

class MovieController extends GetxController {
  var movies = <Movie>[].obs;
  var poster = <Movie>[].obs;
  var history = <Movie>[].obs;
  var detailMovie = <Movie>[].obs;

  var isLoading = false.obs;
  var isLoading1 = false.obs;
  var isLoading2 = false.obs;
  var isLoading3 = false.obs;

  var currentIndex = 0.obs;

  void fetchMovies(
      {String? title, String? genre, String? something, String? type}) async {
    try {
      if (type == 'poster') {
        isLoading1(true);
      } else if (genre != null) {
        isLoading2(true);
      } else if (title != null) {
        isLoading3(true);
      }
      isLoading(true);
      List<Movie> movieList = [];

      if (title != null) {
        movieList = await MovieService.fetchMoviesByTitle(title);
        print(movieList);
      } else if (genre != null) {
        movieList = await MovieService.fetchMovieByGenre(genre);
        // print(movieList);
      } else if (something != null) {
        movieList = await MovieService.fetchMovieBySomething(something);
        // print(movieList);
      }

      if (type == 'poster') {
        poster.assignAll(movieList);
        // print(poster);
      } else if (genre != null) {
        history.assignAll(movieList);
      } else if (title != null) {
        detailMovie.assignAll(movieList);
      } else {
        movies.assignAll(movieList);
      }
    } finally {
      isLoading1(false);
      isLoading2(false);
      isLoading(false);
      isLoading3(false);

      // print('this vvvvv $movies  ');
    }
    update();
  }
}
