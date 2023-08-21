// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/bankinfoResponce.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;
  bool isFirstTime = true;
  bool isRejected = false;
  bool approved = false;
  var pancardDetail = PancardDetail();

  var noController = new TextEditingController();
  var emailController = new TextEditingController();

  @override
  void initState() {
    getPancardData();
    super.initState();
  }

  void getPancardData() async {
    setState(() {
      isProsses = true;
      noController.text = '9876543210';
      emailController.text = 'enric@gmail.com';
    });

    setState(() {
      isFirstTime = false;
      isProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
          body: ModalProgressHUD(
            inAsyncCall: isProsses,
            color: Colors.transparent,
            progressIndicator: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
            child: isFirstTime
                ? SizedBox()
                : Column(
                    children: [
                      Expanded(
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: <Widget>[
                            isRejected
                                ? Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 8, left: 32, right: 32),
                                      child: Text(
                                        isRejected ? 'Your Pan Card Verification Has been Rejected' : '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontFamily: 'Poppins', color: Colors.green),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                            Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: expandData(),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              child: Text(
                                'Your E-mail and Mobile Number are Verified.',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontFamily: 'Poppins', color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 38, left: 16, right: 16, bottom: 8),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: new BoxDecoration(
                            color: AllCoustomTheme.getThemeData().primaryColor,
                            borderRadius: new BorderRadius.circular(4.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              Text(
                                'Verify',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: AllCoustomTheme.getThemeData().backgroundColor,
                                  fontSize: ConstanceData.SIZE_TITLE16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget expandData() {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: new Container(
                child: new TextField(
                  controller: noController,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE16,
                    color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                  ),
                  autofocus: false,
                  decoration: new InputDecoration(
                    labelText: 'Mobile No',
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onChanged: (value) {
                    pancardDetail.accountNo = value;
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: new Container(
                child: new TextField(
                  controller: emailController,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE16,
                    color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                  ),
                  autofocus: false,
                  decoration: new InputDecoration(
                    labelText: 'Emial',
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  onChanged: (value) {
                    pancardDetail.accountPhoto = value;
                  },
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }
}
