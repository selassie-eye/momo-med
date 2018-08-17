import 'package:flutter/material.dart';

class Venue extends StatelessWidget {
  final String id;
  final String name;
  final Map<String, dynamic> location;
  final List<dynamic> categories;
  final Map<String, dynamic> photos;

  Venue({this.id, this.name, this.location, this.categories, this.photos});
  factory Venue.fromJSON(Map<String, dynamic> json) {
    return Venue(
      id: json.containsKey('id') ? json['id'] : '',
      name: json.containsKey('name') ? json['name'] : '',
      location: json.containsKey('location') ? json['location'] : {},
      categories: json.containsKey('categories') ? json['categories'] : [],
      photos: json.containsKey('photos') ? json['photos'] : {}
    );
  }

  Widget _buildVenueCard() {
    return Card(child: Column(children: <Widget>[
      Image(image: AssetImage('assets/logo.png')),
      Container(margin: EdgeInsets.all(10.0), child: Text(name)),
      Container(margin: EdgeInsets.all(10.0), child: Text('${location['address']}, ${location['city']}, ${location['state']} ${location['postalCode']}')),
    ],),);
  }

  @override
    Widget build(BuildContext context) {
      return Center(child: _buildVenueCard());
    }
}