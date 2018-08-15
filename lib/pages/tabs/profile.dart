import 'package:flutter/material.dart';

import '../../model/user.dart';

class Profile extends StatelessWidget {
  final User user;
  Profile(this.user);

  @override
    Widget build(BuildContext context) {
      return user;
    }
}