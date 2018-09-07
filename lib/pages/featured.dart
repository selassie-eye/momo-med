import 'dart:async';

import 'package:flutter/material.dart';

import '../widgets/widget-factory.dart';

import '../model/venue.dart';

class Featured extends StatefulWidget {
  final List<Venue> featured;
  Featured(this.featured);

  @override
    State<StatefulWidget> createState() {
      return _Featured();
    }
}

class _Featured extends State<Featured> {
  String query = '';
  Timer _timer;
  int _pos = 0;
  int _featuredLength = 5;

  @override
    void initState() {
      super.initState();
      _timer = Timer.periodic(Duration(seconds: 3), (timer) {
        setState(() { _pos = (_pos + 1) %  _featuredLength; });
      });
    }

  Venue _buildFeaturedCard() {
    return widget.featured[_pos];
  }

  RaisedButton _buildSearchButton(BuildContext context) {
    return RaisedButton(
      child: Text('Find a medical professional'),
      onPressed: () => Navigator.pushReplacementNamed(context, '/search'),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(children: <Widget>[
      Container(margin: EdgeInsets.all(10.0),child: _buildFeaturedCard()),
      Container(margin: EdgeInsets.all(10.0), child: Center(child: _buildSearchButton(context)))
    ],);
  }

    @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: WidgetFactory.basicAppBar('Featured'),
          body: _buildBody(context)
        );
      }

  @override
    void dispose() {
      _timer.cancel();
      _timer = null;
      super.dispose();
    }
}