import 'dart:async';

import 'package:bloc_provider/bloc_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_total/components/loading_widget.dart';
import 'lifecycle.dart';

/// Provides common utilities and functions to build ui and handle app lifecycle
abstract class BaseState<T extends StatefulWidget> extends LifeCycleState<T> {
  Size screenSize;

  Size designScreenSize;

  /// Called when the app is temporarily closed or a new route is pushed
  @override
  void onPause() {}

  /// Called when users return to the app or the adjacent route of this widget is popped
  @override
  void onResume() {}

  /// Called once when this state's widget finished building
  @override
  void onFirstFrame() {}

  T getCurrentBloc<T extends Bloc>() {
    return BlocProvider.of<T>(context);
  }


  void presentScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen,fullscreenDialog: true));
  }

  void pop({dynamic callbackData}) {
    Navigator.of(context).pop(callbackData);
  }

  void popToRoot() {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  void showKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void hideKeyboard() {
    FocusScope.of(context).nextFocus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
    designScreenSize = getDesignSize() ?? Size(360.0, 640.0);


  }

  handleSetState(data){
    if(mounted) setState(() {
    });
  }


  /// Override to define new design size for ui
  Size getDesignSize() => null;

  String get packageName => null;

  /// Scale the provided 'designSize' proportionally to the screen's width
  double scaleWidth(num designSize, {bool preventScaleDown = false}) {
    if (designSize == null) return null;
    final scaledSize = screenSize.width * designSize / designScreenSize.width;

    if (preventScaleDown && scaledSize < designSize) {
      return designSize?.toDouble();
    }

    return scaledSize;
  }

  /// Scale the provided 'designSize' proportionally to the screen's height
  double scaleHeight(num designSize, {bool preventScaleDown = false}) {
    if (designSize == null) return null;

    final scaledSize = screenSize.height * designSize / designScreenSize.height;

    if (preventScaleDown && scaledSize < designSize) {
      return designSize?.toDouble();
    }

    return scaledSize;
  }

  Widget buildAssetsImage(String path,
      {BoxFit fit = BoxFit.contain, num width, num height, String package}) {
    return Image.asset(path,
        height: height?.toDouble(),
        width: width?.toDouble(),
        package: package ?? packageName,
        fit: fit);
  }


  bool _isShowLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  void showFullScreenLoading() {
    if (!_isShowLoading) {
      _isShowLoading = true;
      showDialog(context: context,
          barrierDismissible: false,
          builder: (c) {
            return WillPopScope(onWillPop: () async {
              return false;
            },child: LoadingWidget(color: Colors.white));
          }
      );
    }
  }

  @override
  Future<dynamic> pushScreen(Widget screen,{String screenName = "",
    bool isPresentAnimation = false}) async{
    Completer<dynamic> c = Completer();

    final routeSetting = RouteSettings(
        name : screenName,
        // bất kì 1 màn hình nào cũng sẽ chứa 1 arg ảo để chứa callback khi popUtils
        arguments: Map()
    );

    var pageRoute = CupertinoPageRoute(builder: (context) => screen, settings: routeSetting,fullscreenDialog: isPresentAnimation);

    var result = await Navigator.push(context, pageRoute);

    // nếu mà có callback kiểu pop bình thường
    if (result != null) {
      c.complete(result);
    }
    // luồng này để check khi popUtils mà có callback param
    else {
      final modal = ModalRoute.of(context);
      // móc ra arg ảo để coi có callback data ko
      final arg = modal.settings.arguments;
      if (arg is Map) {
        final callbackData = arg['result'];
        c.complete(callbackData);
        // reset callback data sau khi return
        // chứ ko là mỗi lần back về nó móc ra lúc nào cũng có callback data
        // do vẫn còn lưu trong arg ảo
        (modal.settings.arguments as Map)['result'] = null;
      } else {
        c.complete(null);
      }
    }

    return c.future;
  }

  @override
  void popToScreen({@required String screenName,Object callbackData}) {
    Navigator.of(context).popUntil((route) {
      // nếu tìm thấy màn hình cần back về
      if (route.settings.name == screenName) {
        // nếu muốn truyền param về màn hình đó
        if (callbackData != null) {
          // lấy ra arg ảo (đã tạo ở bước pushScreen) của màn hình này
          // và set callback data tạm vào 1 key tên là result
          (route.settings.arguments as Map)['result'] = callbackData;
        }
        return true;
      } else {
        return false;
      }
    });
  }

  void hideFullScreenLoading() {
    if (_isShowLoading) {
      _isShowLoading = false;
      pop();
    }
  }

}
