// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempalteflutter/api/logout.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/controller/controller.dart';
import 'package:tempalteflutter/main.dart';
import 'package:tempalteflutter/modules/color/setColor.dart';
import 'package:tempalteflutter/modules/notification/notificationScreen.dart';
import 'package:tempalteflutter/modules/pymentOptions/pymentOptionsScreen.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/constance/global.dart' as globals;

class AppDrawer extends StatefulWidget {
  final VoidCallback? mySettingClick;
  final VoidCallback? referralClick;

  const AppDrawer({Key? key, this.mySettingClick, this.referralClick}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var appVerison = '1.1.1';
  bool isLoginProsses = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: <Widget>[
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                userDetail(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    myNotification(),
                    Divider(
                      height: 1,
                    ),
                    myBalance(),
                    Divider(
                      height: 1,
                    ),
                    poinSystem(),
                    Divider(
                      height: 1,
                    ),
                    setThemeMode(),
                    Divider(
                      height: 1,
                    ),
                    logoutButton(),
                    Divider(
                      height: 1,
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      'v 1.2',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userDetail() {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 32),
              child: Icon(
                FontAwesomeIcons.chevronLeft,
                size: 22,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            new Text(
                              'Enric',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE22,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              size: 10,
                              color: AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
                            ),
                            new Text(
                              ' ' + 'Texas',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                color: AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    child: AvatarImage(
                      isCircle: true,
                      imageUrl: 'https://www.menshairstylesnow.com/wp-content/uploads/2018/03/Hairstyles-for-Square-Faces-Slicked-Back-Undercut.jpg',
                      radius: 50,
                      sizeValue: 50,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget myNotification() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NotificationScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.solidBell,
                    size: 22,
                    color: AllCoustomTheme.getThemeData().primaryColor,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Notification',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AllCoustomTheme.getThemeData().primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myBalance() {
    return Container(
      height: 54,
      child: Padding(
        padding: EdgeInsets.only(left: 14, right: 14),
        child: new Row(
          children: <Widget>[
            Container(
              child: Icon(
                FontAwesomeIcons.wallet,
                color: AllCoustomTheme.getThemeData().primaryColor,
                size: 22,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Text(
                  'My Balance',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AllCoustomTheme.getThemeData().primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PymentScreen(
                          isOnlyAddMoney: true,
                          isTruePayment: () {},
                        ),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                    decoration: new BoxDecoration(
                      color: AllCoustomTheme.getThemeData().backgroundColor,
                      borderRadius: new BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Colors.green,
                        width: 1,
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(0, 1), blurRadius: 5.0),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'ADD CASH'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.green,
                          fontSize: ConstanceData.SIZE_TITLE12,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget myRewardsOffers() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.gift,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Rewards & Offers',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int light = 1;
  int dark = 2;
  changeColor(BuildContext context, int color) {
    Navigator.pop(context);
    if (color == light) {
      MyApp.setCustomeTheme(context, 6, color: globals.primaryColorString);
    } else {
      MyApp.setCustomeTheme(context, 7, color: globals.primaryColorString);
    }
  }

  openShowPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Select theme mode',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      changeColor(context, light);
                    },
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 32,
                        child: Text(
                          'Light',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      changeColor(context, dark);
                    },
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Theme.of(context).textTheme.headline6!.color,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 32,
                        child: Text(
                          'Dark',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget setThemeMode() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          openShowPopup(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.colorize,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Theme',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myReferrals() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          widget.referralClick!();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.group_add,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Referrals',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myInfoSetting() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () async {
          widget.mySettingClick!();
          await Future.delayed(const Duration(milliseconds: 100));
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.cog,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Info & Settings',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget poinSystem() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SetColorScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.color_lens,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 26,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Set Color',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myProfile() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () async {
          widget.mySettingClick!();
          await Future.delayed(const Duration(milliseconds: 100));
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.solidUserCircle,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Profile',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: ()async {
          print("tap");
        await  Mycontroller().logout(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.powerOff,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
