import 'dart:async';
import 'dart:convert';

import 'package:covid_total/models/summary_model.dart';
import 'package:covid_total/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';



class CountryWidgetBloc implements Bloc {

  CountryWidgetBloc(GlobalModel model) {
    this._globalModel = model;
    search("");
  }

  GlobalModel _globalModel ;
//  List<CountryModel> _countryList = [] ;
  BehaviorSubject<List<CountryModel>> _searchController = BehaviorSubject();
  Observable<List<CountryModel>> get searchStream => _searchController.stream;

  void search(String text) {

    if (isEmpty(text)) {
      _searchController.add(_globalModel.countries);
    }

    final emptyString = "Không tìm thấy quốc gia này!";
    text = removeDiacritics(text.trim()).toLowerCase();
    var list = _globalModel.countries.where((e) {
      final countryName = removeDiacritics(e.country);
      return countryName.toLowerCase().contains(text);
    }).toList();

    if(list.length > 0) {
      _searchController.add(list);
    } else {
      _searchController.addError(emptyString);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.close();

  }


}

