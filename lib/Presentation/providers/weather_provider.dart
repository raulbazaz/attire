import 'package:attireit/domain/weather_model.dart';
import 'package:attireit/domain/weather_repository.dart';
import 'package:flutter/foundation.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherRepository weatherRepository;

  WeatherProvider(this.weatherRepository);

  Weather? _weather;
  bool _isLoading = false;
  String? _error;

  Weather? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchWeather(String location) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await weatherRepository.getCurrentWeather(location);
      _error = null;
    } catch (e) {
      _weather = null;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
