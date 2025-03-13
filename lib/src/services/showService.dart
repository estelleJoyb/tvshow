import 'dart:convert';
import 'package:tvshow/src/data/show.dart';
import 'package:http/http.dart' as http;

import 'package:tvshow/src/services/apiService.dart';
class ShowService{
  static Future<List<Show>> fetchShows(int page) async {
    http.Response? response = await ApiService.instance.getRequest("most-popular?page=$page");
    if (response != null && response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes))['tv_shows']
      as List<dynamic>)
          .map((e) => Show.fromJson(e))
          .toList();
    } else {
      throw Exception(response != null ? response.body : "");
    }
  }

  static Future<List<Show>> searchShows(String search, int page) async {
    http.Response? response = await ApiService.instance.getRequest("search?q=$search&page=$page");
    if (response != null && response.statusCode == 200) {
      return (jsonDecode(utf8.decode(response.bodyBytes))['tv_shows']
      as List<dynamic>)
          .map((e) => Show.fromJson(e))
          .toList();
    } else {
      throw Exception(response != null ? response.body : "");
    }
  }

  static Future<Show> fetchShowById(int id) async {
    http.Response? response = await ApiService.instance.getRequest("show-details?q=$id");
    if (response != null && response.statusCode == 200) {
      return Show.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['tvShow']);
    } else {
      throw Exception(response != null ? response.body : "");
    }
  }
}