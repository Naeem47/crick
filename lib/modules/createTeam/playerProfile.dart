// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/playerMachPointResponse.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/squadsResponseData.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

import 'createTeamScreen.dart';

class PlayerProfileScreen extends StatefulWidget {
  final Players? player;
  final bool? isChoose;
  final ShedualData? shedualData;

  const PlayerProfileScreen({Key? key, this.player, this.isChoose = false, this.shedualData}) : super(key: key);
  @override
  _PlayerProfileScreenState createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  var isProsses = false;
  List<PlayerData> playerMachImfoList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getPlayerMachImfoList();
    super.initState();
  }

  void getPlayerMachImfoList() async {
    setState(() {
      isProsses = true;
    });

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
              key: _scaffoldKey,
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Container(
                                          child: Text(
                                            widget.player!.firstName! + ' ' + widget.player!.lastName!,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ConstanceData.SIZE_TITLE18,
                                            ),
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
                              Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(left: 24),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        child: AvatarImage(
                                          isCircle: true,
                                          isAssets: true,
                                          imageUrl: 'assets/cname/${widget.player!.pid}.png',
                                          radius: 100,
                                          sizeValue: 100,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 40),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width >= 360 ? 75 : 65,
                                        padding: EdgeInsets.all(4),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                'Credits',
                                                textAlign: TextAlign.end,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white54,
                                                  fontSize: ConstanceData.SIZE_TITLE14,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 8),
                                              child: Text(
                                                '${widget.player!.fantasyPlayerRating}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                                  fontSize: ConstanceData.SIZE_TITLE22,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width >= 360 ? 75 : 65,
                                        padding: EdgeInsets.all(4),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                'Total points',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white54,
                                                  fontSize: ConstanceData.SIZE_TITLE14,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(top: 8),
                                              child: Text(
                                                '${widget.player!.point}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                                  fontSize: ConstanceData.SIZE_TITLE22,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: new Border.all(
                                      width: 1.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 50,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        'Bats',
                                                        textAlign: TextAlign.end,
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white54,
                                                          fontSize: ConstanceData.SIZE_TITLE12,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        '${widget.player!.battingStyle}',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.bold,
                                                          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                                          fontSize: ConstanceData.SIZE_TITLE14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        'Bowls',
                                                        textAlign: TextAlign.end,
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white54,
                                                          fontSize: ConstanceData.SIZE_TITLE12,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        '${widget.player!.bowlingStyle}',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.bold,
                                                          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                                          fontSize: ConstanceData.SIZE_TITLE14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        height: 50,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        'Nationality',
                                                        textAlign: TextAlign.end,
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white54,
                                                          fontSize: ConstanceData.SIZE_TITLE12,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        '${widget.player!.nationality}',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.bold,
                                                          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                                          fontSize: ConstanceData.SIZE_TITLE14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 1,
                                              color: Colors.white,
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        'Birthday',
                                                        textAlign: TextAlign.end,
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white54,
                                                          fontSize: ConstanceData.SIZE_TITLE12,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(left: 8),
                                                      child: Text(
                                                        '${widget.player!.birthdate}',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight: FontWeight.bold,
                                                          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                                                          fontSize: ConstanceData.SIZE_TITLE14,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'MATCHWISE FANTASY STATS',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          color: AllCoustomTheme.getTextThemeColors().withOpacity(0.3),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'MATCH',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE10,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 16),
                                child: Text(
                                  'POINTS',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE10,
                                  ),
                                ),
                              )
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
                            child: playerMachImfoList == null
                                ? Container(
                                    height: 1,
                                    child: LinearProgressIndicator(),
                                  )
                                : playerMachImfoList.length > 0
                                    ? ListView.builder(
                                        padding: EdgeInsets.only(bottom: 80),
                                        physics: BouncingScrollPhysics(),
                                        itemCount: playerMachImfoList.length,
                                        itemBuilder: (context, index) => PlayerslistUI(
                                          playerMachImfoList: playerMachImfoList[index],
                                        ),
                                      )
                                    : Container(
                                        padding: EdgeInsets.only(top: 50),
                                        child: Text(
                                          'No match infomation are available!',
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                              color: AllCoustomTheme.getTextThemeColors()),
                                        ),
                                      ),
                          ),
                        )
                      ],
                    ),
                  ),
                  widget.isChoose! ? addToTeam() : SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value) {
    var snackBar = SnackBar(
      backgroundColor: Colors.red,
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

  bool isValidMiniMach(TabTextType t, List<TabTextType> tlist) {
    bool isMach = false;
    tlist.forEach((type) {
      if (t == type) {
        isMach = true;
        return;
      }
    });
    return isMach;
  }

  Widget addToTeam() {
    var isDisabled = false;
    final validCredites = teamSelectionBloc.getTotalSelctedPlayerRating();
    final is7Player = teamSelectionBloc.getMax7PlayesCount(widget.player!);
    final isValid = teamSelectionBloc.isDisabled(widget.player!.pid!);
    final is11Player = teamSelectionBloc.getSelectedPlayerCount();
    final isValidMini = teamSelectionBloc.validMinErrorRequirement();

    if ((100.0 - validCredites) < widget.player!.fantasyPlayerRating! && !widget.player!.isSelcted!) {
      isDisabled = true;
    }
    if (is7Player == 7 && !widget.player!.isSelcted!) {
      isDisabled = true;
    }
    if (is11Player == 11 && !widget.player!.isSelcted!) {
      isDisabled = true;
    }
    if (isValid && !widget.player!.isSelcted!) {
      isDisabled = true;
    }
    if (isValidMini != null && !widget.player!.isSelcted!) {
      if (isValidMini != teamSelectionBloc.getTypeTextEnum(widget.player!.playingRole!)) {
        if (!isValidMiniMach(teamSelectionBloc.getTypeTextEnum(widget.player!.playingRole!)!, teamSelectionBloc.validMinErrorRequirementList())) {
          isDisabled = true;
        }
      }
    }
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(4.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: new BorderRadius.circular(4.0),
                  onTap: () async {
                    if (widget.player!.isSelcted!) {
                    } else {}
                    if (!isDisabled) {
                      teamSelectionBloc.setPlaySelect(widget.player!.pid!);
                      Navigator.pop(context);
                    } else {
                      bool isatlest = false;
                      bool isMinimum = false;
                      if (isValidMini != null && !widget.player!.isSelcted!) {
                        if (isValidMini != teamSelectionBloc.getTypeTextEnum(widget.player!.playingRole!)) {
                          if (!isValidMiniMach(
                              teamSelectionBloc.getTypeTextEnum(widget.player!.playingRole!)!, teamSelectionBloc.validMinErrorRequirementList())) {
                            isatlest = true;
                          }
                        }
                      }
                      if (isValid && !widget.player!.isSelcted!) {
                        isMinimum = true;
                      }
                      if (isatlest && isMinimum) {
                        teamTapBloc.setType(AnimationType.atLeast);
                      } else {
                        if (isValidMini != null && !widget.player!.isSelcted!) {
                          teamTapBloc.setType(AnimationType.atLeast);
                        }
                        if (isValid && !widget.player!.isSelcted!) {
                          teamTapBloc.setType(AnimationType.isMinimum);
                        }
                      }
                      if (is7Player == 7 && !widget.player!.isSelcted!) {
                        teamTapBloc.setType(AnimationType.isSeven);
                      }
                      if ((100.0 - validCredites) < widget.player!.fantasyPlayerRating! && !widget.player!.isSelcted!) {
                        teamTapBloc.setType(AnimationType.isCredits);
                      }
                      if (is11Player == 11 && !widget.player!.isSelcted!) {
                        teamTapBloc.setType(AnimationType.isFull);
                      }
                      final text = getValideTxt(getTypeTextEnum(widget.player!.playingRole!)!);
                      showInSnackBar(text);
                    }
                  },
                  child: Center(
                    child: Text(
                      widget.player!.isSelcted! ? 'REMOVE FROME MY TEAM' : 'ADD TO MY TEAM',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        color: AllCoustomTheme.getThemeData().primaryColor,
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
    );
  }

  TabTextType? getTypeTextEnum(String tabText) {
    if (tabText.toLowerCase() == "WK".toLowerCase()) {
      return TabTextType.wk;
    } else {
      if (tabText.toLowerCase() == "BAT".toLowerCase()) {
        return TabTextType.bat;
      } else {
        if (tabText.toLowerCase() == "ALL".toLowerCase()) {
          return TabTextType.ar;
        } else {
          if (tabText.toLowerCase() == "BOWL".toLowerCase()) {
            return TabTextType.bowl;
          } else {
            return null;
          }
        }
      }
    }
  }

  String getValideTxt(TabTextType type) {
    var animationType = teamTapBloc.animationType;
    var txt = '';
    if (animationType == AnimationType.isRegular) {
      if (TabTextType.wk == type) {
        txt = 'Pick 1 Wicket-Keeper';
      } else if (TabTextType.bat == type) {
        txt = 'Pick 3 - 5 Batsmen';
      } else if (TabTextType.ar == type) {
        txt = 'Pick 1 - 3 All-Rounders';
      } else if (TabTextType.bowl == type) {
        txt = 'Pick 3 - 5 Bowlers';
      }
    } else if (animationType == AnimationType.isMinimum) {
      if (TabTextType.wk == type) {
        txt = 'You can pick only 1 Wicket-Keeper.';
      } else if (TabTextType.bat == type) {
        txt = 'You can pick only 5 Batsmen.';
      } else if (TabTextType.ar == type) {
        txt = 'You can pick only 3 All-Rounders.';
      } else if (TabTextType.bowl == type) {
        txt = 'You can pick only 5 Bowlers.';
      }
    } else if (animationType == AnimationType.isFull) {
      txt = '11 players selected, tap continue.';
    } else if (animationType == AnimationType.isSeven) {
      txt = 'You can pick only 7 from each team.';
    } else if (animationType == AnimationType.isCredits) {
      txt = 'Not enough creadits to pick this player.';
    } else if (animationType == AnimationType.atLeast) {
      final isValidMini = teamSelectionBloc.validMinErrorRequirement();
      if (isValidMini != null) {
        if (TabTextType.wk == isValidMini) {
          txt = 'You must pick at least 1 Wicket-Keeper.';
        } else if (TabTextType.bat == isValidMini) {
          txt = 'You must pick at least 3 Batsmen.';
        } else if (TabTextType.ar == isValidMini) {
          txt = 'You must pick at least 1 All-Rounders.';
        } else if (TabTextType.bowl == isValidMini) {
          txt = 'You must pick at least 3 Bowlers.';
        }
      }
    }
    return txt;
  }
}

class PlayerslistUI extends StatelessWidget {
  final PlayerData? playerMachImfoList;

  const PlayerslistUI({Key? key, this.playerMachImfoList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: AllCoustomTheme.getThemeData().backgroundColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 22,
                                width: 22,
                                child: CachedNetworkImage(
                                  imageUrl: '${playerMachImfoList!.teamLogo!.a!.logoUrl}',
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
                              Text(
                                '  ${playerMachImfoList!.teamLogo!.a!.name}  vs ${playerMachImfoList!.teamLogo!.b!.name}  ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE12,
                                ),
                              ),
                              Container(
                                height: 22,
                                width: 22,
                                child: CachedNetworkImage(
                                  imageUrl: '${playerMachImfoList!.teamLogo!.b!.logoUrl}',
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
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            '${playerMachImfoList!.playedDate}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getTextThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE10,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Center(
                    child: Text(
                      '${playerMachImfoList!.playerPoint}',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                        fontSize: ConstanceData.SIZE_TITLE12,
                      ),
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
    );
  }
}
