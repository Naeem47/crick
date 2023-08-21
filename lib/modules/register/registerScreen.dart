// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/logout.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/register/registerView.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var isLoginProsses = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await LogOut().backSplashScreen(context),
      child: Stack(
        children: <Widget>[
          Container(
            color: AllCoustomTheme.getThemeData().backgroundColor,
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: ModalProgressHUD(
                inAsyncCall: isLoginProsses,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 24),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 14),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 40,
                                      color: AllCoustomTheme.getThemeData().primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              RegisterView(
                                callBack: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
