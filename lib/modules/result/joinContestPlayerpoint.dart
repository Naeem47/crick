// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';

class JoinContestPlayerPoint extends StatefulWidget {
  @override
  _JoinContestPlayerPointState createState() => _JoinContestPlayerPointState();
}

class _JoinContestPlayerPointState extends State<JoinContestPlayerPoint> {
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
      child: Scaffold(
        backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Player Points",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 24,
              color: Color(0xFFf5f5f5),
              child: Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Players",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                        color: HexColor(
                          '#AAAFBC',
                        ),
                      ),
                    ),
                    Text(
                      'POINTS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 14, left: 14, top: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/8.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Faf du Plessis',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '58.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/11.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Quinton de Kock',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '20.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/115.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Rohit Sharma',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '101.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/117.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Shikhar Dhavan',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '200.3',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/119.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Virat Kohali',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '195.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/123.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'MS Dhoni',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '137.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/131.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Shami',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '452.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/159.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Quinton de Kock',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '136.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/161.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'hashim Amla',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '364.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/163.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Fat du Plessis',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '108.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/167.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Lungi Ngidi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '95.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          children: <Widget>[
                            Container(
                              width: 50,
                              height: 50,
                              child: AvatarImage(
                                isProgressPrimaryColor: true,
                                isCircle: true,
                                isAssets: true,
                                imageUrl: 'assets/cname/175.png',
                                radius: 50,
                                sizeValue: 50,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Dale Steyn',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                  child: Icon(
                                    Icons.done,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Text(
                                '203.0',
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
