import 'package:flutter/material.dart';

import '../widgets/widget-factory.dart';
import '../model/venue.dart';

class ResultDetails extends StatelessWidget {
  final Venue venue;
  ResultDetails(this.venue);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: WidgetFactory.basicAppBar(venue.name),
        body: Stack(children: <Widget>[_snackBarShower(), venue])
      );
    }
}

class _snackBarShower extends StatelessWidget {
  @override
    Widget build(BuildContext context) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tap the map to get directions!'),));
      return null;
    }
}