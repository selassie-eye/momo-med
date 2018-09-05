import 'package:flutter/material.dart';

import 'package:map_view/map_view.dart';
import 'package:url_launcher/url_launcher.dart';

class Venue extends StatelessWidget {
  final String id;
  final String place_id;
  final Map<String, dynamic> plus_code;
  final String name;
  final Map<String, dynamic> location;
  final String vicinity;
  final String reference;
  final String iconURL;
  final StaticMapProvider mapProvider;
  Map<String, double> userLoc;
  Location loc2;
  MapView _mapView;
  Uri _staticMapURI;

  Venue(this.mapProvider, {this.id, this.place_id, this.plus_code, this.name, this.location, this.vicinity, this.reference, this.iconURL, this.userLoc}) {
    _mapView = new MapView();
    loc2 = new Location(
      this.location.containsKey('lat') ? this.location['lat'] : 1.0,
      this.location.containsKey('lng') ? this.location['lng'] : 1.0
    );
        List<Marker> markers = <Marker>[
          new Marker(
            this.id,
            this.name,
            this.loc2.latitude,
            this.loc2.longitude
          )
        ];
    _staticMapURI = mapProvider.getStaticUriWithMarkers(markers, center: loc2, width: 800, height: 400, maptype: StaticMapViewType.roadmap);

  } factory Venue.fromJSON(Map<String, double> userLoc, StaticMapProvider mapProvider, Map<String, dynamic> json) {
    return Venue(
      mapProvider,
      id: json.containsKey('id') ? json['id'] : '',
      place_id: json.containsKey('place_id') ? json['place_id'] : '',
      plus_code: json.containsKey('plus_code') ? json['plus_code'] : '',
      name: json.containsKey('name') ? json['name'] : '',
      location: json.containsKey('geometry') ? (json['geometry'].containsKey('location') ? json['geometry']['location'] : {}) : {},
      vicinity: json.containsKey('vicinity') ? json['vicinity'] : '',
      reference: json.containsKey('reference') ? json['reference'] : '',
      iconURL: json.containsKey('icon') ? json['icon'] : {},
      userLoc: userLoc,
    );
  }

  void log(){
    print('id: $id');
    print('name: $name');
  }

  Text _printAddress() {
    return Text(vicinity);
  }

  void _openMapApp() async {
    String dest = vicinity.replaceAll(' ', '+').replaceAll(',', '%2C');
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&destination=$dest';
    String appleUrl = 'https://maps.apple.com/?daddr=$dest';
    if (await canLaunch(googleUrl)) {
      print('launching com googleUrl');
      await launch(googleUrl);
    } else if (await canLaunch(appleUrl)) {
      print('launching apple url');
      await launch(appleUrl);
    } else {
      throw 'Could not launch url';
    }
  }

  Widget _buildVenueCard() {
    log();
    return Card(child: Column(children: <Widget>[
      Stack(children: <Widget>[
        Container(width: 800.0, height: 200.0, child: Center(child: Text('Loading map...'))),
        GestureDetector(
          onTap: _openMapApp,
          child: Image.network(_staticMapURI.toString()))
      ]),
      Container(margin: EdgeInsets.all(10.0), child: Text(name)),
      Container(margin: EdgeInsets.all(10.0), child: _printAddress(), alignment: Alignment.bottomCenter),
      Divider()
    ],),);
  }

  @override
    Widget build(BuildContext context) {
      return Center(child: _buildVenueCard());
    }
}