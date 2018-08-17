import 'package:flutter/material.dart';

import '../widgets/title.dart';
import '../model/venue.dart';

class ResultDetails extends StatelessWidget {
  final Venue venue;
  ResultDetails(this.venue);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: TitleBar(venue.name),
        body: venue
      );
    }
}