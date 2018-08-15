import 'package:flutter/material.dart';

import '../../controller/user-controller.dart';

class Profile extends StatelessWidget {
  final UserController user;
  Profile(this.user);

  @override
    Widget build(BuildContext context) {
      return user;
    }
}