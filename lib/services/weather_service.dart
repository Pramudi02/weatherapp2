import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';

class WeatherService {
  static const String _cacheKey = 'cached_weather';
  static const String _timestampKey = 'cached_timestamp';

  Map<String, double> computeCoords(String index) {
    final cleanIndex = index.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (cleanIndex.length < 4) {
      throw FormatException('Index must contain at least 4 digits');
    }

    final firstTwo = int.parse(cleanIndex.substring(0, 2));
    final nextTwo = int.parse(cleanIndex.substring(2, 4));

    final lat = 5 + (firstTwo / 10.0);
    final lon = 79 + (nextTwo / 10.0);

    return {
      'lat': lat,
      'lon': lon,
    };
  }

  String buildUrl(double lat, double lon) {
    return 'https://api.open-meteo.com/v1/forecast?latitude=${lat.toStringAsFixed(2)}&longitude=${lon.toStringAsFixed(2)}&current_weather=true';
  }

  Future<WeatherModel> fetchWeather(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(
        const Duration(seconds: 10),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final model = WeatherModel.fromJson(json);
        await saveCache(model);
        return model;
      } else {
        throw Exception('Failed to load weather data. Status: ${response.statusCode}');
      }
    } catch (e) {
      final cached = await loadCache();
      if (cached != null) {
        return cached;
      }
      rethrow;
    }
  }

  Future<void> saveCache(WeatherModel model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final json = jsonEncode(model.toJson());
      await prefs.setString(_cacheKey, json);
      await prefs.setString(_timestampKey, DateTime.now().toIso8601String());
    } catch (e) {
      print('Error saving cache: $e');
    }
  }

  Future<WeatherModel?> loadCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);
      
      if (cachedData != null) {
        final json = jsonDecode(cachedData);
        return WeatherModel.fromCachedJson(json);
      }
      return null;
    } catch (e) {
      print('Error loading cache: $e');
      return null;
    }
  }
}
