import 'package:flutter/material.dart';

import '../controller/user-controller.dart';

enum UserField {
  firstName,
  lastName,
  username,
  password,
  zip,
  privacy,
  error
}

class UserMap {
  Map<UserField, dynamic> _map;

  UserMap() {
    this._map = {
      UserField.firstName: '',
      UserField.lastName: '',
      UserField.username: '',
      UserField.password: '',
      UserField.zip: 0,
      UserField.privacy: false,
      UserField.error: false
    };
  }

  dynamic get(UserField key) { return _map.containsKey(key) ? _map[key] : 'ERROR:Field not found.'; }
  dynamic set(UserField key, dynamic value) { return _map.containsKey(key) ? _map[key] = value : 'ERROR:Field not found.'; }
  bool containsKey(UserField key) { return _map.containsKey(key); }
  void forEach(Function f) { _map.forEach((k, v) => f(k, v)); }

  Map<UserField, dynamic> getMap() { return _map; }
  int length() { return _map.length; }
}

class User extends StatefulWidget {
  UserMap user;

  User() { user = UserMap(); }

  dynamic get(UserField key) { return user.get(key); }
  dynamic set(UserField key, dynamic value) { return user.set(key, value); }

  @override
    State<StatefulWidget> createState() {
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
    return (_user.containsKey(UserField.firstName) ? _user.get(UserField.firstName) + ' ' : '') + (_user.containsKey(UserField.lastName) ? _user.get(UserField.lastName) : '');
  }

  List<Widget> _userListBuilder() {
    List<Widget> list = [];

    list.add(_profileItem('Name', _nameBuilder()));
    _user.forEach((k, v) {
      if (k != UserField.firstName && 
          k != UserField.lastName && 
          k != UserField.error) 
      {
        list.add(_profileItem(UserController.parseField(k), v));
      }
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