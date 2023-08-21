// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/contestsResponseData.dart';

class ContestCodeScreen extends StatefulWidget {
  @override
  _ContestCodeScreenState createState() => _ContestCodeScreenState();
}

class _ContestCodeScreenState extends State<ContestCodeScreen> {
  var codeController = new TextEditingController();
  var inviteCode = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;

  var categoryList = ContestsLeagueResponseData();

  @override
  void initState() {
    categoryList.contestsCategoryLeagueListData = <ContestsLeagueCategoryListResponseData>[];
    categoryList.teamlist = [];
    categoryList.totalcontest = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AllCoustomTheme.getThemeData().primaryColor,
            AllCoustomTheme.getThemeData().primaryColor,
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
              body: Column(
                children: <Widget>[
                  Container(
                    color: AllCoustomTheme.getThemeData().primaryColor,
                    child: Container(
                      height: AppBar().preferredSize.height,
                      child: Row(
                        children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: AppBar().preferredSize.height,
                                height: AppBar().preferredSize.height,
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Invitation Code',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: AllCoustomTheme.getThemeData().backgroundColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppBar().preferredSize.height,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ModalProgressHUD(
                      inAsyncCall: isProsses,
                      color: Colors.transparent,
                      progressIndicator: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                        },
                        child: contestsData(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showInSnackBar(String value, {bool isGreeen = false}) {
    var snackBar = SnackBar(
      backgroundColor: isGreeen ? Colors.green : Colors.red,
      content: Text(
        value,
        style: TextStyle(
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget contestsData() {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Text(
              'If you have a contest invite code, enter it and join.',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getTextThemeColors(),
                fontSize: ConstanceData.SIZE_TITLE12,
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: new TextField(
              controller: codeController,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
              autofocus: false,
              decoration: new InputDecoration(
                labelText: 'Enter Invitation Code',
                counterStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 0,
                ),
              ),
              onChanged: (txt) {
                inviteCode = txt;
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            child: Container(
              height: 70,
              padding: EdgeInsets.only(left: 50, right: 50, bottom: 30),
              child: Container(
                decoration: new BoxDecoration(
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  borderRadius: new BorderRadius.circular(4.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: new BorderRadius.circular(4.0),
                    onTap: () async {
                      if (inviteCode != '') {
                      } else {
                        showInSnackBar("Invite code can't be empty");
                      }
                    },
                    child: Center(
                      child: Text(
                        'Join Contest',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: ConstanceData.SIZE_TITLE12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
