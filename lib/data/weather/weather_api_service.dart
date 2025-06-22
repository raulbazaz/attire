import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApiService {
  static const String _baseUrl = 'http://api.weatherapi.com/v1';
  final String apiKey;

  WeatherApiService(this.apiKey);

  Future<Map<String, dynamic>> getCurrentWeather(String location) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/current.json?key=$apiKey&q=$location&aqi=no'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
