import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/services/WeatherServices.dart';

import '../models/Weather.dart';

class AsyncSavedLocation extends AutoDisposeAsyncNotifier<List<Weather>> {
  /// Fix datanya di save di suatu tempat karna state akan hilang karna adanya autodispose
  @override
  Future<List<Weather>> build() async {
    // final String locationData = ref.watch(watchSearchLocation);
    // await getData();
    return [];
  }

  Future<void> getData(String name) async {
    /// ambil data dari database atau shared preferences
    // final WeatherServices countryServices = WeatherServices();
    // state = await AsyncValue.guard(() async {
    //   final countryData = await countryServices.getDataForecastCity(city: name);
    //   return [...state.value ?? [], countryData];
    // });
    // debugPrint('State Saved Location: ${state.value?.length}');
    // debugPrint(
    //     'State Saved Location: ${state.value?.map((e) => e.location.name)}');
  }

  Future<bool> addData(String name) async {
    final WeatherServices countryServices = WeatherServices();
    state = await AsyncValue.guard(() async {
      final countryData = await countryServices.getDataForecastCity(city: name);
      final dataList = await checkDuplicate(countryData);
      return [...dataList];
    });
    debugPrint('State Saved Location: ${state.value?.length}');
    debugPrint(
        'State Saved Location: ${state.value?.map((e) => e.location.name)}');
    return true;
  }

  Future<List> checkDuplicate(Weather weather) async {
    var dataState = [...state.value ?? []];

    if (dataState.isEmpty) {
      print('Data State Kosong');
      dataState = [...dataState, weather];
    }
    for (var item in dataState) {
      print('Data State Ada');
      if (!(item.location.name == weather.location.name)) {
        dataState = [...dataState, weather];
      }
    }
    return dataState;
  }
}

final savedLocationProviders =
    AsyncNotifierProvider.autoDispose<AsyncSavedLocation, List<Weather>>(() {
  return AsyncSavedLocation();
});
