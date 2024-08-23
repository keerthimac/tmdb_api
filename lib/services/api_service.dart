import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tmdb_api/models/movie_model.dart';

class ApiService {
  final apiKey = "api_key=8cf01f367c560093b7549ddc575f419b";
  final popularMovies = "https://api.themoviedb.org/3/movie/popular?";

  Future<List<MovieModel>> getPopularMovies() async {
    Response response = await get(Uri.parse('$popularMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results = data["results"];
      List<MovieModel> movies = results
          .map((movie) => MovieModel.fromJson(movie as Map<String, dynamic>))
          .toList();
      Logger().f(movies[0].posterPath);
      return movies;
    } else {
      Logger().e(response.statusCode);
      return[];
    }
  }
}
