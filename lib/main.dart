import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import './pages/auth.dart';
import './pages/main-menu.dart';
import './pages/adv-search.dart';
import './pages/results.dart';

import './controller/user-controller.dart';

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
  UserController user;

  dynamic userGet(String key) { return user.get(key); }
  void userSet(String key, dynamic value) { setState(() { user.set(key, value); }); }

  @override
    void initState() {
      user = UserController();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(userGet, userSet),
      routes: {
        '/main-menu': (BuildContext context) => MainMenu(user),
        '/adv-search': (BuildContext context) => AdvSearch(),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') return null;
        if (pathElements[1] == 'services') return MaterialPageRoute(builder: (BuildContext context) => Results(pathElements[2]));
      },
      onUnknownRoute: (RouteSettings settings) { return MaterialPageRoute(builder: (BuildContext context) => MainMenu()); }
    );
  }
}