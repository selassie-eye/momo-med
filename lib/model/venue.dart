import 'package:flutter/material.dart';

class Venue extends StatelessWidget {
  final String id;
  final String name;
  final Map<String, dynamic> location;
  final List<dynamic> categories;
  final String referralId;
  bool hasPerk;
  final Map<String, dynamic> photos;

  Venue({this.id, this.name, this.location, this.categories, this.referralId, this.hasPerk, this.photos});
  factory Venue.fromJSON(Map<String, dynamic> json) {
    return Venue(
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
      Image(image: AssetImage('assets/logo.png')),
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