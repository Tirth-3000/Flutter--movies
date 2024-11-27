import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies/models/movie.dart';

class WebService {
  static const String apiKey = '7567951c';
  static const String apiUrl = 'https://www.omdbapi.com/';

  static Future<List<Movie>> fetchWebSeriesByTitle(String title) async {
    return await _fetchWebseries(query: title);
  }

  static Future<List<Movie>> fetchWebSeriesByGenre(String genre) async {
    return await _fetchWebseries(query: genre);
  }

  static Future<List<Movie>> fetchWebSeriesBySomething(String something) async {
    return await _fetchWebseriess(query: something);
  }

  static Future<List<Movie>> _fetchWebseries({required String query}) async {
    try {
      // Send the search request
      final response = await http
          .get(Uri.parse('$apiUrl?s=$query&apikey=$apiKey&type=series'));

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

  static Future<List<Movie>> _fetchWebseriess({required String query}) async {
    try {
      // Send the search request
      final response = await http
          .get(Uri.parse('$apiUrl?s=Comedy&apikey=$apiKey&type=series&y=2023'));

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
