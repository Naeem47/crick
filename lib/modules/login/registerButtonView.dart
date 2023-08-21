import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';

class RegisterButtonView extends StatefulWidget {
  final void Function()? registerCallBack;

  const RegisterButtonView({Key? key, this.registerCallBack}) : super(key: key);
  @override
  _RegisterButtonViewState createState() => _RegisterButtonViewState();
}

class _RegisterButtonViewState extends State<RegisterButtonView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.transparent,
        borderRadius: new BorderRadius.circular(50.0),
        border: Border.all(
          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: new BorderRadius.circular(50.0),
          onTap: () {
            widget.registerCallBack!();
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 75, right: 75, bottom: 10),
            child: Text(
              'Register',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE20,
                fontStyle: FontStyle.italic,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
