// To parse this JSON data, do
//
//     final countryHistoryModel = countryHistoryModelFromJson(jsonString);

import 'dart:convert';

List<CountryHistoryModel> countryHistoryModelFromJson(String str) => List<CountryHistoryModel>.from(json.decode(str).map((x) => CountryHistoryModel.fromJson(x)));

String countryHistoryModelToJson(List<CountryHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryHistoryModel {
  CountryHistoryModel({
    this.country,
    this.countryCode,
    this.province,
    this.city,
    this.cityCode,
    this.lat,
    this.lon,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.date,
  });

  String country;
  String countryCode;
  String province;
  String city;
  String cityCode;
  String lat;
  String lon;
  int confirmed;
  int deaths;
  int recovered;
  int active;
  DateTime date;

  factory CountryHistoryModel.fromJson(Map<String, dynamic> json) => CountryHistoryModel(
    country: json["Country"],
    countryCode: json["CountryCode"],
    province: json["Province"],
    city: json["City"],
    cityCode: json["CityCode"],
    lat: json["Lat"],
    lon: json["Lon"],
    confirmed: json["Confirmed"],
    deaths: json["Deaths"],
    recovered: json["Recovered"],
    active: json["Active"],
    date: DateTime.parse(json["Date"]),
  );

  Map<String, dynamic> toJson() => {
    "Country": country,
    "CountryCode": countryCode,
    "Province": province,
    "City": city,
    "CityCode": cityCode,
    "Lat": lat,
    "Lon": lon,
    "Confirmed": confirmed,
    "Deaths": deaths,
    "Recovered": recovered,
    "Active": active,
    "Date": date.toIso8601String(),
  };
}
