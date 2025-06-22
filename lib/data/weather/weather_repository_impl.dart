import 'package:attireit/data/weather_api_service.dart';
import 'package:attireit/domain/weather_model.dart';
import 'package:attireit/domain/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiService apiService;

  WeatherRepositoryImpl(this.apiService);

  @override
  Future<Weather> getCurrentWeather(String location) async {
    final data = await apiService.getCurrentWeather(location);

    return Weather(
      location: data['location']['name'],
      temperatureC: data['current']['temp_c'].toDouble(),
      temperatureF: data['current']['temp_f'].toDouble(),
      condition: data['current']['condition']['text'],
      iconUrl: 'https:${data['current']['condition']['icon']}',
      windSpeed: data['current']['wind_kph'].toDouble(),
      humidity: data['current']['humidity'],
      cloud: data['current']['cloud'],
    );
  }
}
