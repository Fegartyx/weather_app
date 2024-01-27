// To parse this JSON data, do
//
//     final countryData = countryDataFromJson(jsonString);

import 'dart:convert';

CountryData countryDataFromJson(String str) =>
    CountryData.fromJson(json.decode(str));

String countryDataToJson(CountryData data) => json.encode(data.toJson());

class CountryData {
  final bool error;
  final String msg;
  final List<Country> data;

  CountryData({
    required this.error,
    required this.msg,
    required this.data,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        error: json["error"],
        msg: json["msg"],
        data: List<Country>.from(json["data"].map((x) => Country.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Country {
  final String iso2;
  final String iso3;
  final String country;
  final List<String> cities;

  Country({
    required this.iso2,
    required this.iso3,
    required this.country,
    required this.cities,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        iso2: json["iso2"],
        iso3: json["iso3"],
        country: json["country"],
        cities: List<String>.from(json["cities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "iso2": iso2,
        "iso3": iso3,
        "country": country,
        "cities": List<dynamic>.from(cities.map((x) => x)),
      };
}
