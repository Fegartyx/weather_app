import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/CountryData.dart';

class CountryServices {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://countriesnow.space/api/v0.1/countries",
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ),
  );

  Future getData() async {
    try {
      final response = await dio.get('');
      return CountryData.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("$e");
    } catch (e) {
      rethrow;
    }
  }
}
