import 'dart:convert';

Weather weatherFromJson(String str) => Weather.fromJson(json.decode(str));

String weatherToJson(Weather data) => json.encode(data.toJson());

class Weather {
  final Location location;
  final Current current;
  final Forecast forecast;

  Weather(
      {required this.location, required this.current, required this.forecast});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        location: Location.fromJson(json["location"]),
        current: Current.fromJson(json["current"]),
        forecast: Forecast.fromJson(json["forecast"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "current": current.toJson(),
        "forecast": forecast.toJson(),
      };
}

class Location {
  String name;
  String region;
  String country;
  double lat;
  double long;
  String timezone;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.long,
    required this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        name: json["name"],
        region: json["region"],
        country: json["country"],
        lat: json["lat"].toDouble(),
        long: json["lon"].toDouble(),
        timezone: json["tz_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "region": region,
        "country": country,
        "lat": lat,
        "lon": long,
        "tz_id": timezone,
      };
}

class Current {
  String lastUpdated;
  int lastUpdateEpoch;
  CurrentCondition condition;
  double tempC;
  double windKph;
  int humidity;
  double feelsLikeC;

  Current({
    required this.lastUpdated,
    required this.lastUpdateEpoch,
    required this.tempC,
    required this.windKph,
    required this.humidity,
    required this.feelsLikeC,
    required this.condition,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        lastUpdated: json["last_updated"],
        tempC: json["temp_c"],
        condition: CurrentCondition.fromJson(json["condition"]),
        windKph: json["wind_kph"].toDouble(),
        humidity: json["humidity"],
        feelsLikeC: json['feelslike_c'].toDouble(),
        lastUpdateEpoch: json['last_updated_epoch'],
      );

  Map<String, dynamic> toJson() => {
        "last_updated": lastUpdated,
        "last_updated_epoch": lastUpdateEpoch,
        "temp_c": tempC,
        "condition": condition.toJson(),
        "wind_kph": windKph,
        "humidity": humidity,
      };
}

class CurrentCondition {
  String text;
  String icon;

  CurrentCondition({
    required this.text,
    required this.icon,
  });

  factory CurrentCondition.fromJson(Map<String, dynamic> json) =>
      CurrentCondition(
        text: json["text"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "icon": icon,
      };
}

class Forecast {
  List<ForecastDay> forecastDay;

  Forecast({
    required this.forecastDay,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
        forecastDay: List<ForecastDay>.from(
            json["forecastday"].map((x) => ForecastDay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "forecastday": List<dynamic>.from(forecastDay.map((x) => x.toJson())),
      };
}

class ForecastDay {
  final DateTime date;
  final Day day;

  ForecastDay({
    required this.date,
    required this.day,
  });

  factory ForecastDay.fromJson(Map<String, dynamic> json) => ForecastDay(
        date: DateTime.parse(json["date"]),
        day: Day.fromJson(json["day"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date.toIso8601String(),
        "day": day.toJson(),
      };
}

class Day {
  final double avgtempC;
  final double maxwindKph;
  final CurrentCondition dayCondition;

  Day({
    required this.avgtempC,
    required this.maxwindKph,
    required this.dayCondition,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        avgtempC: json["avgtemp_c"].toDouble(),
        maxwindKph: json["maxwind_kph"].toDouble(),
        dayCondition: CurrentCondition.fromJson(json["condition"]),
      );

  Map<String, dynamic> toJson() => {
        "avgtemp_c": avgtempC,
        "maxwind_kph": maxwindKph,
        "condition": dayCondition.toJson(),
      };
}
