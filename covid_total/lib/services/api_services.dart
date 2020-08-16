

import 'dart:async';
import 'dart:convert';
import 'package:covid_total/export.dart';
import 'package:covid_total/models/country_history_model.dart';
import 'package:covid_total/models/summary_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_total/constants.dart';
import 'package:dio/dio.dart';

enum HttpMethod {
  get, post
}

class ApiServices {
  static final instance = ApiServices();
  var _dio = Dio();

  Future<GlobalModel> getTotal() {
    return _request(path: ApiPath.summary)
        .then((data) {
      return GlobalModel.fromJson(data);
    });
  }

  Future<List<CountryHistoryModel>> getHistory(String id) {
    return _request(path: ApiPath.countryDetails + id)
        .then((data) {
      return List<CountryHistoryModel>.from(data.map((x) => CountryHistoryModel.fromJson(x)));
    });
  }


  Future<dynamic> _request({
    @required String path,
    HttpMethod method = HttpMethod.get,
    Map<String,dynamic> param,
    }) async {

    final finalUrl = Constants.domain + path;
    Map<String,dynamic> headers;

    print("=== REQUEST ===");
    print("=> url : $finalUrl");
    print("=> ${method.toString()}");
    if (param != null) {
      print("=> param : ${jsonEncode(param)}");
    }
    if (headers != null) {
      print("=> header : ${jsonEncode(headers)}");
    }

    try {
      Response response ;
      Options optionsCommon = Options(
          headers: headers,
          sendTimeout: 30 * 1000,
          receiveTimeout: 30 * 1000);

      switch (method) {
        case HttpMethod.get:
          response = await _dio.get(
              finalUrl,
              options: optionsCommon,
              queryParameters: param);
          break;
        case HttpMethod.post:
          response = await _dio.post(
            finalUrl,
            options: optionsCommon,
            data: param,
          );
          break;
      }

      /// parse data
      dynamic data ;//= jsonDecode(response.data);

      if (response.data is Map) {
        data = response.data;
      } else if (response.data is List) {
        data = response.data;
      } else if (response.data is String) {
        data = json.decode(response.data);
      }

      print("=> SUCCESS : ${response.data}");

      return data;
    } catch(e) {
      if (e is PlatformException) {
        throw e;
      } else {
        throw PlatformException(
            code: "", message: "Could not connect to server");
      }
    }
  }




}