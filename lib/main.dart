import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;

import './pages/auth.dart';
import './pages/main-menu.dart';
import './pages/adv-search.dart';
import './pages/results.dart';
import './pages/search-page.dart';

import './pages/test/categories-test.dart';
import './pages/test/test-page.dart';
import './pages/test/search-test.dart';

import './controller/user-controller.dart';
import './controller/search-controller.dart';

import './model/venue.dart';

void main() {
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
  SearchController search;
  UserController user;

  dynamic userGet(String key) { return user.get(key); }
  void userSet(String key, dynamic value) { setState(() { user.set(key, value); }); }
  
  Future<List<Venue>> _fetchResults(String query) async {
    final String _ll = '29.6478,-82.33784'; //  TEMPORARY TEST VALUE
    final String _baseURL = 'https://us-central1-momo-medical.cloudfunctions.net/searchRequest?ll=$_ll&search=$query';
    
    List<Venue> ret = [];
    await http.get(_baseURL).then((http.Response res) {
      if (res.statusCode == 200) {
        List<dynamic> parsedBody = json.decode(res.body);
        parsedBody.forEach((dynamic e) {
          ret.add(Venue.fromJSON(e));
        });
      }
    });

    return Future.value(ret);
  }

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
    void initState() {
      super.initState();
      user = UserController();
      search = SearchController();
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestPage(),
      routes: {
        '/main-menu': (BuildContext context) => MainMenu(user),
        '/adv-search': (BuildContext context) => AdvSearch(),
        '/auth': (BuildContext context) => AuthPage(userGet, userSet),
        '/search': (BuildContext context) => SearchPage(),
        '/categories-test': (BuildContext context) => CategoriesTest(getCategories),
        '/search-test': (BuildContext context) => SearchTest(search.updateQuery, search.searchQuery)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') return null;
        if (pathElements[1] == 'services') {
          // _fetchResults(pathElements[2]).then((List<Venue> e) => print(e.toString()));
          return MaterialPageRoute(builder: (BuildContext context) => Results(pathElements[2], search.updateQuery, search.searchQuery));
        }
      },
      onUnknownRoute: (RouteSettings settings) { return MaterialPageRoute(builder: (BuildContext context) => MainMenu()); }
    );
  }
}