class MovieModel {
  String title;
  String overview;
  String backdropPath;
  String posterPath;

  MovieModel(
      {required this.title,
      required this.posterPath,
      required this.backdropPath,
      required this.overview});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        title: json['title'],
        posterPath: json['poster_path'],
        backdropPath: json['backdrop_path'],
        overview: json['overview']);
  }
}
