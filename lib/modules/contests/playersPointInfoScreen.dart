// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/playersAllPointsResponce.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

class PlayersPointInfoScreen extends StatefulWidget {
  final ShedualData? shedualData;

  const PlayersPointInfoScreen({
    Key? key,
    this.shedualData,
  }) : super(key: key);
  @override
  _PlayersPointInfoScreenState createState() => _PlayersPointInfoScreenState();
}

class _PlayersPointInfoScreenState extends State<PlayersPointInfoScreen> {
  bool isProsses = false;
  bool assending = false;

  List<Playing11> playingList = [];

  @override
  void initState() {
    super.initState();
  }

  void setAssending() {
    if (assending) {
      assending = !assending;
      playingList.sort((a, b) => a.points!.compareTo(b.points!));
    } else {
      assending = !assending;
      playingList.sort((a, b) => b.points!.compareTo(a.points!));
    }
    setState(() {});
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
                                          'Player Points',
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
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: listData(),
                          ),
                        )
                      ],
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

  Widget listData() {
    return Column(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
          height: 24,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 74),
                child: Center(
                  child: Text(
                    'PLAYERS',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE12,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  setAssending();
                },
                child: Container(
                  width: 70,
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text(
                          'POINTS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE12,
                          ),
                        ),
                        Icon(
                          assending ? Icons.arrow_upward : Icons.arrow_downward,
                          size: 20,
                          color: AllCoustomTheme.getThemeData().primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: playingList.length,
            itemBuilder: (context, index) {
              return PlayersPointInfoView(
                  isMach: true,
                  pData: playingList[index],
                  clickAll: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (
                        BuildContext context,
                      ) =>
                          PlayersProfile(
                        pData: playingList[index],
                      ),
                    );
                  });
            },
          ),
        ),
        Container(
          color: Colors.black.withOpacity(0.8),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 8),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                    child: Icon(
                      Icons.done,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Your Players',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AllCoustomTheme.getThemeData().backgroundColor,
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class PlayersPointInfoView extends StatelessWidget {
  final Playing11? pData;
  final bool? isMach;
  final VoidCallback? clickAll;

  const PlayersPointInfoView({Key? key, this.pData, this.isMach, this.clickAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        clickAll!();
      },
      child: Container(
        height: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: AvatarImage(
                        isCircle: true,
                        isAssets: true,
                        imageUrl: 'assets/cname/${pData!.playerKey}.png',
                        radius: 50,
                        sizeValue: 50,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            child: Text(
                              '${pData!.playerName!}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE12,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 4),
                            child: Opacity(
                              opacity: isMach! ? 1.0 : 0.3,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                                child: Icon(
                                  Icons.done,
                                  size: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 16),
                    width: 60,
                    child: Text(
                      '${pData!.points}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE14,
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
  }
}

class PlayersProfile extends StatefulWidget {
  final Playing11? pData;

  const PlayersProfile({Key? key, this.pData}) : super(key: key);
  @override
  _PlayersProfileState createState() => _PlayersProfileState();
}

class _PlayersProfileState extends State<PlayersProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 8),
            child: Row(
              children: <Widget>[
                Container(
                    height: 80,
                    width: 80,
                    child: Image.asset(
                      'assets/cname/${widget.pData!.playerKey}.png',
                    )),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            widget.pData!.playerName!,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              fontWeight: FontWeight.bold,
                              fontSize: ConstanceData.SIZE_TITLE20,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'POINTS',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.5),
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      '${widget.pData!.points}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 32,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'CREDITS',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.5),
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      '${widget.pData!.rating}',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
            height: 24,
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Center(
                    child: Text(
                      'EVENT',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE12,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  width: 70,
                  child: Center(
                    child: Text(
                      'POINTS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Starting 11',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.starting11}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Runs',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.run}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "4's",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.four}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "6's",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.six}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "S/R",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.sr}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "50",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.fifty}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Duck",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.duck}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Wkts",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.wkts}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Maiden Over",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.maidenover}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "E/R",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.er}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Catch",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.playerStatCatch}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Run Out/Stumping",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.runoutstumping}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Total",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.pData!.points}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.8),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
            ],
          )),
        ],
      ),
    );
  }

  bool isMach() {
    bool ismach = false;

    return ismach;
  }

  Widget getTListView() {
    var widgetList = <Widget>[];

    return Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: widgetList,
      ),
    );
  }
}
