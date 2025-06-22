import 'package:attireit/domain/weather_model.dart';

abstract class WeatherRepository {
  Future<Weather> getCurrentWeather(String location);
}
