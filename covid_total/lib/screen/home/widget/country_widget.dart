

import 'package:covid_total/components/covid_text_field.dart';
import 'package:covid_total/models/summary_model.dart';
import 'package:covid_total/screen/home/blocs/country_widget_bloc.dart';
import 'package:covid_total/screen/home/widget/country_details_popup.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';

class CountryWidget extends StatefulWidget {
  static Widget newInstance({GlobalModel model}) {
    return BlocProvider<CountryWidgetBloc>(
      child: CountryWidget(),
      creator: (c,b) => CountryWidgetBloc(model),
    );
  }

//  final GlobalModel model;
//  CountryWidget(this.model);
  @override
  _CountryWidgetState createState() => _CountryWidgetState();
}

class _CountryWidgetState extends BaseState<CountryWidget> {
  TextEditingController _controller = TextEditingController();
  CountryWidgetBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = getCurrentBloc<CountryWidgetBloc>();
    _controller.addListener(() {
      _bloc.search(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CovidTextField(
            hintText: "Gõ tên quốc gia cần tìm kiếm",
            suffixIcon: Icon(Icons.search,color: CovidColors.colorMain,),
            controller: _controller,
          ),
        ),

        SizedBox(height: 20,),

        Container(
          height: 40,
          //color: CovidColors.colorMainLight,
          color: Color(0xffD9D9D9),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: CovidText("Quốc gia",
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withAlpha(150),
                  ),
                ),
                flex: 2,
              ),
              Expanded(
                flex: 1,
                child: CovidText("Nhiễm",
                  fontWeight: FontWeight.bold,
                  color: CovidColors.colorCovidConfirm,
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                flex: 1,
                child: CovidText("Tử vong",
                  fontWeight: FontWeight.bold,
                  color: CovidColors.colorCovidDeath,
                  textAlign: TextAlign.right,
                ),
              ),
              Expanded(
                flex: 1,
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
          child: StreamBuilder<List<CountryModel>>(
            stream: _bloc.searchStream,
            builder: (context, snapshot) {

              if (snapshot.data != null) {
                return ListView.builder(itemBuilder: (ctx,index) {
                  return _buildCountryItem( index: index,item: snapshot.data[index]);
                },
                  padding: EdgeInsets.all(0),
                  itemCount: snapshot.data.length,
                );
              }
              return Container();
            }
          ),
        )


      ],
    );
  }

  Widget _buildCountryItem({int index , CountryModel item}) {

    return InkWell(
      onTap: () {
        showCountryDetailsPopup(context: context,country: item);
      },
      child: Container(
        height: 45,
        width: double.infinity,
        color: index % 2 == 0 ? Colors.white : Color(0xffF7F7F7),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: CovidText(item.country,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  size: 12,
                ),
              ),
              flex: 2,
            ),
            Expanded(
              flex: 1,
              child: CovidText(item.totalConfirmed.toFormatNumber(),
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                textAlign: TextAlign.right,
                size: 12,
              ),
            ),
            Expanded(
              flex: 1,
              child: CovidText(item.totalDeaths.toFormatNumber(),
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                textAlign: TextAlign.right,
                size: 12,
              ),
            ),
            Expanded(
              flex: 1,
              child: CovidText(item.totalRecovered.toFormatNumber(),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.right,
                color: Colors.black54,
                size: 12,
              ),
            ),
            SizedBox(width: 10,)
          ],
        ),
      ),
    );
  }
}
