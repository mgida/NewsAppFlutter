import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/db/moor_database.dart';
import 'package:news_app/rest_api/news_service.dart';
import 'package:news_app/ui/screens/home_page.dart';
import 'file:///E:/nanodegree/Flutter/course_projects_new/news_app/lib/ui/screens/favourite_page.dart';
import 'file:///E:/nanodegree/Flutter/course_projects_new/news_app/lib/ui/screens/search_page.dart';
import 'package:provider/provider.dart';

class AfterSplashPage extends StatefulWidget {
  @override
  _AfterSplashPageState createState() => _AfterSplashPageState();
}

class _AfterSplashPageState extends State<AfterSplashPage> {
  int _selectedIndex = 0;

  List<Widget> _bottomBarOptions = [
    HomePage(),
    FavouritePage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final newsCycleFont = GoogleFonts.newsCycle(fontWeight: FontWeight.w700);

    return MultiProvider(
      providers: [
        Provider(
          create: (_) => NewsService.create(),
          dispose: (context, NewsService service) => service.client.dispose(),
        ),
        Provider(create: (_) => AppDatabase().articleDao),
      ],
      child: MaterialApp(
        title: 'News',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                label: 'Breaking news',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Saved News'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          body: _bottomBarOptions.elementAt(_selectedIndex),
        ),
        theme: ThemeData(
          primaryTextTheme: TextTheme(
            headline6: newsCycleFont,
          ),
          textTheme: TextTheme(
            subtitle1: newsCycleFont.apply(color: Colors.black),
            headline6: newsCycleFont.apply(color: Colors.black),
            bodyText2: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
