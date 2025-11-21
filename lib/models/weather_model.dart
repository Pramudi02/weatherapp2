class WeatherModel {
  final double temperature;
  final double windSpeed;
  final int weatherCode;
  final DateTime lastUpdated;
  final bool isCached;

  WeatherModel({
    required this.temperature,
    required this.windSpeed,
    required this.weatherCode,
    required this.lastUpdated,
    this.isCached = false,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, {bool isCached = false}) {
    final currentWeather = json['current_weather'];
    
    return WeatherModel(
      temperature: (currentWeather['temperature'] as num).toDouble(),
      windSpeed: (currentWeather['windspeed'] as num).toDouble(),
      weatherCode: currentWeather['weathercode'] as int,
      lastUpdated: DateTime.now(),
      isCached: isCached,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_weather': {
        'temperature': temperature,
        'windspeed': windSpeed,
        'weathercode': weatherCode,
      },
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  factory WeatherModel.fromCachedJson(Map<String, dynamic> json) {
    final currentWeather = json['current_weather'];
    
    return WeatherModel(
      temperature: (currentWeather['temperature'] as num).toDouble(),
      windSpeed: (currentWeather['windspeed'] as num).toDouble(),
      weatherCode: currentWeather['weathercode'] as int,
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      isCached: true,
    );
  }
}
