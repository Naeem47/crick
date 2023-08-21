// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/login/facebookGoogle.dart';
import 'package:tempalteflutter/modules/login/sliderView.dart';

var loginUserData = UserData();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isLoginType = '';
  var email = '';
  var name = '';
  var id = '';
  var imageUrl = '';

  var isLoginProsses = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AllCoustomTheme.getThemeData().primaryColor,
                AllCoustomTheme.getThemeData().primaryColor,
                AllCoustomTheme.getThemeData().backgroundColor,
                AllCoustomTheme.getThemeData().backgroundColor,
              ],
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ModalProgressHUD(
              inAsyncCall: isLoginProsses,
              child: Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            color: AllCoustomTheme.getThemeData().primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 50,
                                ),
                                Image.asset(
                                  "assets/stump.png",
                                  height: 70,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Cricket Fantasy',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                Flexible(
                                  child: SliderView(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FacebookGoogleView(),
                        Container(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Terms of Service ',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE12,
                                    color: AllCoustomTheme.getThemeData().primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE12,
                                    color: AllCoustomTheme.getThemeData().primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
