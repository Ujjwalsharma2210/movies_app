import 'package:flutter/material.dart';
import 'package:intern/get_movies.dart';
import 'package:intern/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late Future<dynamic> arrayMovies;
  List<Movie> listMovies = <Movie>[];

  Widget getMoviesList() {
    List<Widget> list = [];
    for (var movie in listMovies) {
      list.add(MovieListTile(context, movie));
    }
    return Column(
      children: list,
    );
  }

  void getMovies() async {
    listMovies = await fetchTrendingMovies();
    // }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Text(
            "Latest and Trending",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
              fontSize: 30,
            ),
          ),
        ),
        getMoviesList()
      ],
    );
  }
}
