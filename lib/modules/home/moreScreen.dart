// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/contests/contestCodeScreen.dart';
import 'package:tempalteflutter/modules/home/FantasyPointSystemScreen.dart';
import 'package:tempalteflutter/modules/pymentOptions/accountVerification.dart';

import 'homeScreen.dart';

class MoreScreen extends StatefulWidget {
  final VoidCallback? inviteFriendClick;

  const MoreScreen({Key? key, this.inviteFriendClick}) : super(key: key);
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  double _appBarHeight = 100.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  bool isVerifiled = false;
  bool isProsses = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var emialApproved = false;
    var pancardApproved = false;
    var bankApproved = false;

    setState(() {
      isProsses = true;
    });
    var email = await ApiProvider().getEmailResponce();

    if ('Your E-mail and Mobile Number are Verified.' == email.message) {
      emialApproved = true;
    }

    var pancard = await ApiProvider().getPanCardResponce();
    if (pancard.success == '1') {
      if (pancard.pancardDetail != null) {
        if (pancard.pancardDetail!.length > 0) {
          if (pancard.pancardDetail![0].pancardNo != '') {
            if ('Your Pan Card Verification Has been Approved' == pancard.message) {
              pancardApproved = true;
            }
          }
        }
      }
    }

    var bankData = await ApiProvider().bankListApprovedResponseData();
    if (bankData.success == 1) {
      if (bankData.accountDetail != null && bankData.accountDetail!.length > 0) {
        bankApproved = true;
      }
    }

    if (emialApproved && pancardApproved && bankApproved) {
      isVerifiled = true;
    }
    setState(() {
      isProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().primaryColor,
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: Container(),
                      expandedHeight: _appBarHeight,
                      pinned: _appBarBehavior == AppBarBehavior.pinned,
                      floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
                      snap: _appBarBehavior == AppBarBehavior.snapping,
                      backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                      primary: true,
                      centerTitle: false,
                      flexibleSpace: sliverText(),
                      elevation: 1,
                    ),
                    SliverList(
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) => listItems(index),
                        childCount: 9,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Setting',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget listItems(int index) {
    if (index == 0) {
      return InkWell(
        onTap: () {
          widget.inviteFriendClick!();
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Invite Friends",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 1) {
      return InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContestCodeScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Invite code",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 3) {
      return InkWell(
        onTap: () {},
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Points System",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 2) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AccountVerificationScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "KYC",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      decoration: new BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: new BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8, top: 8.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            !isProsses
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(left: 4, right: 4),
                                        child: Text(
                                          isVerifiled ? "Verified" : "Not verified",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: ConstanceData.SIZE_TITLE14,
                                            fontWeight: FontWeight.bold,
                                            color: isVerifiled ? Colors.green : Colors.red,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: isVerifiled ? 0 : 2),
                                        child: Icon(
                                          isVerifiled ? Icons.done : Icons.close,
                                          size: 18,
                                          color: isVerifiled ? Colors.green : Colors.red,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 4) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FantasyPointSystemScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "How to Play",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 6) {
      return InkWell(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "About Us",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 7) {
      return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => LegalityScreen(),
          //     fullscreenDialog: true,
          //   ),
          // );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Legality",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 8) {
      return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => TermsAndConditionsScreen(),
          //     fullscreenDialog: true,
          //   ),
          // );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Container(
                      child: Container(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          size: ConstanceData.SIZE_TITLE22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
