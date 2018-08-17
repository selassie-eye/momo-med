import 'package:flutter/material.dart';

class Venue {
  String id;
  String name;
  Map<String, dynamic> location;
  List<dynamic> categories;
  Map<String, dynamic> photos;

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
}