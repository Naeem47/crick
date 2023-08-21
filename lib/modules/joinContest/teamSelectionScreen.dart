// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/squadsResponseData.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/contests/contestsScreen.dart';
import 'package:tempalteflutter/modules/createTeam/createTeamScreen.dart';
import 'package:tempalteflutter/modules/createTeam/teamPreview.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/models/teamResponseData.dart' as teamData;

enum TeamSelectionType { regular, swap }

class TeamSelectionScreen extends StatefulWidget {
  final ShedualData? shedualData;
  final TeamSelectionType? teamSelectionType;
  final String? selectedTeamId;
  final String? leagueId;
  final String? entryfee;

  const TeamSelectionScreen(
      {Key? key, this.shedualData, this.leagueId, this.teamSelectionType = TeamSelectionType.regular, this.selectedTeamId = '', this.entryfee = '0'})
      : super(key: key);
  @override
  _TeamSelectionScreenState createState() => _TeamSelectionScreenState();
}

class _TeamSelectionScreenState extends State<TeamSelectionScreen> {
  List<teamData.TeamData> teamList = <teamData.TeamData>[];
  bool isProsses = false;

  @override
  void initState() {
    getTeamList();
    super.initState();
  }

  Future getTeamList() async {
    setState(() {
      teamList.clear();
      isProsses = true;
    });
    var team = await ApiProvider().getCreatedTeamList('${widget.shedualData!.matchId}');
    if (team.success == 1) {
      if (team.teamData!.length > 0) {
        teamList = team.teamData!;
      }
    }
    if (widget.selectedTeamId != '') {
      teamList.forEach((team) {
        if (team.teamId == widget.selectedTeamId) {
          team.isSelected = true;
        } else {
          team.isSelected = false;
        }
      });
    }
    setState(() {
      isProsses = false;
    });
  }

