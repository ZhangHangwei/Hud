import 'package:flutter/material.dart';

enum HWHudGravity { Top, Center, Bottom }

class HWHud {
  OverlayEntry _overlayEntry;
  bool _isShowing = false;
  DateTime _startTime;

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
    _startTime = DateTime.now();

    // 获取OverlayState
    final overlayState = Overlay.of(_context);
    _isShowing = true;

    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
          builder: (BuildContext context) => Positioned(
              top: _toastTopMargin(),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80),
                  child: AnimatedOpacity(
                    opacity: _isShowing ? 1.0 : 0.0,
                    duration: _isShowing
                        ? Duration(milliseconds: 100)
                        : Duration(milliseconds: 400),
                    child: _buildToastWidget(msg),
                  ),
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
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Text(
          msg,
          style: TextStyle(fontSize: 14.0, color: Colors.white),
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
