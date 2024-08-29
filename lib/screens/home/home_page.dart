import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/screens/home/widgets/caro_slider.dart';
import 'package:tmdb_api/screens/home/widgets/custom_toolbar.dart';
import 'package:tmdb_api/screens/home/widgets/slider_bar.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomToolBar(),
                const SizedBox(
                  height: 10,
                ),
                CaroSlider(size: size),
                SliderBar(future: ApiService().getNowPlayingMovies(),title: "Now Playing",),
                SliderBar(future: ApiService().getTopRatedMovies(),title: "Top Rated",),
                SliderBar(future: ApiService().getUpcommingMovies(),title: "Upcomming Movies",),

              ],
            ),
          ),
        ));
  }
}





