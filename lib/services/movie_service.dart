import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/models/movie.dart';

class MovieService {
  static const String apiKey = '7567951c';
  static const String apiUrl = 'https://www.omdbapi.com/';

  static Future<List<Movie>> fetchMoviesByTitle(String title) async {
    return await _fetchMovies(query: title);
  }

  static Future<List<Movie>> fetchMovieByGenre(String genre) async {
    return await _fetchMovies(query: genre);
  }

  static Future<List<Movie>> fetchMovieBySomething(String something) async {
    return await _fetchMoviess(query: something);
  }

  static Future<List<Movie>> _fetchMovies({required String query}) async {
    try {
      // Send the search request
      final response =
          await http.get(Uri.parse('$apiUrl?s=$query&apikey=$apiKey'));

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = json.decode(response.body)['Search'];
        List<Movie> movies = [];

        // Fetch detailed information for each movie
        for (var movieJson in moviesJson) {
          final detailedResponse = await http.get(
              Uri.parse('$apiUrl?i=${movieJson['imdbID']}&apikey=$apiKey'));
          if (detailedResponse.statusCode == 200) {
            movies.add(Movie.fromJson(json.decode(detailedResponse.body)));
          }
        }

        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching movies: $e');
    }
  }

  static Future<List<Movie>> _fetchMoviess({required String query}) async {
    try {
      // Send the search request
      final response = await http
          .get(Uri.parse('$apiUrl?s=Action&apikey=$apiKey&type=movie&y=2023'));

      if (response.statusCode == 200) {
        final List<dynamic> moviesJson = json.decode(response.body)['Search'];
        List<Movie> movies = [];

        // Fetch detailed information for each movie
        for (var movieJson in moviesJson) {
          final detailedResponse = await http.get(
              Uri.parse('$apiUrl?i=${movieJson['imdbID']}&apikey=$apiKey'));
          if (detailedResponse.statusCode == 200) {
            movies.add(Movie.fromJson(json.decode(detailedResponse.body)));
          }
        }

        return movies;
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      throw Exception('An error occurred while fetching movies: $e');
    }
  }
}
