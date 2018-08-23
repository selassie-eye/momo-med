import 'package:flutter/material.dart';

class SearchTest extends StatelessWidget {
  final Function update;
  final Function search;
  SearchTest(this.update, this.search);

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Center(child: RaisedButton(
        child: Text('Search Test'),
        onPressed: () {
          update(query: 'Hospital');
          search().then((val) => val.forEach((e) => e.log()));
        },
      ),);
    }


}