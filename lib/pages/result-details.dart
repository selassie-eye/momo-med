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
        body: venue
      );
    }
}