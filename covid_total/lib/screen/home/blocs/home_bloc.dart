import 'dart:async';
import 'dart:convert';

import 'package:covid_total/models/summary_model.dart';
import 'package:covid_total/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';



class HomeBloc implements Bloc {

  GlobalModel _globalModel ;
  BehaviorSubject<GlobalModel> _controller = BehaviorSubject();
  Observable<GlobalModel> get mainStream => _controller.stream;

  Timer _scheduleApiTimer ;

  HomeBloc() {
    loadData();
    startTimer();
  }


  void startTimer() {
    if (_scheduleApiTimer != null ) {
      _scheduleApiTimer.cancel();
    }

    _scheduleApiTimer = Timer.periodic(Duration(hours: 1), (timer) {

    });
  }


  void loadData() async {
    _controller.add(null) ;

    ApiServices.instance.getTotal().then((data) {
      data.countries.sort((a, b) => b.totalConfirmed.compareTo(a.totalConfirmed));

      for (int i = 0 ; i < data.countries.length; i ++) {
        var item = data.countries[i];
        if (item.country.toLowerCase().contains("viet nam")) {
          data.countries.insert(0, item);
          data.countries.removeAt(i + 1);
          break;
        }
      }

      _globalModel = data;
      _controller.add(_globalModel);
    },onError: (e) {
      _controller.addError(e);
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.close();

  }


}

