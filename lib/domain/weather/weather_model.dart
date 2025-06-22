class Weather {
  final String location;
  final double temperatureC;
  final double temperatureF;
  final String condition;
  final String iconUrl;
  final double windSpeed;
  final int humidity;
  final int cloud;

  Weather({
    required this.location,
    required this.temperatureC,
    required this.temperatureF,
    required this.condition,
    required this.iconUrl,
    required this.windSpeed,
    required this.humidity,
    required this.cloud,
  });
}
