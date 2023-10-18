import 'package:http/http.dart' as http;

class NetworkClient {
  Future<http.Response> fetch(String httpString, Map<String, String> headers) {
    final uri = Uri.parse(httpString);

    return http.get(uri, headers: headers);
  }
}
