/*
import 'package:tvshow/src/data/episode.dart';

import '../utils/utils.dart';
class Show{
  final int id;
  final String name;
  final String? url;
  final String? description;
  final String permalink;
  final DateTime? start_date;
  final DateTime? end_date;
  final String country;
  final String network;
  final String status;
  final String image_thumbnail_path;
  final String image_path;
  final String rating;
  final int rating_count;
  //final List<String> genres;
 // final List<String> pictures;
  final List<Episode>? episodes;
  Show(this.id,
      this.name,
      this.url,
      this.description,
      this.permalink,
      this.start_date,
      this.end_date,
      this.country,
      this.network,
      this.status,
      this.image_thumbnail_path,
      this.image_path,
      this.rating,
      this.rating_count,
      //this.genres,
      //this.pictures,
      this.episodes);

  factory Show.fromJson(Map<String, dynamic> json) {
    print("JSON $json");
    return Show(
      json['id'],
      json['name'],
      json['url'] ?? '',
      json['description'] ?? '',
      json['permalink'],
        Utils.formatDate((json['start_date'])),
      Utils.formatDate(json['end_date']),
    json['country'],
    json['network'],
    json['status'],
    json['image_thumbnail_path'],
    json['image_path'] ?? '',
    json['rating'] ?? '',
    json['rating_count'] ?? 0,
    //json['genres'] ?? [],
    //json['pictures'] ?? [],
    (json['episodes'] as List<dynamic>?)?.map((e) => Episode.fromJson(e)).toList(),
    );
  }

}
*/
import 'package:tvshow/src/data/episode.dart';

import '../utils/utils.dart';
import 'package:tvshow/src/data/episode.dart';
import '../utils/utils.dart';

class Show {
  final int id;
  final String name;
  final String? url;
  final String? description;
  final String permalink;
  final DateTime? start_date;
  final DateTime? end_date;
  final String country;
  final String network;
  final String status;
  final String image_thumbnail_path;
  final String image_path;
  final String rating;
  final int rating_count;
  final Map<int, List<Episode>> serieContent;

  Show(
      this.id,
      this.name,
      this.url,
      this.description,
      this.permalink,
      this.start_date,
      this.end_date,
      this.country,
      this.network,
      this.status,
      this.image_thumbnail_path,
      this.image_path,
      this.rating,
      this.rating_count,
      this.serieContent,
      );

  factory Show.fromJson(Map<String, dynamic> json) {
    print("JSON $json");

    List<Episode>? episodes = (json['episodes'] as List<dynamic>?)?.map((e) => Episode.fromJson(e)).toList();

    // Group episodes by season
    Map<int, List<Episode>> serieContent = {};
    if (episodes != null) {
      for (final episode in episodes) {
        if (!serieContent.containsKey(episode.season)) {
          serieContent[episode.season] = [];
        }
        serieContent[episode.season]!.add(episode);
      }
    }

    return Show(
      json['id'],
      json['name'],
      json['url'] ?? '',
      json['description'] ?? '',
      json['permalink'],
      Utils.formatDate((json['start_date'])),
      Utils.formatDate(json['end_date']),
      json['country'],
      json['network'],
      json['status'],
      json['image_thumbnail_path'],
      json['image_path'] ?? '',
      json['rating'] ?? '',
      json['rating_count'] ?? 0,
      serieContent,
    );
  }
}