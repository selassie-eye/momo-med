import 'package:flutter/material.dart';

import '../model/venue.dart';

class FeaturedGallery extends StatefulWidget {
  List<Venue> venues;
  FeaturedGallery(this.venues);

  @override
    State<StatefulWidget> createState() {
      // TODO: implement createState
      return _FeaturedGalleryState();
    }
}

class _FeaturedGalleryState extends State<FeaturedGallery> {
  ScrollController scroller;

  @override
    void initState() {
      super.initState();
      scroller = ScrollController(

      );
    }

  Widget _buildScrollableCard() {
    return Scrollable(
      physics: ScrollPhysics(
        
      ),
    );
  }

  @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return null;
    }
}