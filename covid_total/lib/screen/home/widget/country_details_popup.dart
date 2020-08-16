
import 'dart:io';

import 'package:covid_total/components/empty_widget.dart';
import 'package:covid_total/components/shadow_widget.dart';
import 'package:covid_total/models/country_history_model.dart';
import 'package:covid_total/models/summary_model.dart';
import 'package:covid_total/screen/home/blocs/country_details_bloc.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';
import 'animated_widget/case_item_widget.dart';


void showCountryDetailsPopup({
  @required BuildContext context,
  CountryModel country
}) {

  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      isScrollControlled: true,
      builder: (BuildContext bc){
        return CountryDetailsWidget.newInstance(country: country);
      }
  );
}

class CountryDetailsWidget extends StatefulWidget {

  static Widget newInstance({CountryModel country}) {
    return BlocProvider<CountryDetailsBloc>(
      child: CountryDetailsWidget(country: country,),
      creator: (c,b) => CountryDetailsBloc(country),
    );
  }

  final CountryModel country;
  CountryDetailsWidget({this.country});

  @override
  _CountryDetailsWidgetState createState() => _CountryDetailsWidgetState();
}

class _CountryDetailsWidgetState extends BaseState<CountryDetailsWidget> {
  CountryDetailsBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = getCurrentBloc<CountryDetailsBloc>();

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: screenSize.height * (Platform.isAndroid ?  0.8 : 0.7),
      //  color: Colors.blue,

      child: Stack(
        children: <Widget>[
          buildBackground(),

          buildContent()

        ],
      ),
    );
  }

  Widget buildContent() {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      //padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          /// title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ShadowWidget(
              cornerRadius: 10,
              shadowColor: Colors.black12.withAlpha(10),
//              spreadRadius: 50,
//            blurRadius: 20,
              child: Container(
                width: screenSize.width - 40,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(width: 16,),
                    Image.network(
                      "https://www.countryflags.io/${widget.country.countryCode}/flat/64.png",
                      fit: BoxFit.fitWidth,
                      width: 100,
                      //width: screenSize.width * 0.3,
                    ),
                    SizedBox(width  : 10,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 14,),
                          Expanded(
                            child: CovidText(widget.country.country,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              size: 17,
                            ),
                          ),


                          CovidText("Cập nhật : ${widget.country.date.toStringWithFormat()}",
//                          /fontWeight: FontWeight.w300,
                            color: Colors.black54,
                            size: 14,
                          ),
                          SizedBox(height: 16,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ShadowWidget(
              shadowColor: Colors.black12.withAlpha(10),
              cornerRadius: 10,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _buildItem(number: widget.country.totalConfirmed,color: CovidColors.colorCovidConfirm,title: "Ca nhiễm"),
                    _buildItem(number: widget.country.totalDeaths,color: CovidColors.colorCovidDeath , title: "Ca tử vong"),
                    _buildItem(number: widget.country.totalRecovered,color: CovidColors.colorCovidRecovered,title: "Ca phục hồi" )
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CovidText("Thống kê theo ngày",
              fontWeight: FontWeight.bold,
              size: 15,
              color: Colors.black.withAlpha(150),
            ),
          ),

          SizedBox(height: 10,),

          Container(
            height: 40,
            //color: CovidColors.colorMainLight,
            color: Color(0xffD9D9D9),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CovidText("Ngày",
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withAlpha(150),
                    ),
                  ),
                  flex: 5,
                ),
                Expanded(
                  flex: 3,
                  child: CovidText("Nhiễm",
                    fontWeight: FontWeight.bold,
                    color: CovidColors.colorCovidConfirm,
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CovidText("Tử vong",
                    fontWeight: FontWeight.bold,
                    color: CovidColors.colorCovidDeath,
                    textAlign: TextAlign.right,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: CovidText("Phục hồi",
                    fontWeight: FontWeight.bold,
                    //color: CovidColors.colorCovidRecovered,
                    textAlign: TextAlign.right,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<List<CountryHistoryModel>>(
                stream: _bloc.mainStream,
                builder: (context, snapshot) {

                  if (snapshot.error != null) {
                    return MyEmptyWidget(
                      error: snapshot.error,
                      onRetry: () {
                        _bloc.loadData();
                      },
                    );
                  }

                  if (snapshot.data == null) {
                    return LoadingWidget();
                  } else {
                     return ListView.builder(itemBuilder: (ctx,index) {
                      return _buildCountryItem( index: index,
                        item: snapshot.data[index],
                          nextItem: index <  snapshot.data.length - 1 ? snapshot.data[index + 1] : null
                      );
                    },
                      padding: EdgeInsets.all(0),
                      itemCount: snapshot.data.length,
                    );;
                  }
                }
            ),
          )

        ],
      ),
    );
  }


  Widget _buildCountryItem({int index ,
    CountryHistoryModel item,
    CountryHistoryModel nextItem}) {

    int confirmed = nextItem != null ? item.confirmed - nextItem.confirmed : item.confirmed;
    int death = nextItem != null ? item.deaths - nextItem.deaths : item.deaths;
    int recovered = nextItem != null ? item.recovered - nextItem.recovered : item.recovered;
//    int confirmed =  item.confirmed;
//    int death =  item.deaths;
//    int recovered =  item.recovered;

    if (confirmed < 0 ) {
      confirmed = 0;
    }
    if (death < 0 ) {
      death = 0;
    }
    if (recovered < 0 ) {
      recovered = 0;
    }

    return Container(
      height: 45,
      width: double.infinity,
      color: index % 2 == 0 ? Colors.white : Color(0xffF7F7F7),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: CovidText(item.date.toStringWithFormat(format: "dd/MM/yyyy"),
                fontWeight: FontWeight.w400,
                color: Colors.black.withAlpha(150) ,
                size: 14,
              ),
            ),
            flex: 5,
          ),
          Expanded(
            flex: 3,
            child: CovidText(confirmed.toFormatNumber(),
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              textAlign: TextAlign.right,
              size: 12,
            ),
          ),
          Expanded(
            flex: 3,
            child: CovidText(death.toFormatNumber(),
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              textAlign: TextAlign.right,
              size: 12,
            ),
          ),
          Expanded(
            flex: 3,
            child: CovidText(recovered.toFormatNumber(),
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.right,
              color: Colors.black54,
              size: 12,
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
    );
  }

  Widget _buildItem({int number,Color color, String title}) {
    return Column(
      children: <Widget>[
        CaseItemWidget(color),
        SizedBox(height: 10,),
        CovidText(
          number.toFormatNumber().toString(),
          fontWeight: FontWeight.bold,
          size: 18,
          color: color,
        ),
        SizedBox(height: 10,),
        CovidText(
          title,
          size: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black38,
        ),
      ],
    );
  }

  Widget buildBackground() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 40),
      decoration: new BoxDecoration(
        color: Color(0xffF2F5F7)
      )
    );
  }


}
