import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/category-tree.dart';
import '../model/query.dart';
import '../model/venue.dart';

class SearchController {
  CategoryTree categories;
  Query query;

  SearchController() {
    _getCategories().then((value) => categories = CategoryTree(value));
    query = Query();
  }

  Query updateQuery({String query = '', int radius = Query.defaultRadius, double lat = Query.defaultLat, double lng = Query.defaultLng, List<String> categories = const []}) {
    return this.query = Query(query: query, radius: radius, lat: lat, lng: lng, categories: categories);
  }


  Future<Map<String, dynamic>> _getCategories() async {
    final String _url = 'https://us-central1-momo-medical.cloudfunctions.net/getCategories';
    Map<String, dynamic> ret = {};
    await http.get(_url).then((http.Response res) {
      if (res.statusCode == 200) {
        ret = json.decode(res.body);
      }
    });
    return Future.value(ret);
  }

  Future<List<Venue>> searchQuery() async {
    List<dynamic> bodyJSON = [];
    List<Venue> ret = [];
    await http.get(query.toString()).then((http.Response res) {
      if (res.statusCode == 200) {
        bodyJSON = json.decode(res.body);
      }
    });
    bodyJSON.forEach((e) => ret.add(Venue.fromJSON(e)));
    return Future.value(ret);
  }
}