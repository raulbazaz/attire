import 'package:attireit/Presentation/providers/weather_provider.dart';
import 'package:attireit/domain/weather_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WeatherContainer extends StatefulWidget {
  final String location;

  const WeatherContainer({super.key, required this.location});

  @override
  State<WeatherContainer> createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  bool _hasFetched = false;

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context, listen: true);

    if (!_hasFetched) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        weatherProvider.fetchWeather(widget.location);
        _hasFetched = true;
      });
    }

    if (weatherProvider.isLoading) {
      return _buildLoading();
    } else if (weatherProvider.error != null) {
      return _buildError(context, weatherProvider.error!);
    } else if (weatherProvider.weather != null) {
      return _buildWeatherInfo(context, weatherProvider.weather!);
    } else {
      return _buildEmptyContainer();
    }
  }

  Widget _buildLoading() {
    return Container(
      height: 154,
      width: 146,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildEmptyContainer() {
    return Container(
      height: 154,
      width: 146,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildWeatherInfo(BuildContext context, Weather weather) {
    return Container(
      height: 154,
      width: 146,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            weather.location.split(',').first,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Image.network(
            weather.iconUrl,
            width: 56,
            height: 56,
            color: Colors.white,
          ),
          Text(
            '${weather.temperatureC.round()}°C',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, String message) {
    return Container(
      height: 154,
      width: 146,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          const Text(
            'Weather Error',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Provider.of<WeatherProvider>(context, listen: false)
                  .fetchWeather(widget.location);
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              backgroundColor: Colors.white,
              foregroundColor: Colors.red,
            ),
            child: const Text(
              'Retry',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
