import "dart:async";

import "package:flutter/cupertino.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:location/location.dart";
import "package:weather_app/services/WeatherServices.dart";

import "../models/Weather.dart";
import "../services/CountryServices.dart";
import "../services/LocationServices.dart";
import 'package:intl/intl.dart';

final ProviderFamily<String, DateTime> dayMonth =
    Provider.family<String, DateTime>((ref, date) {
  final String formatted = DateFormat.MMMMd().format(date);
  return formatted;
});

final ProviderFamily<String, DateTime> monthDay =
    Provider.family<String, DateTime>((ref, date) {
  final String formatted = DateFormat.E().format(date);
  final String formattedDay = DateFormat.d().format(date);
  return "$formatted $formattedDay";
});

final ProviderFamily<String, int> epochTime =
    Provider.family<String, int>((ref, time) {
  // Konversi epoch ke DateTime
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);

  // Konversi epoch ke DateTime
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';

  // Mendapatkan offset zona waktu dalam format GMT+HH:mm
  final String offset =
      "GMT${dateTime.timeZoneOffset.inHours >= 0 ? '+${dateTime.timeZoneOffset.inHours.toString().padLeft(2, '0')}' : '-${dateTime.timeZoneOffset.inHours.abs().toString().padLeft(2, '0')}'}";

  // Format waktu menjadi "hh:mm a z"
  String formatted = "${dateTime.hour}:${dateTime.minute} $period $offset";

  return formatted;
});

final Provider<WeatherServices> callData = Provider<WeatherServices>((ref) {
  return WeatherServices();
});

final Provider<CountryServices> callCountry = Provider<CountryServices>((ref) {
  return CountryServices();
});

final Provider<LocationServices> callLocation =
    Provider<LocationServices>((ref) {
  return LocationServices();
});

final FutureProvider<LocationData> locationProvider =
    FutureProvider((ref) async {
  final location = ref.watch(callLocation);
  await location.getUserLocation();
  debugPrint("Location: ${location.currentLocation}");
  return location.currentLocation;
});

// final StreamProvider<LocationData> locationStreamProvider =
//     StreamProvider((ref) {
//   final location = ref.watch(callLocation);
//   return location.locationStream;
// });

// final FutureProvider<List<Weather>> weatherProvider =
//     FutureProvider<List<Weather>>((ref) async {
//   final weather = ref.watch(callData);
//   return await weather.getDataForecastLatLong(
//     lat,
//     long,
//   );
// });

class AsyncWeatherProvider extends AutoDisposeAsyncNotifier<Weather> {
  AsyncWeatherProvider() : super();

  @override
  FutureOr<Weather> build() async {
    final location = ref.watch(locationProvider);
    // Menggunakan await untuk mendapatkan nilai dari location secara synchronous
    final locationData = location.whenOrNull(data: (value) => value);

    if (locationData != null) {
      return await getWeather(
        locationData.latitude!,
        locationData.longitude!,
      );
    } else {
      // Handle ketika data location belum tersedia
      throw Exception('Location data is not available');
    }
  }

  Future<Weather> getWeather(double lat, long) async {
    final weather = ref.watch(callData);
    Weather data;
    data = await weather.getDataForecastLatLong(
      lat,
      long,
    );
    state = await AsyncValue.guard(() async {
      return data;
    });
    return data;
  }

  Future replaceWeather(Weather weather) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return weather;
    });
  }
}

final weatherProvider =
    AsyncNotifierProvider.autoDispose<AsyncWeatherProvider, Weather>(() {
  return AsyncWeatherProvider();
});
