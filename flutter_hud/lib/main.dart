import 'package:flutter/material.dart';
import 'hw_hud.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HWHud _hud;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _hud = HWHud(context);
  }

  void _showToast(String msg,
      {HWHudGravity gravity = HWHudGravity.Center, double delay = 2.0}) {
    _hud.showToast(msg, gravity: gravity, delay: delay);
  }

  void _topBtnClick() {
    _showToast("顶部toast 显示 1 秒", gravity: HWHudGravity.Top, delay: 1.0);
  }

  void _centerBtnClick() {
    _showToast("中间toast 显示 2 秒", gravity: HWHudGravity.Center);
  }

  void _bottomBtnClick() {
    _showToast("底部toast 显示 3 秒", gravity: HWHudGravity.Bottom, delay: 3.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Spacer(),
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                child: Text(
                  "顶部toast",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: _topBtnClick,
              ),
              Spacer(),
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                child: Text(
                  "中间toast",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: _centerBtnClick,
              ),
              Spacer(),
              FlatButton(
                color: Colors.blueGrey,
                textColor: Colors.white,
                child: Text(
                  "底部toast",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: _bottomBtnClick,
              ),
              Spacer(),
            ],
          ),
        ));
  }
}
