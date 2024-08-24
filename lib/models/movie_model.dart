class MovieModel {
  String title;
  String overview;
  String backdropPath;
  String posterPath;
  double voteAverage;

  MovieModel(
      {required this.title,
      required this.posterPath,
      required this.backdropPath,
      required this.overview,
      required this.voteAverage});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        title: json['title'],
        posterPath: json['poster_path'],
        backdropPath: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
        overview: 'https://image.tmdb.org/t/p/w500${json['overview']}',
        voteAverage: json['vote_average']);
  }
}