  Future setSwitchTeam() async {
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
                                          'Join',
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
                              MatchHadder()
                            ],
                          ),
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: dataView(),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CreateTeamScreen(),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                    setState(
                                      () {
                                        getTeamList();
                                      },
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      'CREATE TEAM',
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
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Opacity(
                              opacity: isTeamSelected() ? 1.0 : 0.2,
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.green,
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
                                      if (isTeamSelected()) {
                                        if (widget.teamSelectionType == TeamSelectionType.regular) {
                                          setState(() {
                                            isProsses = true;
                                          });
                                          var userData = await ApiProvider().drawerInfoList();
                                          setState(() {
                                            isProsses = false;
                                          });
                                          if (userData != null && userData.data != null) {
                                            setshowDialog(widget.entryfee!, userData.data!);
                                          }
                                        } else if (widget.teamSelectionType == TeamSelectionType.swap) {
                                          setSwitchTeam();
                                        }
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        widget.teamSelectionType == TeamSelectionType.regular
                                            ? 'JOIN CONTEST'
                                            : widget.teamSelectionType == TeamSelectionType.swap
                                                ? 'SWITCH TEAMS'
                                                : '',
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
                        ],
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

  bool isTeamSelected() {
    bool isSelected = false;
    teamList.forEach((team) {
      if (team.isSelected!) {
        isSelected = true;
        return;
      }
    });
    return isSelected;
  }

  void setshowDialog(String entryFee, UserData userData) {
    var cashBonus = '';
    var unutilizedBalanceWinning = '${(double.tryParse(userData.winingAmount!)! + double.tryParse(userData.balance!)!).toStringAsFixed(2)}';

    if ((double.tryParse(entryFee)! * 0.20) < double.tryParse(userData.cashBonus!)!) {
      cashBonus = '${double.tryParse(entryFee)! * 0.20}';
    } else {
      cashBonus = '${double.tryParse(userData.cashBonus!)}';
    }
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(54),
                child: Container(
                  decoration: BoxDecoration(
                    color: AllCoustomTheme.getThemeData().backgroundColor,
                    borderRadius: new BorderRadius.circular(4.0),
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      'CONFIRMATION',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: ConstanceData.SIZE_TITLE18,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'Unutilized Balance + Winning = ₹$unutilizedBalanceWinning',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getTextThemeColors(),
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(0),
                                child: Icon(Icons.close),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Entry',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '₹$entryFee',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Usable Cash Bonus',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '-₹$cashBonus',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE14,
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
                        padding: const EdgeInsets.only(top: 8, left: 16.0, right: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'To Pay',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '₹${(double.tryParse(entryFee)! - double.tryParse(cashBonus)!).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 8),
                        child: Text(
                          "By joining this contest, you accept FansyApp's T&C.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                            fontSize: ConstanceData.SIZE_TITLE12,
                          ),
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Flexible(
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
                                      Navigator.pop(context);
                                    },
                                    child: Center(
                                      child: Text(
                                        'JOIN CONTEST',
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String getTeamSelectedId() {
    String isSelectedId = '';
    teamList.forEach((team) {
      if (team.isSelected!) {
        isSelectedId = team.teamId!;
        return;
      }
    });
    return isSelectedId;
  }

  Widget dataView() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(4),
          child: Text(
            'CHOOSE TEAMS TO JOIN THIS CONTEST WITH',
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE16),
          ),
        ),
        Divider(
          height: 1,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.only(bottom: 80),
            physics: BouncingScrollPhysics(),
            itemCount: teamList.length,
            itemBuilder: (context, index) {
              return JoinTeamView(
                index: index,
                team: teamList[index],
                shedualData: widget.shedualData!,
                allViewClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamPreviewScreen(
                        shedualData: widget.shedualData,
                        createdTeamData: teamList[index],
                        createTeamPreviewType: CreateTeamPreviewType.created,
                        editCallback: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateTeamScreen(
                                createdTeamData: teamList[index],
                                createTeamtype: CreateTeamType.editTeam,
                              ),
                              fullscreenDialog: true,
                            ),
                          );
                          setState(() {
                            getTeamList();
                          });
                        },
                        shreCallback: () {},
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
                checkBoxClick: () {
                  setState(() {
                    teamList.forEach((team) {
                      if (team.teamId == teamList[index].teamId) {
                        team.isSelected = true;
                      } else {
                        team.isSelected = false;
                      }
                    });
                  });
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class JoinTeamView extends StatefulWidget {
  final VoidCallback? allViewClick;
  final VoidCallback? checkBoxClick;

  final teamData.TeamData? team;
  final int? index;
  final ShedualData? shedualData;
  const JoinTeamView({
    Key? key,
    this.team,
    this.index,
    this.shedualData,
    this.allViewClick,
    this.checkBoxClick,
  }) : super(key: key);
  @override
  _JoinTeamViewState createState() => _JoinTeamViewState();
}

class _JoinTeamViewState extends State<JoinTeamView> {
  var wkcount = 0;
  var batcount = 0;
  var allcount = 0;
  var bowlcount = 0;
  var teamA = 0;
  var teamB = 0;
  List<Players> players = <Players>[];
  Players captun = new Players();
  Players wcaptun = new Players();

  @override
  void initState() {
    batcount = widget.team!.bastman!.split(',').length;
    allcount = widget.team!.allRounder!.split(',').length;
    bowlcount = widget.team!.bowler!.split(',').length;

    super.initState();
    getTeamDeatil();
  }

  Future getTeamDeatil() async {
    SquadsResponseData data = await ApiProvider().getTeamData();
    if (data.success == 1 && data.playerList!.length > 0) {
      players = data.playerList!;

      players.forEach((p) {
        if (p.title == widget.team!.captun) {
          captun = p;
          captun.isC = true;
        }
        if (p.title == widget.team!.wiseCaptun!) {
          wcaptun = p;
          wcaptun.isVC = true;
        }
        if (isMach(p.title!)) {
          if (widget.shedualData!.teamLogo!.a!.shortName!.toLowerCase() == p.teamName!.toLowerCase()) {
            teamA += 1;
          }
          if (widget.shedualData!.teamLogo!.b!.shortName!.toLowerCase() == p.teamName!.toLowerCase()) {
            teamB += 1;
          }
        }
      });
    }
    setState(() {});
  }

  bool isMach(String name) {
    bool isMach = false;
    var allplayername = <String>[];
    allplayername.addAll(widget.team!.bastman!.split(','));
    allplayername.addAll(widget.team!.allRounder!.split(','));
    allplayername.addAll(widget.team!.bowler!.split(','));
    allplayername.add(widget.team!.wicketKeeper!);
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
    return widget.index == 0 && players.length == 0
        ? Container(
            height: 1,
            child: LinearProgressIndicator(),
          )
        : players.length > 0
            ? Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      widget.allViewClick!();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 8, right: 8),
                      child: Column(
                        children: <Widget>[
                          headers1(),
                          headers2(),
                          headers3(),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                  )
                ],
              )
            : SizedBox();
  }

  Widget headers1() {
    return Container(
      padding: EdgeInsets.only(left: 4, top: 4),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              widget.checkBoxClick!();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: widget.team!.isSelected! ? AllCoustomTheme.getThemeData().primaryColor : Colors.transparent,
                  borderRadius: new BorderRadius.circular(32.0),
                  border: new Border.all(
                    width: 2.0,
                    color: widget.team!.isSelected!
                        ? AllCoustomTheme.getThemeData().primaryColor
                        : AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(bottom: 4),
                  child: Center(
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: ConstanceData.SIZE_TITLE16,
                        color: AllCoustomTheme.getThemeData().backgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              '${widget.team!.teamName!}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget headers2() {
    return Container(
      padding: EdgeInsets.only(left: 32, right: 16, top: 10),
      child: Row(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  widget.shedualData!.teamLogo!.a!.shortName!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE14,
                    color: AllCoustomTheme.getTextThemeColors(),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '$teamA',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              children: <Widget>[
                Text(
                  widget.shedualData!.teamLogo!.b!.shortName!,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE14,
                    color: AllCoustomTheme.getTextThemeColors(),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '$teamB',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              child: captun != null ? getPlayerView(captun) : SizedBox(),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          IgnorePointer(
            ignoring: true,
            child: Container(
              padding: EdgeInsets.only(right: 32),
              child: wcaptun != null ? getPlayerView(wcaptun) : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget headers3() {
    return Container(
      padding: EdgeInsets.only(left: 8, right: 8, top: 10),
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Wk  ',
                  style: TextStyle(fontFamily: 'Poppins', color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE14),
                ),
                Text('1'),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'BAT  ',
                  style: TextStyle(fontFamily: 'Poppins', color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE14),
                ),
                Text('$batcount'),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'All  ',
                  style: TextStyle(fontFamily: 'Poppins', color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE14),
                ),
                Text('$allcount'),
              ],
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'BOWL  ',
                  style: TextStyle(fontFamily: 'Poppins', color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE14),
                ),
                Text('$bowlcount'),
              ],
            ),
          ),
        ],
      ),
    );
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
                onTap: () {},
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
