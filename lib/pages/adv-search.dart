import 'dart:async';

import '../widgets/title.dart';

import 'package:flutter/material.dart';


class AdvSearch extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      return WillPopScope(
        child: Scaffold(
          appBar: TitleBar('Advanced Search').build(context),
          body: Center(child: Text('Advanced Searching!')),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return Future.value();
        },
      );
    }
}