import 'package:flutter/material.dart';

enum HWHudGravity { Top, Center, Bottom }

class HWHud {
  OverlayEntry _overlayEntry;
  bool _isShowing = false;

  // 默认底部
  HWHudGravity _hudGravity = HWHudGravity.Bottom;
  BuildContext _context;

  HWHud(BuildContext context) {
    _context = context;
  }

  void showToast(String msg,
      {HWHudGravity gravity = HWHudGravity.Bottom, double delay = 2.0}) {
    if (_isShowing || msg.isEmpty || _context == null) {
      return;
    }

    if (delay < 0) {
      delay = 2.0;
    }
    int delayMilliseconds = (delay * 1000).floor();

    _hudGravity = gravity;

    // 获取OverlayState
    final overlayState = Overlay.of(_context);
    _isShowing = true;

    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
              top: _toastTopMargin(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 500),
                  child: _buildToastWidget(msg),
                ),
              )));
    }
    // 重绘
    else {
      _overlayEntry.markNeedsBuild();
    }
    overlayState.insert(_overlayEntry);

    Future.delayed(Duration(milliseconds: delayMilliseconds), () {
      _isShowing = false;
      _overlayEntry.remove();
      _overlayEntry = null;
    });
  }

  Widget _buildToastWidget(String msg) {
    return Center(
        child: Card(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          msg,
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    ));
  }

  // toast 的位置
  double _toastTopMargin() {
    final height = MediaQuery.of(_context).size.height;
    switch (_hudGravity) {
      case HWHudGravity.Top:
        return height / 4;
      case HWHudGravity.Center:
        return height / 2;
      default:
        return height / 4 * 3;
    }
  }
}
