import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/CountryData.dart';
import 'package:weather_app/services/CountryServices.dart';

class SearchCountryProviders extends AutoDisposeNotifier<String> {
  SearchCountryProviders() : super();

  void searchCountry(String name) {
    state = name;
  }

  @override
  String build() {
    // TODO: implement build
    return '';
  }
}

class AsyncCountryProviders
    extends AutoDisposeFamilyAsyncNotifier<CountryData, (String, int?)> {
  @override
  FutureOr<CountryData> build((String, int?) arg) async {
    return await getData(arg.$1, arg.$2);
  }

  Future<CountryData> getData(String name, int? offset) async {
    final CountryServices countryServices = CountryServices();
    final countryData =
        await countryServices.getData(name: name, offset: offset ?? 0);
    return countryData;
  }
}

final countryProviders = AsyncNotifierProvider.autoDispose
    .family<AsyncCountryProviders, CountryData, (String, int?)>(() {
  return AsyncCountryProviders();
});

final searchCountryProviders =
    NotifierProvider.autoDispose<SearchCountryProviders, String>(() {
  return SearchCountryProviders();
});
