import './venue.dart';

class Query {
  String keyword = '';
  String rankBy = 'distance';
  List<double> ll = [];
  String type = '';

  static const defaultLat = 29.6478;
  static const defaultLng = -82.33784;
  static const String defaultRankBy = 'distance';
  static const String defaultType = 'doctor';

  List<Venue> results;

  Query({String keyword = '', String rankBy = defaultRankBy, double lat = defaultLat, double lng = defaultLng, String type = defaultType}) {
    this.keyword = keyword;
    this.rankBy = rankBy;
    this.ll.add(lat);
    this.ll.add(lng);
    this.type = type;
  }

  String toString() {
    String baseURL = 'https://us-central1-momo-medical.cloudfunctions.net/searchRequest';
    baseURL += '?location=${ll[0]},${ll[1]}';
    baseURL += type.isNotEmpty ? '&type=$type' : '';
    baseURL += type.isEmpty ? '&rankby=$rankBy' : '';
    baseURL += keyword.isNotEmpty ? '&keyword=$keyword' : '';
    return baseURL;
  }

  String google() {
    String baseURL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json';
    baseURL += '?location=${ll[0]},${ll[1]}';
    baseURL += type.isNotEmpty ? '&rankby=$rankBy' : '';
    baseURL += type.isNotEmpty ? '&type=$type' : '';
    baseURL += keyword.isNotEmpty ? '&keyword=$keyword' : '';
    return baseURL.replaceAll(' ', '+').replaceAll(',', '%2C');
  }
}