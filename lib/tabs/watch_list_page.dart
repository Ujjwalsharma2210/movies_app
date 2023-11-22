import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../database.dart';
import '../utils.dart';

double borderRadius = 12;

WatchedDatabase db = WatchedDatabase();

class WatchListPage extends StatefulWidget {
  const WatchListPage({super.key});

  @override
  State<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends State<WatchListPage> {
  final _myBox = Hive.box('mybox');

  @override
  void initState() {
    if (_myBox.get('WATCHLIST') == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.watchList[index][1] = !db.watchList[index][1];
    });
    db.updateDatebase();
  }

  void deleteMovie(int index) {
    setState(() {
      db.watchList.removeAt(index);
    });
    db.updateDatebase();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: db.watchList.length,
      itemBuilder: (context, index) {
        return WatchListTile(
          movieName: db.watchList[index][0],
          watched: db.watchList[index][1],
          onChanged: (value) => checkBoxChanged(value, index),
          deleteMovie: (context) => deleteMovie(index),
        );
      },
    );
  }
}
