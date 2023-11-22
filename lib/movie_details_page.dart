import 'package:flutter/material.dart';
import 'package:movie_magic/tabs/watch_list_page.dart';
import 'package:movie_magic/utils.dart';

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
          Stack(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Colors.transparent,
                      Colors.white,
                    ],
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Image.network(
                  widget.movie.backdropPath,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.network(widget.movie.posterUrl),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              "Overview",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.movie.overview,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Released on",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.movie.releaseDate,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 60,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       bool add = true;
          //       for (int i = 0; i < db.watchList.length; i++) {
          //         if (widget.movie.title == db.watchList[i][0]) {
          //           add = false;
          //           break;
          //         }
          //       }
          //       if (add) {
          //         db.watchList.add([widget.movie.title, false]);
          //         db.updateDatebase();
          //         showToast(context, "Movie added to watchlist", "Success");
          //       } else {
          //         showToast(context, "Movie already in watchlist", "alert");
          //       }
          //     },
          //     child: const Padding(
          //       padding: EdgeInsets.all(8.0),
          //       child: Text(
          //         "+ Add to watch later",
          //         style: TextStyle(
          //           fontSize: 16,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _addToWatchlistClicked(),
        icon: Icon(Icons.add),
        label: Text("Add to Watchlist"),
        elevation: 10,
      ),
    );
  }

  _addToWatchlistClicked() {
    bool add = true;
    for (int i = 0; i < db.watchList.length; i++) {
      if (widget.movie.title == db.watchList[i][0]) {
        add = false;
        break;
      }
    }
    if (add) {
      db.watchList.add([widget.movie.title, false]);
      db.updateDatebase();
      showToast(context, "Movie added to watchlist", "Success");
    } else {
      showToast(context, "Movie already in watchlist", "alert");
    }
  }
}
