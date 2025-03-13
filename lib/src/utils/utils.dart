class Utils{
  static DateTime? formatDate(String? dateString) {
    try {
      if (dateString != null && dateString.isNotEmpty) {
        return DateTime.parse(dateString!);
      }
      return null;
    } on FormatException catch (e) {
      return null;
    }
  }
}