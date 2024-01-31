import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/models/CountryData.dart';

class CountryServices {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://geodb-free-service.wirefreethought.com/v1/geo/places",
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ),
  );

  Future getData({int offset = 0, required String name}) async {
    try {
      final response = await dio.get('?offset=$offset&namePrefix=$name');
      debugPrint('Response: $response');
      return CountryData.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint("$e");
    } catch (e) {
      rethrow;
    }
  }
}
