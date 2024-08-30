import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/models/movie_model.dart';

class MovieView extends StatefulWidget {
  final MovieModel movie;

  const MovieView({super.key, required this.movie});

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: size.width,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    //colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
                      image: NetworkImage(widget.movie.backdropPath),
                      fit: BoxFit.cover)),
              child: Stack(children: [
                Positioned(
                    top: 5,
                    left: 5,
                    child: BackButton(
                      color: Colors.white,
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              Colors.black.withOpacity(0.5))),
                    ))
              ])),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.movie.title,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
