import "package:dio/dio.dart";
import "package:flutter/cupertino.dart";

import "../models/Weather.dart";

class WeatherServices {
  static const String API = '45d54084ebb34c7d975234628242101';
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://api.weatherapi.com/v1/forecast.json",
    ),
  );

  Future<Weather> getDataForecastLatLong(double lat, double long) async {
    try {
      debugPrint("Lat: $lat, Long: $long");
      final response = await dio.get('?key=$API&q=$lat,$long&days=3');
      // debugPrint(response.data.toString());
      return Weather.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("$e");
      rethrow;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future getDataForecastCity(String city) async {
    try {
      final response = await dio.get('?key=$API&q=medan&days=3');
      return Weather.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        // Tangani kesalahan respons dari server
        debugPrint("Error response data: ${e.response!.data}");
      }
    } catch (e) {
      rethrow;
    }
  }
}
