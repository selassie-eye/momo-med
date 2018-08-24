import './venue.dart';

class Query {
  String query = '';
  int radius = 50000;
  List<double> ll = [];
  List<String> categories = [''];

  static const defaultLat = 29.6478;
  static const defaultLng = -82.33784;
  static const int defaultRadius = 50000;

  List<Venue> results;

  Query({String query = '', int radius = defaultRadius, double lat = defaultLat, double lng = defaultLng, List<String> categories = const []}) {
    this.query = query;
    this.radius = radius;
    this.ll.add(lat);
    this.ll.add(lng);
    this.categories = categories;
  }

  String toString() {
    String baseURL = 'https://us-central1-momo-medical.cloudfunctions.net/searchRequest';
    baseURL += '?ll=${ll[0]},${ll[1]}';
    baseURL += '&radius=$radius';
    baseURL += '&intent=browse';
    baseURL += query.isNotEmpty ? '&query=$query' : '';
    baseURL += '&categoryId=';
    if(categories.isNotEmpty) {
      categories.forEach((String s) => baseURL += '$s,');
    } else baseURL += '4bf58dd8d48988d104941735';
    print(baseURL);
    return baseURL;
  }
}