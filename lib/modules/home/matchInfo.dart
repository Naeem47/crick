// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/matchInfo.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';

import 'machTimerView.dart';

class MatchInfoScreen extends StatefulWidget {
  final ShedualData? shedualData;

  const MatchInfoScreen({Key? key, this.shedualData}) : super(key: key);
  @override
  _MatchInfoScreenState createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> {
  bool isLoginProsses = false;
  var sheduallist = <ShedualInfoData>[];
  @override
  void initState() {
    getMatchInfo();
    super.initState();
  }

  Future<Null> getMatchInfo() async {
    return null;
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
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Match Info',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.buildLightTheme().bottomAppBarColor,
                ),
              ),
            ),
            body: ModalProgressHUD(
              inAsyncCall: isLoginProsses,
              color: Colors.transparent,
              progressIndicator: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
              child: Column(
                children: <Widget>[
                  matchSchedulData(),
                  Expanded(
                    child: matchInfoList(),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget matchInfoList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: sheduallist.length,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Match',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].match.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Series',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].seriesName.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Date',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].dateStart.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Time',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].timeStart.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Venue',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].venue.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'umpires',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].umpires.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'referee',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].referee.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'location',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Column(
                        children: <Widget>[
                          Text(
                            sheduallist[index].location.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }

  Widget matchSchedulData() {
    return Container(
      height: 40,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 8, right: 16, left: 16),
            child: Row(
              children: <Widget>[
                Container(
                  width: 22,
                  height: 22,
                  child: new CachedNetworkImage(
                    imageUrl: widget.shedualData!.teamLogo!.a!.logoUrl!,
                    placeholder: (context, url) => Center(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                    fit: BoxFit.contain,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  child: new Text(
                    widget.shedualData!.teamLogo!.a!.shortName!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Text(
                    'vs',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                        color: AllCoustomTheme.getTextThemeColors()),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: new Text(
                    widget.shedualData!.teamLogo!.b!.shortName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 4),
                  child: Container(
                    width: 22,
                    height: 22,
                    child: new CachedNetworkImage(
                      imageUrl: widget.shedualData!.teamLogo!.b!.logoUrl!,
                      placeholder: (context, url) => Center(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                TimerView(
                  dateStart: widget.shedualData!.dateStart,
                  timestart: widget.shedualData!.timeStart,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
