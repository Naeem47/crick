import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';

class OtpProgressView extends StatefulWidget {
  @override
  _OtpProgressViewState createState() => _OtpProgressViewState();
}

class _OtpProgressViewState extends State<OtpProgressView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Enter OTP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE14,
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
