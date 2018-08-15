import 'package:flutter/material.dart';

import './pages/auth.dart';
import './pages/main-menu.dart';
import './pages/adv-search.dart';
import './pages/results.dart';
import './model/user.dart';

void main() => runApp(MyApp()); 

class MyApp extends StatefulWidget {
  final UserMap userMap = UserMap({
    'First Name': '',
    'Last Name': '',
    'Username': '',
    'Password': '',
    'ZIP': 0,
    'Privacy': false
  });

  @override
    State<StatefulWidget> createState() {
      return MyAppState();
    }
}

class MyAppState extends State<MyApp> {
  User user;

  dynamic userGet(String key) { return user.get(key); }
  void userSet(String key, dynamic value) { setState(() { user.set(key, value); }); }

  @override
    void initState() {
      user = User(widget.userMap);
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