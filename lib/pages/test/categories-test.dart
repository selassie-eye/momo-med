import 'dart:async';

import 'package:flutter/material.dart';

import '../../model/categories.dart';

class CategoriesTest extends StatelessWidget {
  final Function fetch;
  CategoriesTest(this.fetch);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Categories Test'),),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: RaisedButton(
            child: Center(child: Text('Tap to view categories.')),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                fetch().then((value) => Categories(value)).catchError((error) {
                  print(error);
                });
              }));
            },
          )
        )
      );
    }
}