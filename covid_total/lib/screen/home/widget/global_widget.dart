

import 'dart:convert';

import 'package:covid_total/components/shadow_widget.dart';
import 'package:covid_total/models/summary_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../export.dart';
import 'animated_widget/case_item_widget.dart';


class GlobalWidget extends StatefulWidget {

  final GlobalModel model;

  GlobalWidget(this.model);

  @override
  _GlobalWidgetState createState() => _GlobalWidgetState();
}

class _GlobalWidgetState extends BaseState<GlobalWidget>
    with AutomaticKeepAliveClientMixin<GlobalWidget> {
  WebViewController _controller;


  @override
  Widget build(BuildContext context) {
    var model = widget.model;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildSection(title: "Trong 24 giờ qua",
              confirm: model.global.newConfirmed,
              death: model.global.newDeaths,
              recovered: model.global.newRecovered),

          SizedBox(height: 16,),

          _buildSection(title: "Tất cả (Cập nhật lúc ${model.date.toStringWithFormat()})",
              confirm: model.global.totalConfirmed,
              death: model.global.totalDeaths,
              recovered: model.global.totalRecovered),

          SizedBox(height: 20,),

          _buildPrevent()

        ],
      ),
    );
  }

  Widget _buildPrevent() {

    Widget _buildPreventItem({String image,String title,String subTitle}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(

          children: <Widget>[

            SizedBox(width: 10),
            Image.asset(image,height: 80,width: 80,),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                children: <Widget>[
                  CovidText(
                    title.toUpperCase(),
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                    size: 16,
                  ),
                  SizedBox(height: 5),
                  CovidText(
                      subTitle,
                    textAlign: TextAlign.center,
                    color: Colors.black54,
                  ),
                ],
              ),
            ),

          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 50,
          width: double.infinity,
          color: CovidColors.colorMain,
          alignment: Alignment.center,
          child: CovidText("TÔI CẦN PHẢI LÀM GÌ ?",
            fontWeight: FontWeight.bold,
            size: 14,
            color: Colors.white,
          ),
        ),

        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all (20),
            child: Column(
              children: <Widget>[
                _buildPreventItem(image: CovidImages.ic_prevent_1, title: "luôn Đeo khẩu trang", subTitle: "khi đi nơi công cộng"),

                _buildPreventItem(image: CovidImages.ic_prevent_2, title: "Rửa tay thường xuyên", subTitle: "bằng xà phòng"),

                _buildPreventItem(image: CovidImages.ic_prevent_3, title: "cập nhật thông tin", subTitle: "để trang bị kiến thức cho bản thân"),

                _buildPreventItem(image: CovidImages.ic_prevent_4, title: "gặp bác sĩ", subTitle: "khi có những triệu chứng liên quan"),
              ],
            ),
          ),
        )

      ],
    );
  }


  Widget _buildSection({String title, int confirm, int death, int recovered}) {

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CovidText(title,
            fontWeight: FontWeight.bold,
            size: 14,
            color: Colors.black54,
          ),

          SizedBox(height: 12),

          ShadowWidget(
            spreadRadius: 5,
            blurRadius: 20,
            verticalOffset: 0.5,
            shadowColor: Color(0xffe9e9e9),
            cornerRadius: 10,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  _buildItem(number: confirm,color: CovidColors.colorCovidConfirm,title: "Ca nhiễm"),
                  _buildItem(number: death,color: CovidColors.colorCovidDeath , title: "Ca tử vong"),
                  _buildItem(number: recovered,color: CovidColors.colorCovidRecovered,title: "Ca phục hồi" )
                ],
              ),
            ),
          )


        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
