import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/widgets/topBarClipare.dart';

class OtpTimerView extends StatefulWidget {
  final void Function(bool isFinish)? timeCallBack;

  const OtpTimerView({Key? key, this.timeCallBack}) : super(key: key);
  @override
  _OtpTimerViewState createState() => _OtpTimerViewState();
}

class _OtpTimerViewState extends State<OtpTimerView> {
  Timer? timer;
  var time = 60;
  var timeTxt = '60';
  var progresbarValue = 0.0;

  setSecondView() {
    timer?.cancel();
    timer = new Timer(new Duration(seconds: 1), () {
      if (time - 1 != -1) {
        time -= 1;
        timeTxt = '$time';
        if (timeTxt.length == 1) {
          timeTxt = '0$timeTxt';
        }
        progresbarValue = 1 - (time / 60);
        setState(() {});
        setSecondView();
        if (time == 0) {
          timer?.cancel();
          widget.timeCallBack!(true);
        }
      }
    });
  }

  @override
  void initState() {
    setSecondView();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16),
            child: new ClipPath(
              clipper: TopBarClipper(bottomLeft: true, bottomRight: true, topLeft: true, topRight: true, radius: 4),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: 4,
                    color: AllCoustomTheme.getTextThemeColors().withOpacity(0.3),
                  ),
                  Container(
                    height: 4,
                    child: LinearProgressIndicator(
                      value: progresbarValue,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Text(
              '0:$timeTxt',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE14,
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
