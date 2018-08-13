import 'package:flutter/material.dart';

import '../results.dart';

class Services extends StatelessWidget {
  final List<String> categories;
  Services(this.categories);

    Widget _buildMenuItem(BuildContext context, int index) {
      return FlatButton(
        onPressed: () => Navigator.pushNamed(context, '/services/${categories[index]}'),
        child: Text(categories[index]),
      );
    }

  Widget _buildMenuList() {
    return Expanded(
      child: categories.length > 0 ? ListView.builder(
        itemBuilder: _buildMenuItem,
        itemCount: categories.length,
      ) : Text('Nothing to search.'),
    );
  }

  Widget _buildServices() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text('Select a Service'),
        ),
        _buildMenuList()
      ]
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return _buildServices();
    }
}