import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/title.dart';

class Results extends StatelessWidget {
  final String query;
  Results(this.query);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: TitleBar(query).build(context),
      body: Center(child: Text('Searching...')) 
    ),
    onWillPop: () {
      Navigator.pop(context);
      return Future.value();
    },);
  }
}