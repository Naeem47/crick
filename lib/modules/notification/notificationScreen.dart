// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/notification.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationData> notificationList = <NotificationData>[];
  bool isProsses = false;
  @override
  void initState() {
    getNotifictionData();
    super.initState();
  }

  void getNotifictionData() async {
    setState(() {
      isProsses = true;
    });
    var notificationData = await ApiProvider().notificationApiDataList();

    notificationList = notificationData.notificationData!;

    setState(() {
      isProsses = false;
    });
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
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        color: AllCoustomTheme.getThemeData().primaryColor,
                        child: Column(
                          children: <Widget>[
                            Container(
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
                                        'Notification',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
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
                          ],
                        ),
                      ),
                      Expanded(
                        child: ModalProgressHUD(
                          inAsyncCall: isProsses,
                          color: Colors.transparent,
                          progressIndicator: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: notificationList.length,
                            itemBuilder: (context, index) {
                              return listItems(notificationList[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listItems(NotificationData data) {
    return Container(
      constraints: BoxConstraints(minHeight: 60),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 55,
                  width: 55,
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 36,
                    height: 40,
                    padding: EdgeInsets.only(top: 4),
                    child: Image.asset(
                      ConstanceData.notificationCup,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          data.notificationDetail!,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE14,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 4, top: 4),
                        child: Text(
                          DateFormat('dd MMM, yyyy').format(DateFormat('dd/MM/yyyy').parse(data.date!)),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE14,
                          ),
                        ),
                      )
                    ],
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
    );
  }
}
