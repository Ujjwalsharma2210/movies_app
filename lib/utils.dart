import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_magic/tabs/watch_list_page.dart';

import 'get_movies.dart';
import 'movie_details_page.dart';

Color lightGrey = Colors.grey.shade300;
Color textColor = Colors.grey.shade500;
Color primaryColor = Colors.deepPurple;

double borderRadius = 16;

Widget MovieListTile(BuildContext context, Movie movie) {
  // String adultText = movie.adult ? "ADULT" : "";

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieDetailsPage(movie: movie)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              offset: Offset(0, 10),
              blurRadius: 10,
              spreadRadius: 1,
              blurStyle: BlurStyle.normal,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: SizedBox(
                  //     width: MediaQuery.of(context).size.width * 0.8,
                  //     child: Center(
                  //       child: Text(
                  //         movie.title,
                  //         style: TextStyle(
                  //           color: Colors.grey.shade800,
                  //           fontSize: 28,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      child: Image.network(
                        movie.posterUrl,
                        height: 400,
                      ),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Released : " + movie.releaseDate,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      movie.overview,
                      maxLines: 3,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        bool add = true;
                        for (int i = 0; i < db.watchList.length; i++) {
                          if (movie.title == db.watchList[i][0]) {
                            add = false;
                            break;
                          }
                        }
                        if (add) {
                          db.watchList.add([movie.title, false]);
                          db.updateDatebase();
                          showToast(
                              context, "Movie added to watchlist", "Success");
                        } else {
                          showToast(
                              context, "Movie already in watchlist", "alert");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              "Add to Watchlist",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

void showToast(BuildContext context, String message, String type) {
  Color bgColor;
  if (type == "success") {
    bgColor = Colors.green;
  } else if (type == "error") {
    bgColor = Colors.red;
  } else if (type == "alert") {
    bgColor = Colors.orange;
  } else {
    bgColor = Colors.deepPurple;
  }

  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(message),
      duration: const Duration(milliseconds: 800),
    ),
  );
}

class WatchListTile extends StatelessWidget {
  final String movieName;
  final bool watched;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteMovie;
  WatchListTile(
      {super.key,
      required this.movieName,
      required this.watched,
      required this.onChanged,
      required this.deleteMovie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteMovie,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(0, 10),
                blurRadius: 10,
                spreadRadius: 1,
                blurStyle: BlurStyle.normal,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              children: [
                Checkbox(value: watched, onChanged: onChanged),
                Container(
                  width: 220,
                  child: Text(
                    movieName,
                    style: TextStyle(
                      fontSize: 16,
                      decoration: watched
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [];

  List<Movie> listMovies = [];

  CustomSearchDelegate(List<Movie> list) {
    listMovies = list;
    for (var movie in list) {
      searchTerms.add(movie.title);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            Movie mov = listMovies[0];
            for (int i = 0; i < listMovies.length; i++) {
              if (listMovies[i].title == result) {
                mov = listMovies[i];
                break;
              }
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(movie: mov)));
          },
          child: ListTile(
            title: Text(result),
          ),
        );
      },
    );
  }
}
