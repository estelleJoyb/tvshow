import 'dart:convert';
import 'package:tvshow/src/data/show.dart';
import 'apiService.dart';

class ShowService {
  static const String baseUrl = 'https://www.episodate.com/api';

  static Future<List<Show>> fetchShows(int page) async {
    final response = await ApiService.instance.getRequest("most-popular?page=$page");

    if (response != null && response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> showsData = data['tv_shows'];
      return showsData.map((showData) => Show.fromJson(showData)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }

  static Future<Show> fetchShow(String showId) async {
    final response = await ApiService.instance.getRequest("show-details?q=$showId");

    if (response != null && response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Show.fromJson(data['tvShow']);
    } else {
      throw Exception('Failed to load show');
    }
  }

  static Future<List<Show>> searchShows(String searchWord, int page) async {
    final response = await ApiService.instance.getRequest("search?q=$searchWord&page=$page");

    if (response != null && response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> showsData = data['tv_shows'];
      return showsData.map((showData) => Show.fromJson(showData)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }

  static Future<Show> fetchShowById(int id) async {
    final response =  await ApiService.instance.getRequest("show-details?q=$id");
    if (response != null && response.statusCode == 200) {
      return Show.fromJson(jsonDecode(utf8.decode(response.bodyBytes))['tvShow']);
    } else {
      throw Exception(response != null ? response.body : "");
    }
  }
}