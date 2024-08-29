import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/models/movie_model.dart';
import 'package:tmdb_api/screens/movie_view/movie_view.dart';
import 'package:tmdb_api/services/api_service.dart';

class CaroSlider extends StatelessWidget {
  const CaroSlider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CupertinoActivityIndicator();
          }
          if (snapshot.hasError) {
            // Handle the error case
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle the case where there is no data
            return const Center(
                child: Text('No movies available',
                    style: TextStyle(color: Colors.white)));
          }
          List<MovieModel> movies = snapshot.data!;
          return CarouselSlider(
            options:
                CarouselOptions(height: size.height * 0.22, autoPlay: true),
            items: movies.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GestureDetector(
                      onTap: () {
                        //Logger().f(movie.title);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieView(movie: movie,),
                            ));
                      },
                      child: Container(
                        width: size.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(movie.backdropPath))),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: 3,
                                left: 3,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black.withOpacity(0.5)),
                                    child: Text(
                                      movie.title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: 3,
                                right: 3,
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black.withOpacity(0.4)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow.shade600,
                                          size: 15,
                                        ),
                                        Text(
                                          movie.voteAverage
                                              .toString()
                                              .substring(0, 3),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          );
        });
  }
}
