import 'package:covid_total/components/shadow_widget.dart';
import 'package:flutter/material.dart';

import '../../../export.dart';

class HomeTabBar extends StatefulWidget {
  final Function(int) onChanged;

  HomeTabBar(this.onChanged);

  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends BaseState<HomeTabBar> {
  var items = ["Thế giới", "Quốc gia"];
  var selected = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = items.first;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildButton(index: 0),
            SizedBox(width: 20,),
            _buildButton(index: 1)
          ],
        ),
      ),
    );
  }

  Widget _buildButton({int index}) {
  var title = items[index];
    var selected = title == this.selected;

    return InkWell(
      onTap: (){
        setState(() {
          this.selected = title;
          widget.onChanged(index);
        });
      },
      child: ShadowWidget(
        cornerRadius: 20,
        spreadRadius : 2,
        blurRadius : 10,
        verticalOffset : 10,
        child: Container(
          width: 150,
          height: 40,
          decoration: BoxDecoration(
              color: selected ? CovidColors.colorMain : CovidColors.colorMainLight,
            borderRadius: BorderRadius.all(Radius.circular(20))

          ),
          alignment: Alignment.center,
          child: CovidText(
            title,
            color: selected ? Colors.white : CovidColors.colorMain,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
