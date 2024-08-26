import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/screens/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), (){
      Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const HomePage();
      },));
    });

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.movie_filter,
                size: 80,
                color: Colors.green,
              ),
              Text(
                "Movie Hub",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),CupertinoActivityIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
