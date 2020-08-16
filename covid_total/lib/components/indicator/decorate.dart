import 'package:flutter/material.dart';

/// Information about a piece of animation (e.g., color).
@immutable
class DecorateData {
  final Color color;

  const DecorateData({this.color = Colors.white});

  @override
  bool operator ==(other) {
    if (other.runtimeType != runtimeType) return false;
    final DecorateData typedOther = other;
    return this.color == typedOther.color;
  }

  @override
  int get hashCode => hashValues(color, color);

  @override
  String toString() {
    return 'DecorateData{color:}';
  }
}

/// Establishes a subtree in which decorate queries resolve to the given data.
class DecorateContext extends InheritedWidget {
  final DecorateData decorateData;

  DecorateContext({
    Key key,
    @required this.decorateData,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(DecorateContext oldWidget) =>
      oldWidget.decorateData == this.decorateData;

  static DecorateContext of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(DecorateContext);
  }
}
enum Indicator {
  ballPulse,
  ballGridPulse,
  ballClipRotate,
  squareSpin,
  ballClipRotatePulse,
  ballClipRotateMultiple,
  ballPulseRise,
  ballRotate,
  cubeTransition,
  ballZigZag,
  ballZigZagDeflect,
  ballTrianglePath,
  ballScale,
  lineScale,
  lineScaleParty,
  ballScaleMultiple,
  ballPulseSync,
  ballBeat,
  lineScalePulseOut,
  lineScalePulseOutRapid,
  ballScaleRipple,
  ballScaleRippleMultiple,
  ballSpinFadeLoader,
  lineSpinFadeLoader,
  triangleSkewSpin,
  pacman,
  ballGridBeat,
  semiCircleSpin,
  ballRotateChase,
  orbit,
  audioEqualizer,
  circleStrokeSpin,
}