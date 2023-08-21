// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';

class ContinueButton extends StatelessWidget {
  final void Function()? callBack;
  final String? name;

  const ContinueButton({Key? key, this.callBack, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: new BoxDecoration(
          color: AllCoustomTheme.getThemeData().primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: ()  {
              callBack!();
            },
            child: Padding(
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Center(
                child: Text(
                  (name! != null && name! != '') ? name! : 'Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE18,
                    fontWeight: FontWeight.bold,
                    color: AllCoustomTheme.getThemeData().backgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
