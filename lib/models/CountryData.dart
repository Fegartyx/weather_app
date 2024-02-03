// To parse this JSON data, do
//
//     final countryData = countryDataFromJson(jsonString);

import 'dart:convert';

CountryData countryDataFromJson(String str) =>
    CountryData.fromJson(json.decode(str));

String countryDataToJson(CountryData data) => json.encode(data.toJson());

class CountryData {
  final List<Data> data;
  final Metadata metadata;

  CountryData({
    required this.data,
    required this.metadata,
  });

  CountryData copyWith({
    List<Data>? data,
    Metadata? metadata,
  }) =>
      CountryData(
        data: data ?? this.data,
        metadata: metadata ?? this.metadata,
      );

  factory CountryData.fromJson(Map<String, dynamic> json) => CountryData(
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        metadata: Metadata.fromJson(json["metadata"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "metadata": metadata.toJson(),
      };
}

class Data {
  final int id;
  final String wikiDataId;
  final String type;
  final String name;
  final String country;
  final String countryCode;
  final String region;
  final String regionCode;
  final String regionWdId;
  final double latitude;
  final double longitude;
  final int population;
  final dynamic distance;
  final String placeType;

  Data({
    required this.id,
    required this.wikiDataId,
    required this.type,
    required this.name,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionCode,
    required this.regionWdId,
    required this.latitude,
    required this.longitude,
    required this.population,
    required this.distance,
    required this.placeType,
  });

  Data copyWith({
    int? id,
    String? wikiDataId,
    String? type,
    String? name,
    String? country,
    String? countryCode,
    String? region,
    String? regionCode,
    String? regionWdId,
    double? latitude,
    double? longitude,
    int? population,
    dynamic distance,
    String? placeType,
  }) =>
      Data(
        id: id ?? this.id,
        wikiDataId: wikiDataId ?? this.wikiDataId,
        type: type ?? this.type,
        name: name ?? this.name,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
        region: region ?? this.region,
        regionCode: regionCode ?? this.regionCode,
        regionWdId: regionWdId ?? this.regionWdId,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        population: population ?? this.population,
        distance: distance ?? this.distance,
        placeType: placeType ?? this.placeType,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        wikiDataId: json["wikiDataId"],
        type: json["type"],
        name: json["name"],
        country: json["country"],
        countryCode: json["countryCode"],
        region: json["region"],
        regionCode: json["regionCode"],
        regionWdId: json["regionWdId"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        population: json["population"],
        distance: json["distance"],
        placeType: json["placeType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wikiDataId": wikiDataId,
        "type": type,
        "name": name,
        "country": country,
        "countryCode": countryCode,
        "region": region,
        "regionCode": regionCode,
        "regionWdId": regionWdId,
        "latitude": latitude,
        "longitude": longitude,
        "population": population,
        "distance": distance,
        "placeType": placeType,
      };
}

class Metadata {
  final int currentOffset;
  final int totalCount;

  Metadata({
    required this.currentOffset,
    required this.totalCount,
  });

  Metadata copyWith({
    int? currentOffset,
    int? totalCount,
  }) =>
      Metadata(
        currentOffset: currentOffset ?? this.currentOffset,
        totalCount: totalCount ?? this.totalCount,
      );

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        currentOffset: json["currentOffset"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "currentOffset": currentOffset,
        "totalCount": totalCount,
      };
}
