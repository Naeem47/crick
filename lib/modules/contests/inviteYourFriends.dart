// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/modules/home/machTimerView.dart';

class InviteYourFriendsScreen extends StatefulWidget {
  final ShedualData? shedualData;
  final String? inviteCode;

  const InviteYourFriendsScreen({Key? key, this.shedualData, this.inviteCode}) : super(key: key);
  @override
  _InviteYourFriendsScreenState createState() => _InviteYourFriendsScreenState();
}

class _InviteYourFriendsScreenState extends State<InviteYourFriendsScreen> {
  bool isProsses = false;
  var isCopy = false;
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
              body: ModalProgressHUD(
                inAsyncCall: isProsses,
                color: Colors.transparent,
                progressIndicator: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
                child: Stack(
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
                                        child: Container(
                                          width: AppBar().preferredSize.height,
                                          height: AppBar().preferredSize.height,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          'Invite your Friends',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: ConstanceData.SIZE_TITLE22,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
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
                              MatchHadderShare(
                                shedualData: widget.shedualData!,
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: contestsData(),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                      child: Container(
                        decoration: new BoxDecoration(
                          color: AllCoustomTheme.getThemeData().backgroundColor,
                          borderRadius: new BorderRadius.circular(4.0),
                          border: Border.all(
                            color: AllCoustomTheme.getThemeData().primaryColor,
                            width: 1,
                          ),
                          boxShadow: <BoxShadow>[
                            BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: new BorderRadius.circular(4.0),
                            onTap: () async {
                              // Share.share(
                              //     "You've been challenged!\n\nThink you can beat me? Join the contest on Fantasy for the ${widget.shedualData!.teamLogo!.a!.shortName} vs ${widget.shedualData!.teamLogo!.b!.shortName} mach and prove it!.\n\nUse Contest Code ${widget.inviteCode} & join the action Now!");
                            },
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Container(
                                      child: Icon(
                                        Icons.share,
                                        size: 18,
                                        color: AllCoustomTheme.getThemeData().primaryColor,
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'MORE OPTIONS',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: AllCoustomTheme.getThemeData().primaryColor,
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

  Widget contestsData() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 8),
            child: Text(
              'Share the contest code',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: AllCoustomTheme.getTextThemeColors(),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Container(
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getThemeData().backgroundColor,
                borderRadius: new BorderRadius.circular(4.0),
                border: Border.all(
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.5),
                  width: 1.2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: 75,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Text(
                          '${widget.inviteCode}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 200,
                        child: Container(
                          height: 40,
                          child: Container(
                            color: AllCoustomTheme.getThemeData().backgroundColor,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  isCopy = true;
                                });
                                Clipboard.setData(ClipboardData(text: '${widget.inviteCode}'));
                              },
                              child: Center(
                                child: Text(
                                  isCopy ? 'COPIED' : 'COPY CODE',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold,
                                    color: isCopy ? Colors.green : AllCoustomTheme.getThemeData().primaryColor,
                                    fontSize: ConstanceData.SIZE_TITLE12,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MatchHadderShare extends StatelessWidget {
  final ShedualData? shedualData;

  const MatchHadderShare({Key? key, this.shedualData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllCoustomTheme.getThemeData().backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 4),
            child: Row(
              children: <Widget>[
                Container(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: new CachedNetworkImage(
                      imageUrl: shedualData!.teamLogo!.a!.logoUrl!,
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
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 8, bottom: 8),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Text(
                              '${shedualData!.seriesName}',
                              style: TextStyle(fontFamily: 'Poppins', color: Colors.black.withOpacity(0.8), fontSize: ConstanceData.SIZE_TITLE14),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text(
                                    shedualData!.teamLogo!.a!.shortName!,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  'vs',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    shedualData!.teamLogo!.b!.shortName!,
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: TimerView(
                            color: Colors.red,
                            timerType: TimerType.isCreateTeam,
                            fontWeight: true,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            timestart: shedualData!.timeStart!,
                            dateStart: shedualData!.dateStart!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: new CachedNetworkImage(
                      imageUrl: shedualData!.teamLogo!.b!.logoUrl!,
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
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
