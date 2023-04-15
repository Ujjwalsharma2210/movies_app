import 'package:flutter/material.dart';

import 'get_movies.dart';

double borderRadius = 12;
double padd = 10;

class MovieDetailsPage extends StatefulWidget {
  final Movie movie;
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title),
      ),
      body: ListView(
        children: [
          ClipRRect(
            // borderRadius: BorderRadius.circular(borderRadius),
            child: Image.network(widget.movie.posterUrl),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: Text(
              "Overview",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              widget.movie.overview,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
            child: Text(
              "Released on",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              widget.movie.releaseDate,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
                color: Colors.grey,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
