import 'dart:async';

import 'package:flutter/material.dart';

import './result-details.dart';

import '../widgets/title.dart';
import '../model/venue.dart';

class Results extends StatefulWidget {
  final String pageTitle;
  final Function update;
  final Function fetch;
  Results(this.pageTitle, this.update, this.fetch);

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _ResultsState();
    }
}

class _ResultsState extends State<Results> {
  List<Venue> venues;

  @override
    void initState() {
      super.initState();
      venues = [];
    }

  FutureBuilder _buildResultsFuture() {
    widget.update(query: widget.pageTitle);
    return FutureBuilder(
      future: widget.fetch(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none: return Center(child: Text('Nothing to see!'),);
          case ConnectionState.waiting: return Center(child: Text('Loading...'),);
          case ConnectionState.done:
            venues = snapshot.data;
            return _buildResultsList();
          default: return Center(child: Text('Nothing to see!'),);
        }
      }
    );
  }

  Column _buildResultTile(BuildContext context, int index) {
    return Column(children: <Widget>[
      ListTile(
        leading: Icon(Icons.healing),
        title: venues[index].name != '' ? Text(venues[index].name) : Text('null'),
        onTap: () => Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) => ResultDetails(venues[index]))),
      ),
      Divider()
    ],);
  }

  Widget _buildResultsList() {
    return venues.length > 0 ? ListView.builder(
      itemBuilder: _buildResultTile,
      itemCount: venues.length,
    ) : Center(child: Text('No results for ${widget.pageTitle}'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: TitleBar(widget.pageTitle).build(context),
      body: _buildResultsFuture()
    ),
    onWillPop: () {
      Navigator.pop(context);
      return Future.value();
    },);
  }
}