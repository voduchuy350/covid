import 'package:covid_total/models/summary_model.dart';
import 'package:covid_total/screen/home/widget/animated_widget/banner_widget.dart';
import 'package:covid_total/screen/home/widget/animated_widget/virus1_widget.dart';
import 'package:covid_total/screen/home/widget/animated_widget/virus2_widget.dart';
import 'package:covid_total/screen/home/widget/country_widget.dart';
import 'package:covid_total/screen/home/widget/global_widget.dart';
import 'package:covid_total/screen/home/widget/tab_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:covid_total/components/shadow_widget.dart';
import 'package:covid_total/components/empty_widget.dart';
import 'package:covid_total/export.dart';
import 'package:covid_total/screen/home/blocs/home_bloc.dart';
import 'package:covid_total/screen/home/widget/home_cliper.dart';

class HomeScreen extends StatefulWidget {
  static Widget newInstance() {
    return BlocProvider<HomeBloc>(
      child: HomeScreen(),
      creator: (c, b) => HomeBloc(),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  HomeBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = getCurrentBloc<HomeBloc>();
  }

  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
    _bloc.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
        //backgroundColor: CovidColors.colorBackgroundF2F0ED,
      backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipPath(
              clipper: HomeClipper(),
              child: Container(
                width: double.infinity,
                height: screenSize.height * 0.40,

                decoration: BoxDecoration(
                    // color : CovidColors.colorMain ,
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      CovidColors.colorMain,
                      //CovidColors.colorMainMedium
                      Color(0xff8991FF)
                    ])),
                child: Stack(
                  children: <Widget>[
                    /// virus
                    Positioned(
                      top: 50,
                      right: 120,
                      child: Image.asset(
                        CovidImages.ic_virus_4,
                        height: 30,
                        width: 30,
                      ),
                    ),

                    /// virus
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Image.asset(
                        CovidImages.ic_virus_5,
                        height: 50,
                        width: 50,
                      ),
                    ),

                    /// virus
                    Positioned(
                      bottom: 60,
                      right: 10,
                      child: Image.asset(
                        CovidImages.ic_virus_4,
                        height: 50,
                        width: 50,
                      ),
                    ),

                    /// virus
                    Positioned(
                      left: screenSize.width / 2 - 100,
                      bottom: 80,
                      child: Center(
                        child: Image.asset(
                          CovidImages.ic_virus_5,
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),

                    /// virus
                    Center(
                      child: Image.asset(
                        CovidImages.ic_virus_4,
                        height: 40,
                        width: 40,
                      ),
                    ),

                    /// banner
                    Positioned(
                      top: -70,
                      right: 20,
                      child:
//                      Image.asset(
//                        CovidImages.ic_banner,
//                        height: 350,
//                        width: screenSize.width * 1.1,
//                      ),
                        BannerWidget()

                    ),


                    /// virus
                    Positioned(
                        top: 50,
                        left: 20,
                        child: Image.asset(CovidImages.ic_virus_2,
                          height: 40,
                          width: 40,
                        )
                    ),

                    /// virus
                    Positioned(
                        top: 90,
                        left: 70,
                        child: Image.asset(CovidImages.ic_virus_3,
                          height: 40,
                          width: 40,
                        )
                    ),

                    /// virus động 2
                    Positioned(
                        top: 40,
                        left: 0,
                        right: 70,
                        child: Center(child: Virus2Widget())
                    ),


                    Positioned(
                      bottom: 80,
                      left: 20,
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "Những ",
                            style: styleCovidText.copyWith(
                                fontWeight: FontWeight.w400,
                                color: CovidColors.colorMainLight,
                                fontSize: scaleWidth(16))),
                        TextSpan(
                            text: "con số ",
                            style: styleCovidText.copyWith(
                                color: Colors.white,
                                fontSize: scaleWidth(30),
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: "biết nói ",
                            style: styleCovidText.copyWith(
                                fontWeight: FontWeight.w400,
                                color: CovidColors.colorMainLight,
                                fontSize: scaleWidth(16))),
                      ])),
                    ),

                    //
                    Positioned(
                      bottom: 40,
                      right: 0,
                      left: 0,
                      child: Center(
                          child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "về ",
                            style: styleCovidText.copyWith(
                                fontWeight: FontWeight.w400,
                                color: CovidColors.colorMainLight,
                                fontSize: scaleWidth(16))),
                        TextSpan(
                            text: "COVID-19!",
                            style: styleCovidText.copyWith(
                                color: Colors.white,
                                fontSize: scaleWidth(30),
                                fontWeight: FontWeight.bold))
                      ]))),
                    )
                  ],
                ),
                //child: ,
              ),
            ),

            StreamBuilder<GlobalModel>(
              stream: _bloc.mainStream,
              builder: (context, snapshot) {
                if (snapshot.error != null) {
                  return _buildError(snapshot.error);
                }

                if (snapshot.data == null) {
                  return LoadingWidget();
                } else {
                  return _buildContent(snapshot.data);
                }
              }
            )
          ],
        ));
  }

  int _currentIndex = 0;

  Widget _buildContent(GlobalModel model) {

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HomeTabBar((newIndex) {
            setState(() {
              _currentIndex = newIndex;
            });
          }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: _currentIndex == 0 ? GlobalWidget(model) : CountryWidget.newInstance(model: model),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildError(dynamic title) {
    return MyEmptyWidget(
      //image: TyMyImages.ic_empty_order,
      error: title,
    );
  }


}
