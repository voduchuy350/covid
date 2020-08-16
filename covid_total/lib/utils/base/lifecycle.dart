import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:covid_total/utils/base/system_lifecycle_listener.dart';
abstract class LifeCycleState<T extends StatefulWidget> extends State<T>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    SystemLifecycleListener.instance.addCallback(handleLifeCycleCallback);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      onFirstFrame();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void handleLifeCycleCallback(AppLifeCycle lifeCycle) {
    if (lifeCycle == AppLifeCycle.onResume) {
      onResume();
    } else if (lifeCycle == AppLifeCycle.onPause) {
      onPause();
    }
  }

  @override
  void dispose() {
    SystemLifecycleListener.instance.removeCallback(handleLifeCycleCallback);
    super.dispose();
  }

  void onResume() {}

  void onPause() {}

  void onFirstFrame() {}

  @override
  void didPopNext() {
    SystemLifecycleListener.instance.addCallback(handleLifeCycleCallback);
    onResume();
  }

  @override
  void didPushNext() {
    SystemLifecycleListener.instance.removeCallback(handleLifeCycleCallback);
    onPause();
  }

  @override
  void didPop() {}

  @override
  void didPush() {}
}
