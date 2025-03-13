import 'package:http/http.dart' as http;

class ApiService {
  ApiService._();

  static final instance = ApiService._();

  Future<http.Response?> getRequest(String urlPath) async {

    const String baseUrl = String.fromEnvironment("BASE_URL");
    final Uri uri = Uri.parse('$baseUrl/$urlPath');

    final response = await http.get(
     uri,
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      // request failed
      throw Exception(response.body);
    }
  }

  Future<http.Response?> postRequest(String urlPath, String body) async {

    const String baseUrl = String.fromEnvironment("BASE_URL");

    final Uri uri = Uri.parse('$baseUrl/$urlPath');

    final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode < 400) {
      return response;
    } else {
      // request failed
      throw Exception(response.body);
    }
  }

  Future<http.Response?> putRequest(String urlPath, String body) async {
    const String baseUrl = String.fromEnvironment("BASE_URL");

    final Uri uri = Uri.parse('$baseUrl/$urlPath');

    final response = await http.put(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      // request failed
      throw Exception(response.body);
    }
  }

  Future<http.Response?> deleteRequest(String urlPath) async {
    const String baseUrl = String.fromEnvironment("BASE_URL");

    final Uri uri = Uri.parse('$baseUrl/$urlPath');

    final response = await http.delete(uri, headers: {
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      // request failed
      throw Exception(response.body);
    }
  }
}
