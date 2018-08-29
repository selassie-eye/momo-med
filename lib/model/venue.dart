import 'package:flutter/material.dart';

import 'package:map_view/map_view.dart';



class Venue extends StatelessWidget {
  final String id;
  final String name;
  final Map<String, dynamic> location;
  Location loc2;
  final List<dynamic> categories;
  final String referralId;
  bool hasPerk;
  final Map<String, dynamic> photos;
  final StaticMapProvider mapProvider;
  MapView _mapView;
  Uri _staticMapURI;

  Venue(this.mapProvider, {this.id, this.name, this.location, this.categories, this.referralId, this.hasPerk, this.photos}) {
    _mapView = new MapView();
    loc2 = new Location(this.location.containsKey('lat') ? this.location['lat'] : 1.0,
        this.location.containsKey('lng') ? this.location['lng'] : 1.0);
        List<Marker> markers = <Marker>[
          new Marker(
            this.id,
            this.name,
            this.loc2.latitude,
            this.loc2.longitude
          )
        ];
    _staticMapURI = mapProvider.getStaticUriWithMarkers(markers, center: loc2, width: 800, height: 400, maptype: StaticMapViewType.roadmap);
  } factory Venue.fromJSON(StaticMapProvider mapProvider, Map<String, dynamic> json) {
    return Venue(
      mapProvider,
      id: json.containsKey('id') ? json['id'] : '',
      name: json.containsKey('name') ? json['name'] : '',
      location: json.containsKey('location') ? json['location'] : {},
      categories: json.containsKey('categories') ? json['categories'] : [],
      referralId: json.containsKey('referralId') ? json['referralId'] : '',
      hasPerk: json.containsKey('hasPerk') ? json['hasPerk'] : false,
      photos: json.containsKey('photos') ? json['photos'] : {}
    );
  }

  void log(){
    print('id: $id');
    print('name: $name');
  }

  Text _printAddress() {
    String address = '';
    if (location.containsKey('formattedAddress')) {
      location['formattedAddress'].forEach((e) {
        address += '$e, ';
      });
    }
    return Text(address.substring(0, address.length-2), textAlign: TextAlign.center);
  }

  Widget _buildVenueCard() {
    return Card(child: Column(children: <Widget>[
      Image.network(_staticMapURI.toString()),
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