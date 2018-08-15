import 'package:flutter/material.dart';

import '../model/user.dart';

class UserController extends StatelessWidget {
  User user;
  UserController() { user = User(); }

  static String parseField(UserField field) {
    switch(field) {
      case UserField.firstName: return 'First Name';
      case UserField.lastName: return 'Last Name';
      case UserField.username: return 'Username';
      case UserField.password: return 'Password';
      case UserField.zip: return 'ZIP';
      case UserField.privacy: return 'Privacy';
      case UserField.error: return 'Error';
      default: return '';
    }
  }

  static UserField parseString(String s) {
    switch(s) {
      case 'First Name': return UserField.firstName;
      case 'Last Name': return UserField.lastName;
      case  'Username': return UserField.username;
      case  'Password': return UserField.password;
      case 'ZIP': return UserField.privacy;
      case 'Error': return UserField.error;
      default: return UserField.error;
    }
  }

  dynamic get(String key) { return user.get(parseString(key)); }
  void set(String key, dynamic value) { user.set(parseString(key), value); }

  @override
    Widget build(BuildContext context) {
      return user;
    }
}