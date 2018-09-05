import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:map_view/map_view.dart';

import 'package:http/http.dart' as http;

import './pages/auth.dart';
import './pages/main-menu.dart';
import './pages/adv-search.dart';
import './pages/results.dart';
import './pages/search-page.dart';
import './pages/featured.dart';
import './pages/signin.dart';

import './pages/test/categories-test.dart';
import './pages/test/test-page.dart';
import './pages/test/search-test.dart';

import './controller/user-controller.dart';
import './controller/google-api.dart';

import './model/venue.dart';


void main() {
  MapView.setApiKey(GoogleAPI.googleAPIKey);

  //  Debug Options
  //  ---------------------------------------------
  //  debugPaintSizeEnabled = true;
  //  debugPaintBaselinesEnabled = true;
  //  debugPaintPointersEnabled = true;
  //  ---------------------------------------------

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
  UserController user;
  List<Venue> featured = [];

  @override
    void initState() {
      super.initState();
      user = UserController();
      places = GoogleAPI();
      places.updateQuery(keyword: 'hospital');
      places.searchQuery().then((val) => featured = val);
    }

  dynamic userGet(String key) { return user.get(key); }
  void userSet(String key, dynamic value) { setState(() { user.set(key, value); }); }

  Future<Map<String, dynamic>> getCategories() async {
    final String _url = 'https://us-central1-momo-medical.cloudfunctions.net/getCategories';
    Map<String, dynamic> ret = {};
    await http.get(_url).then((http.Response res) {
      if (res.statusCode == 200) {
        ret = json.decode(res.body);
      }
    });

    return Future.value(ret);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchPage(places.updateQueryWithUserLoc, places.searchQuery),
      routes: {
        '/main-menu': (BuildContext context) => MainMenu(user),
        '/adv-search': (BuildContext context) => AdvSearch(),
        '/auth': (BuildContext context) => AuthPage(userGet, userSet),
        '/search': (BuildContext context) => SearchPage(places.updateQueryWithUserLoc, places.searchQuery),
        '/categories-test': (BuildContext context) => CategoriesTest(getCategories),
        '/search-test': (BuildContext context) => SearchTest(places.updateQuery, places.searchQuery),
        '/featured': (BuildContext context) => featured.isNotEmpty ? Featured(featured) : SearchPage(places.updateQueryWithUserLoc, places.searchQuery),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') return null;
        if (pathElements[1] == 'services') {
          // _fetchResults(pathElements[2]).then((List<Venue> e) => print(e.toString()));
          return MaterialPageRoute(builder: (BuildContext context) => Results(pathElements[2], places.updateQuery, places.searchQuery));
        }
      },
      onUnknownRoute: (RouteSettings settings) { return MaterialPageRoute(builder: (BuildContext context) => MainMenu()); }
    );
  }
}