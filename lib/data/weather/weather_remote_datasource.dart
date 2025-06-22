import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherRemoteDatasource {
  final String _apiKey = '5006c944606546a188e125639252106';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    final url =
        'https://api.weatherapi.com/v1/current.json?key=$_apiKey&q=$lat,$lon';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
