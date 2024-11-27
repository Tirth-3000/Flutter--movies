class Movie {
  final String? title;
  final String? poster;
  final String? runTime;
  final String? director;
  final String? cast;
  final String? plot;
  final String? language;
  final String? imdbRating;
  final String? rated;
  final String? genre;
  final String? id;
  final String? type;

  Movie(
      {this.title,
      this.poster,
      this.cast,
      this.director,
      this.genre,
      this.imdbRating,
      this.language,
      this.plot,
      this.rated,
      this.id,
      this.runTime,
      this.type});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['Title'] ?? 'No Title',
      poster: json['Poster'] ?? '',
      runTime: json['RunTime'] ?? 'Unknown', // Assuming you meant 'RunTime'
      director: json['Director'] ?? 'Unknown',
      cast: json['Actors'] ?? 'Unknown',
      //     ( as List<dynamic>?)?.map((e) => e as String).toList() ??
      //         [],
      plot: json['Plot'] ?? 'No Plot Available',
      language: json['Language'] ?? 'Unknown',
      imdbRating: json['imdbRating'] ?? 'N/A',
      type: json['Type'] ?? 'movie',
      rated: json['Rated'] ?? 'Unrated',
      genre: json['Genre'] ?? 'Not given',
      id: json['imdbID'] ?? 'not there',
      //     ( as List<dynamic>?)?.map((e) => e as String).toList() ??
      //         [],
    );
  }
}
