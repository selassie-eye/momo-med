import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/main-menu.dart';
import './pages/adv-search.dart';
import './pages/results.dart';

void main() => runApp(MyApp()); 

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthPage(),
      routes: {
        '/main-menu': (BuildContext context) => MainMenu(),
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