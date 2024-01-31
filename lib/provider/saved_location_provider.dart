import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/provider/country_providers.dart';
import 'package:weather_app/services/WeatherServices.dart';

import '../models/Weather.dart';

class AsyncSavedLocation extends AutoDisposeAsyncNotifier<List<Weather>> {
  @override
  FutureOr<List<Weather>> build() async {
    final String location = ref.watch(searchCountryProviders);
    debugPrint('Location: $location');
    await getAndAddData(location);
    return [];
  }

  Future<void> getAndAddData(String name) async {
    state = const AsyncValue.loading();
    final WeatherServices countryServices = WeatherServices();
    state = await AsyncValue.guard(() async {
      final countryData = await countryServices.getDataForecastCity(city: name);
      debugPrint('Country Data: $countryData');
      return countryData;
    });
  }
}

final savedLocationProviders =
    AsyncNotifierProvider.autoDispose<AsyncSavedLocation, List<Weather>>(() {
  return AsyncSavedLocation();
});
