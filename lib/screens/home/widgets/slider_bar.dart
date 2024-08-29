import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/models/movie_model.dart';
import 'package:tmdb_api/screens/movie_view/movie_view.dart';
import 'package:tmdb_api/services/api_service.dart';

class SliderBar extends StatelessWidget {
  const SliderBar({
    super.key,
    required this.title, required this.future,
  });

  final String title;
  final Future future;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const Divider(),
        FutureBuilder(
          future: future,
          builder: (BuildContext context, snapshot) {
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

            return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: movies.take(5).map(
                  (movie) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => MovieView(movie: movie),)),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            width: 250,
                            height: 110,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(12)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    movie.posterPath,
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 160,
                                      child: Text(
                                        movie.title,
                                        style: TextStyle(
                                            color: Colors.grey.shade300,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.green.withOpacity(0.4)),
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
                                        ))
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  },
                ).toList()));
          },
        ),
      ],
    );
  }
}
