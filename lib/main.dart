import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

import './pages/search-page.dart';
import './pages/featured.dart';

import './controller/google-api.dart';

import './model/venue.dart';

void main() {
  MapView.setApiKey(GoogleAPI.googleAPIKey);
  runApp(MyApp()); 
}

class MyApp extends StatefulWidget {

  @override
    State<StatefulWidget> createState() {
      return MyAppState();
    }
}

class MyAppState extends State<MyApp> {
  GoogleAPI places;
  List<Venue> featured = [];

  @override
    void initState() {
      super.initState();
      places = GoogleAPI();
      places.updateQuery(keyword: 'hospital');
      places.searchQuery().then((val) => featured = val);
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(places.updateQueryWithUserLoc, places.searchQuery),
      routes: {
        '/search': (BuildContext context) => SearchPage(places.updateQueryWithUserLoc, places.searchQuery),
        '/featured': (BuildContext context) => featured.isNotEmpty ? Featured(featured) : SearchPage(places.updateQueryWithUserLoc, places.searchQuery),
      },
      onUnknownRoute: (RouteSettings settings) { return MaterialPageRoute(builder: (BuildContext context) => SearchPage(places.updateQueryWithUserLoc, places.searchQuery)); }
    );
  }
}