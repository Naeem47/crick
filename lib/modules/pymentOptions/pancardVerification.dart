// ignore_for_file: unused_field, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';

class PancardVerificationScreen extends StatefulWidget {
  @override
  _PancardVerificationScreenState createState() => _PancardVerificationScreenState();
}

class _PancardVerificationScreenState extends State<PancardVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;
  bool isFirstTime = true;
  bool approved = false;
  File? _image;
  var date = DateTime.now();

  var panNameController = new TextEditingController();
  var panNoController = new TextEditingController();

  @override
  void initState() {
    getPancardData();
    super.initState();
  }

  void getPancardData() async {
    setState(() {
      isProsses = true;
      panNoController.text = 'ABCD123';
      panNameController.text = 'Enric';
      date = DateFormat('dd/MM/yyyy').parse('30/05/1980');
      approved = true;
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
      child: Stack(
        children: <Widget>[
          SafeArea(
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
                    : Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: expandData(),
                                ),
                              )
                            ],
                          ),
                          approved
                              ? Positioned(
                                  bottom: 32,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8, left: 32, right: 32),
                                    child: Text(
                                      "Your Pan Card Verification Has been Approved",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontFamily: 'Poppins', color: Colors.green),
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget expandData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new Container(
              child: new TextField(
                controller: panNoController,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                ),
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Pancard No',
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new Container(
              child: new TextField(
                controller: panNameController,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                ),
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Pancard Name',
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
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
                    Icons.attach_file,
                    color: Colors.white,
                  ),
                  Text(
                    'Upload proof',
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
            height: 80,
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value, {bool isGreen = false}) {
    var snackBar = SnackBar(
      backgroundColor: isGreen ? Colors.green : Colors.red,
      content: new Text(
        value,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ConstanceData.SIZE_TITLE14,
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
