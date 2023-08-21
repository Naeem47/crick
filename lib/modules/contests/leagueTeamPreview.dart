// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/bloc/teamSelectionBloc.dart';
import 'package:tempalteflutter/bloc/teamTapBloc.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/playersAllPointsResponce.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/squadsResponseData.dart';
import 'package:tempalteflutter/modules/contests/playersPointInfoScreen.dart';
import 'package:tempalteflutter/modules/createTeam/createTeamScreen.dart';
import 'package:tempalteflutter/modules/home/FantasyPointSystemScreen.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';
import 'package:tempalteflutter/models/leagueMemberTeamResponse.dart' as leagueMember;

class LeagueTeamPreviewScreen extends StatefulWidget {
  final VoidCallback? shreCallback;
  final VoidCallback? editeCallBack;
  final leagueMember.Leagues? leagueTeamData;
  final ShedualData? shedualData;

  const LeagueTeamPreviewScreen({
    Key? key,
    this.shreCallback,
    this.leagueTeamData,
    this.editeCallBack,
    this.shedualData,
  }) : super(key: key);
  @override
  _LeagueTeamPreviewScreenState createState() => _LeagueTeamPreviewScreenState();
}

class _LeagueTeamPreviewScreenState extends State<LeagueTeamPreviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final teamSelectionBloc = TeamSelectionBloc(TeamSelectionBlocState.initial());
  final teamTapBloc = TeamTapBloc(TeamTapBlocState.initial());
  var isProsses = false;
  var leagueTeamData = leagueMember.Leagues();
  var isEdite = false;
  var playingList = <Playing11>[];

  @override
  void initState() {
    leagueTeamData = widget.leagueTeamData!;
    getSquadTeamData(false);
    super.initState();
  }

  void getSquadTeamData(bool isRefresh) async {
    if (leagueTeamData != null) {
      setState(() {
        isProsses = true;
      });

      final data = await ApiProvider().getTeamData();
      if (data != null && data.success == 1 && data.playerList!.length > 0) {
        var allPlayerList = data.playerList;

        if (isMachStart()) {}

        allPlayerList!.forEach((p) {
          if (p.title!.toLowerCase() == leagueTeamData.leagueMember![0].captun!.toLowerCase()) {
            p.isSelcted = true;
            p.isC = true;
          }
          if (p.title!.toLowerCase() == leagueTeamData.leagueMember![0].wiseCaptun!.toLowerCase()) {
            p.isVC = true;
            p.isSelcted = true;
          }
          if (isMach(p.title!)) {
            p.isSelcted = true;
          }
        });
        leagueTeamData.playerScore!.forEach((score) {
          allPlayerList.forEach((p) {
            if (p.shortName!.toLowerCase() == score.playerName!.toLowerCase() && p.pid == int.parse(score.playerKey!)) {
              p.point = score.point;
            }
          });
        });
        teamSelectionBloc.cleanList();
        teamSelectionBloc.onListChanges(allPlayerList);
      }
      setState(() {
        isProsses = false;
      });
    }
  }

  bool isMach(String name) {
    bool isMach = false;
    var allplayername = <String>[];
    allplayername.addAll(leagueTeamData.leagueMember![0].bastman!.split(','));
    allplayername.addAll(leagueTeamData.leagueMember![0].allRounder!.split(','));
    allplayername.addAll(leagueTeamData.leagueMember![0].bowler!.split(','));
    allplayername.add(leagueTeamData.leagueMember![0].wicketKeeper!);
    allplayername.forEach((pName) {
      if (pName == name) {
        isMach = true;
        return;
      }
    });
    return isMach;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('#0BA70E'),
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.transparent,
              body: ModalProgressHUD(
                inAsyncCall: isProsses,
                color: Colors.transparent,
                progressIndicator: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.4,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Image.asset(
                          ConstanceData.cricketGround,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Expanded(
                          child: BlocBuilder(
                            bloc: teamSelectionBloc,
                            builder: (context, TeamSelectionBlocState state) {
                              var selectedPlayerList = <Players>[];
                              state.allPlayerList!.forEach((player) {
                                if (player.isSelcted!) {
                                  selectedPlayerList.add(player);
                                }
                              });
                              var wkList = <Players>[];
                              var batList = <Players>[];
                              var arList = <Players>[];
                              var bowlList = <Players>[];

                              selectedPlayerList.forEach((player) {
                                if (player.playingRole!.toLowerCase() == teamSelectionBloc.getTypeText(TabTextType.wk).toLowerCase()) {
                                  wkList.add(player);
                                }
                                if (player.playingRole!.toLowerCase() == teamSelectionBloc.getTypeText(TabTextType.bat).toLowerCase()) {
                                  batList.add(player);
                                }
                                if (player.playingRole!.toLowerCase() == teamSelectionBloc.getTypeText(TabTextType.ar).toLowerCase()) {
                                  arList.add(player);
                                }
                                if (player.playingRole!.toLowerCase() == teamSelectionBloc.getTypeText(TabTextType.bowl).toLowerCase()) {
                                  bowlList.add(player);
                                }
                              });

                              wkList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));
                              batList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));
                              arList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));
                              bowlList.sort((a, b) => b.fantasyPlayerRating!.compareTo(a.fantasyPlayerRating!));

                              return Container(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 8, top: 4),
                                          child: Text(
                                            'WICKET - KEEPER',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                            ),
                                          ),
                                        ),
                                        getTypeList(wkList),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 8, top: 4),
                                          child: Text(
                                            'BATSMEN',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                            ),
                                          ),
                                        ),
                                        getTypeList(batList),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 8, top: 4),
                                          child: Text(
                                            'ALL-ROUNDERS',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                            ),
                                          ),
                                        ),
                                        getTypeList(arList),
                                      ],
                                    ),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(bottom: 8, top: 4),
                                          child: Text(
                                            'BOWLERS',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white,
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                            ),
                                          ),
                                        ),
                                        getTypeList(bowlList),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          color: HexColor('#323232'),
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '${leagueTeamData.leagueMember![0].points}',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ConstanceData.SIZE_TITLE16,
                                        ),
                                      ),
                                      Text(
                                        'TOTAL POINTS',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.6),
                                          fontSize: ConstanceData.SIZE_TITLE10,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
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
                                  width: 50,
                                  padding: EdgeInsets.all(4),
                                  child: Image.asset(ConstanceData.pts),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: Container(
                          child: Row(
                            children: <Widget>[
                              Center(
                                child: Text(
                                  '${leagueTeamData.leagueMember![0].teamName}',
                                  style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        getSquadTeamData(false);
                      },
                      child: Container(
                        width: AppBar().preferredSize.height - 20,
                        height: AppBar().preferredSize.height,
                        child: Icon(Icons.refresh, color: Colors.white),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        widget.shreCallback!();
                      },
                      child: Container(
                        width: AppBar().preferredSize.height - 20,
                        height: AppBar().preferredSize.height,
                        child: Icon(Icons.share, color: Colors.white),
                      ),
                    ),
                  ),
                  !isMachStart()
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              widget.editeCallBack!();
                            },
                            child: Container(
                              width: AppBar().preferredSize.height - 20,
                              height: AppBar().preferredSize.height,
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 0,
                          height: 0,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool isMachStart() {
    var finaledate = DateFormat('yyyy-MM-dd HH:mm:ss').parse(widget.shedualData!.dateStart! + " " + widget.shedualData!.timeStart!);
    if (finaledate.difference(DateTime.now()).inSeconds < 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget getTypeList(List<Players> list) {
    List<Widget> pList = <Widget>[];
    list.forEach((pdata) {
      pList.add(getPlayerView(pdata));
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: pList,
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

  Widget getPlayerView(Players player) {
    final firstname = player.firstName;
    final lastName = player.lastName;

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width > 360 ? 8 : 4), right: (MediaQuery.of(context).size.width > 360 ? 8 : 4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (!isMachStart()) {
                    showInSnackBar('Patience builds Champions! For now, view\nall Player Points after the match starts.');
                  } else {
                    Playing11 pData = new Playing11();
                    playingList.forEach((pnewData) {
                      if (pnewData.playerKey == "${player.pid}") {
                        pData = pnewData;
                      }
                    });
                    if (pData == null) {
                      pData = Playing11();
                      pData.id = '${player.pid}';
                      pData.playerKey = '${player.pid}';
                      pData.points = 0.0;
                      pData.playerName = player.lastName! + ' ' + player.middleName!;
                      pData.rating = '${player.point}';
                      pData.starting11 = '0';
                      pData.run = '0';
                      pData.four = '0';
                      pData.six = '0';
                      pData.sr = '0';
                      pData.fifty = '0';
                      pData.duck = '0';
                      pData.wkts = '0';
                      pData.maidenover = '0';
                      pData.er = '0';
                      pData.playerStatCatch = '0';
                      pData.runoutstumping = '0';
                    }
                    if (pData != null) {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (
                          BuildContext context,
                        ) =>
                            PlayersProfile(
                          pData: pData,
                        ),
                      );
                    }
                  }
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                  height: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                  child: AvatarImage(
                    isAssets: true,
                    imageUrl: 'assets/cname/${player.pid}.png',
                    radius: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                    sizeValue: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 6),
                decoration: new BoxDecoration(
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  borderRadius: new BorderRadius.circular(4.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                  ],
                ),
                child: Center(
                  child: Text(
                    (firstname!.length > 1 ? player.firstName![0].toUpperCase() + '. ' : '') + lastName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: (MediaQuery.of(context).size.width > 360 ? ConstanceData.SIZE_TITLE10 : 8),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    '${player.point}  Pts',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: ConstanceData.SIZE_TITLE10,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: player.isC!
              ? Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: new BorderRadius.circular(32.0),
                    border: new Border.all(
                      width: 1.0,
                      color: AllCoustomTheme.getThemeData().primaryColor,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 2),
                    child: Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE10,
                        ),
                      ),
                    ),
                  ),
                )
              : player.isVC!
                  ? Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: new BorderRadius.circular(32.0),
                        border: new Border.all(
                          width: 1.0,
                          color: AllCoustomTheme.getThemeData().primaryColor,
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Center(
                          child: Text(
                            'vc',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getThemeData().primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
        )
      ],
    );
  }
}
