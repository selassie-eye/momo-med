import 'package:flutter/material.dart';

class UserMap {
  Map<String, dynamic> _map = {};
  UserMap([this._map]);

  dynamic get(String key) { return _map.containsKey(key) ? _map[key] : 'ERROR:Field not found.'; }
  dynamic set(String key, dynamic value) { return _map.containsKey(key) ? _map[key] = value : 'ERROR:Field not found.'; }
  bool containsKey(String key) { return _map.containsKey(key); }
  void forEach(Function f) { _map.forEach((k, v) => f(k, v)); }

  Map<String, dynamic> getMap() { return _map; }
  int length() { return _map.length; }
}

class User extends StatefulWidget {
  UserMap user;
  User(this.user);

  dynamic get(String key) { return user.get(key); }
  dynamic set(String key, dynamic value) { return user.set(key, value); }

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return UserState();
    }
}

class UserState extends State<User> {
  UserMap _user;

  @override
    void initState() { 
      super.initState(); 
      _user = widget.user;
    }
  
  String _nameBuilder() {
    return (_user.containsKey('First Name') ? _user.get('First Name') + ' ' : '') + (_user.containsKey('Last Name') ? _user.get('Last Name') : '');
  }

  List<Widget> _userListBuilder() {
    List<Widget> list = [];

    list.add(_profileItem('Name', _nameBuilder()));
    _user.forEach((String k, v) {
      if (k != 'First Name' && k != 'Last Name') list.add(_profileItem(k, v));
    });

    return list;
  }

  Widget _profileItem(String key, dynamic value) {
    return Container(margin: EdgeInsets.all(10.0), child: Column(
      children: <Widget>[
        ListTile(title: Text('$key: $value')),
        Divider()
      ],),);
  }

Widget _userProfile() { 
    return ListView(
        padding: EdgeInsets.all(10.0), 
        children: _userListBuilder()
    );
  }

  @override
    Widget build(BuildContext context) {

      return _userProfile();
    }
}