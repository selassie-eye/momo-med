import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/category-tree.dart';
import '../model/query.dart';
import '../model/venue.dart';

import 'package:map_view/static_map_provider.dart';
import 'package:location/location.dart';

class SearchController {
  static String googleAPIKey = 'AIzaSyDWR6zUgE9BfMQU-u_p21yJqXlp5CbbBfA';

  CategoryTree categories;
  Query query;
  StaticMapProvider mapProvider;
  Location locServer;
  Map<String, double> userLoc;
  Stream<Map<String, double>> userLocStream;

  SearchController() {
    _getCategories().then((value) => categories = CategoryTree(value));
    query = Query();
    mapProvider = StaticMapProvider(googleAPIKey);
    locServer = new Location();
    userLocStream = locServer.onLocationChanged();
    userLocStream.listen((loc) {
      print(loc);
      userLoc = loc;
    });
  }

  void updateUserLoc() {
    locServer.getLocation().then((loc) {
      print(loc);
      userLoc = loc;
    });
  }



  Query updateQuery({String keyword = '', String rankBy = Query.defaultRankBy, double lat = Query.defaultLat, double lng = Query.defaultLng, String type = Query.defaultType}) {
    print('query made');
    return this.query = Query(keyword: keyword, rankBy: rankBy, lat: lat, lng: lng, type: type);
  }

    Query updateQueryWithUserLoc({String keyword = '', String rankBy = Query.defaultRankBy, double lng = Query.defaultLng, String type = Query.defaultType}) {
    print('userloc query made');
    print(userLoc);
    return this.query = Query(keyword: keyword, rankBy: rankBy, lat: userLoc['latitude'], lng: userLoc['longitude'], type: type);
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
    bodyJSON.forEach((e) => ret.add(Venue.fromJSON({'latitude': userLoc['latitude'], 'longitude': userLoc['longitude']}, mapProvider, e)));
    return Future.value(ret);
  }
}