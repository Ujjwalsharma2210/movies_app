import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_magic/get_movies.dart';
import 'package:movie_magic/tabs/home_page.dart';
import 'package:movie_magic/tabs/watch_list_page.dart';
import 'package:movie_magic/utils.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  //initialise hive
  WidgetsFlutterBinding.ensureInitialized();
  final dbDir = path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(dbDir.toString());

  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final tabs = [const HomePage(), const WatchListPage()];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
          child: Image.asset('assets/icon/film-reel.png'),
        ),
        title: const Text("Movie Magic"),
        // elevation: 5,
        actions: [
          IconButton(
            onPressed: () async {
              List<Movie> list = await fetchTrendingMovies();

              showSearch(
                  context: context, delegate: CustomSearchDelegate(list));
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: tabs[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        elevation: 5,
        selectedIndex: currentPageIndex,
        height: 70,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.home_outlined,
              // color: white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.library_books_outlined,
              // color: white,
            ),
            label: 'Watch list',
          ),
        ],
      ),
    );
  }
}
