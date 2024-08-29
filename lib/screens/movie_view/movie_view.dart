import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/models/movie_model.dart';

class MovieView extends StatefulWidget {

final MovieModel movie;

  const MovieView({super.key,required this.movie});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(widget.movie.backdropPath))
        )
      ),
    );
  }
}