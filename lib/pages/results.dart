import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import './result-details.dart';

import '../widgets/title.dart';
import '../model/venue.dart';

class Results extends StatelessWidget {
  final String pageTitle;
  final Function fetch;
  Results(this.pageTitle, this.fetch);

  List<Venue> venues;

  FutureBuilder _buildResultsFuture() {
    return FutureBuilder(
      future: fetch(pageTitle),
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

  ListView _buildResultsList() {
    return venues.length > 0 ? ListView.builder(
      itemBuilder: _buildResultTile,
      itemCount: venues.length,
    ) : Center(child: Text('No results for $pageTitle'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: TitleBar(pageTitle).build(context),
      body: _buildResultsFuture()
    ),
    onWillPop: () {
      Navigator.pop(context);
      return Future.value();
    },);
  }
}