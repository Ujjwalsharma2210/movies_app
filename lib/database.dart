import 'package:hive_flutter/hive_flutter.dart';

class WatchedDatabase {
  List watchList = [];
  final _mybox = Hive.box('mybox');

  void createInitialData() {
    watchList = [
      ["movies in watch list appear here", false],
    ];
  }

  void loadData() {
    watchList = _mybox.get("WATCHLIST");
  }

  void updateDatebase() {
    _mybox.put("WATCHLIST", watchList);
  }
}
