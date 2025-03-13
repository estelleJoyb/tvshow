class Episode{
  final int season;
  final int episode;
  final String name;
  final DateTime air_date;

  Episode(
      this.season,
      this.episode,
      this.name,
      this.air_date,
      );

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      json['season'],
      json['episode'],
      json['name'],
      DateTime.parse(json['air_date']),
    );
  }
}
