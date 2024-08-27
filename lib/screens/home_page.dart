import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/models/movie_model.dart';
import 'package:tmdb_api/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Movie Hub",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer()
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
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
                      options: CarouselOptions(
                          height: size.height * 0.22, autoPlay: true),
                      items: movies.map((movie) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Container(
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade900,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:
                                            NetworkImage(movie.backdropPath))),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        bottom: 3,
                                        left: 3,
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black
                                                    .withOpacity(0.5)),
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black
                                                    .withOpacity(0.4)),
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
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )))
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Now Playing",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              FutureBuilder(
                future: ApiService().getPopularMovies(),
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
                                      child: Image.network(movie.posterPath),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      movie.title,
                                      style: TextStyle(
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )),
                          );
                        },
                      ).toList()));
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Top Rated",
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              FutureBuilder(
                future: ApiService().getTopRatedMovies(),
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
                                      ],
                                    )
                                  ],
                                )),
                          );
                        },
                      ).toList()));
                },
              )
            ],
          ),
        ));
  }
}
