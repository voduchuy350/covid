
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
      height: screenSize.height * 0.7,
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
              size: 14,
              color: Colors.black54,
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
                      color: Colors.black,
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
                    return _buildError(snapshot.error);
                  }

                  if (snapshot.data == null) {
                    return LoadingWidget();
                  } else {
                     return ListView.builder(itemBuilder: (ctx,index) {
                      return _buildCountryItem( index: index,item: snapshot.data[index]);
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


  Widget _buildCountryItem({int index , CountryHistoryModel item}) {

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
                color: Colors.black54,
                size: 12,
              ),
            ),
            flex: 5,
          ),
          Expanded(
            flex: 3,
            child: CovidText(item.confirmed.toFormatNumber(),
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              textAlign: TextAlign.right,
              size: 12,
            ),
          ),
          Expanded(
            flex: 3,
            child: CovidText(item.deaths.toFormatNumber(),
              fontWeight: FontWeight.bold,
              color: Colors.black54,
              textAlign: TextAlign.right,
              size: 12,
            ),
          ),
          Expanded(
            flex: 3,
            child: CovidText(item.recovered.toFormatNumber(),
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
          color: CovidColors.colorF1EFEC,
        //color: Colors.white
//          borderRadius: BorderRadius.only(topLeft:  const  Radius.circular(10.0),
//              topRight: const  Radius.circular(10.0))
      ),
      //padding: EdgeInsets.only(top: 20),
//      child: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 20),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//
//            Padding(
//              padding: const EdgeInsets.only(top: 50),
//              child: CovidText(widget.country.country,
//                fontWeight: FontWeight.bold,
//                size: 25,
//              ),
//            )
//
//          ],
//        ),
//      ),
    );
  }


  Widget _buildError(dynamic title) {
    return MyEmptyWidget(
      //image: TyMyImages.ic_empty_customer,
      error: title,
    );
  }

}
