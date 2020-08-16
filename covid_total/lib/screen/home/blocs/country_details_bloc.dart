import 'dart:async';
import 'dart:convert';

import 'package:covid_total/models/country_history_model.dart';
import 'package:covid_total/models/summary_model.dart';
import 'package:covid_total/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';

class CountryDetailsBloc implements Bloc {

  CountryModel _country ;
  BehaviorSubject<List<CountryHistoryModel>> _controller = BehaviorSubject();
  Observable<List<CountryHistoryModel>> get mainStream => _controller.stream;
  StreamSubscription<List> _dataSub;

  CountryDetailsBloc(CountryModel country) {
    _country = country;
    loadData();
  }

  void loadData() async {
    _controller.add(null);

    _dataSub = ApiServices.instance.getHistory(_country.slug).asStream().listen((data) {
      data.sort((a, b) => b.date.compareTo(a.date));
      if (!_controller.isClosed) {
        _controller.add(data);
      }
    }, onError: (e) {
      if (!_controller.isClosed) {
        _controller.addError(e);
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.close();
    if(_dataSub != null) {
      _dataSub.cancel();
    }
  }


}

