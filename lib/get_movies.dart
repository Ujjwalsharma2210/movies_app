import 'dart:convert';
import 'package:http/http.dart' as http;

class Movie {
  final String title;
  final String overview;
  final String posterUrl;
  final String releaseDate;

  Movie({
    required this.title,
    required this.overview,
    required this.posterUrl,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      overview: json['overview'],
      posterUrl: 'https://image.tmdb.org/t/p/w500' + json['poster_path'],
      releaseDate: json['release_date'],
    );
  }
}

Future<List<Movie>> fetchTrendingMovies() async {
  final apiKey = '747c1f2bfcff6071f4865578e3fdaded';
  final url =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey&append_to_response=credits';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonBody = jsonDecode(response.body);
    final List<dynamic> moviesJson = jsonBody['results'];
    final List<Movie> movies =
        moviesJson.map((json) => Movie.fromJson(json)).toList();
    return movies;
  } else {
    throw Exception('Failed to fetch trending movies');
  }
}
