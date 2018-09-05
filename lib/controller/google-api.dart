import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/category-tree.dart';
import '../model/query.dart';
import '../model/venue.dart';

import 'package:map_view/static_map_provider.dart';
import 'package:location/location.dart';

class GoogleAPI {
  static String googleAPIKey = 'AIzaSyDWR6zUgE9BfMQU-u_p21yJqXlp5CbbBfA';

  Query query;
  StaticMapProvider mapProvider;
  Location locServer;
  Map<String, double> userLoc;
  Stream<Map<String, double>> userLocStream;

  GoogleAPI() {
    query = Query();
    mapProvider = StaticMapProvider(googleAPIKey);
    locServer = new Location();
    updateUserLoc();
    userLocStream = locServer.onLocationChanged();
    userLocStream.listen((loc) {
      print(loc);
      userLoc = loc;
    });
  }

  void updateUserLoc() async {
    await locServer.getLocation().then((loc) {
      // print(loc);
      userLoc = loc;
    });
  }

  Query updateQuery({String keyword = '', String rankBy = Query.defaultRankBy, double lat = Query.defaultLat, double lng = Query.defaultLng, String type = Query.defaultType}) {
    print('query made');
    return this.query = Query(keyword: keyword, rankBy: rankBy, lat: lat, lng: lng, type: type);
  }

    Query updateQueryWithUserLoc({String keyword = '', String rankBy = Query.defaultRankBy, double lng = Query.defaultLng, String type = Query.defaultType}) {
    print('userloc query made');
    updateUserLoc();
    return this.query = Query(keyword: keyword, rankBy: rankBy, lat: userLoc['latitude'], lng: userLoc['longitude'], type: type);
  }

  Future<List<Venue>> searchQuery() async {
    Map<String, dynamic> bodyJSON = {};
    List<dynamic> rawResults = [];
    List<Venue> ret = [];
    print(query.google() + '&key=$googleAPIKey');
    await http.get(query.google() + '&key=$googleAPIKey').then((http.Response res) {
      if (res.statusCode == 200) {
        bodyJSON = json.decode(res.body);
        rawResults = bodyJSON.containsKey('results') ? bodyJSON['results'] : [];
      }
    });
    //  print(bodyJSON.toString());
    rawResults.forEach((e) => ret.add(Venue.fromJSON({'latitude': userLoc['latitude'], 'longitude': userLoc['longitude']}, mapProvider, e)));
    return Future.value(ret);
  }
}