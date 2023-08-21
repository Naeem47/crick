// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/bloc/teamSelectionBloc.dart';
import 'package:tempalteflutter/bloc/teamTapBloc.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/squadsResponseData.dart';
import 'package:tempalteflutter/modules/createTeam/playerProfile.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/models/teamResponseData.dart' as team;
import 'createTeamScreen.dart';

enum CreateTeamPreviewType { regular, created }

class TeamPreviewScreen extends StatefulWidget {
  final CreateTeamPreviewType? createTeamPreviewType;
  final VoidCallback? editCallback;
  final VoidCallback? shreCallback;
  final team.TeamData? createdTeamData;
  final ShedualData? shedualData;
  const TeamPreviewScreen(
      {Key? key,
      this.createTeamPreviewType = CreateTeamPreviewType.regular,
      this.createdTeamData,
      this.editCallback,
      this.shreCallback,
      this.shedualData})
      : super(key: key);
  @override
  _TeamPreviewScreenState createState() => _TeamPreviewScreenState();
}

class _TeamPreviewScreenState extends State<TeamPreviewScreen> {
  var isProsses = false;
  @override
  void initState() {
    getSquadTeamData();
    super.initState();
  }

  void getSquadTeamData() async {
    if (widget.createTeamPreviewType == CreateTeamPreviewType.created && widget.createdTeamData != null) {
      teamSelectionBloc = TeamSelectionBloc(TeamSelectionBlocState.initial());
      teamTapBloc = TeamTapBloc(TeamTapBlocState.initial());
      setState(() {
        isProsses = true;
      });
      final data = await ApiProvider().getTeamData();
      if (data != null && data.success == 1 && data.playerList!.length > 0) {
        var allPlayerList = data.playerList;

        allPlayerList!.forEach((p) {
          if (p.title!.toLowerCase() == widget.createdTeamData!.captun!.toLowerCase()) {
            p.isSelcted = true;
            p.isC = true;
          }
          if (p.title!.toLowerCase() == widget.createdTeamData!.wiseCaptun!.toLowerCase()) {
            p.isVC = true;
            p.isSelcted = true;
          }
          if (isMach(p.title!)) {
            p.isSelcted = true;
          }
        });
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
    allplayername.addAll(widget.createdTeamData!.bastman!.split(','));
    allplayername.addAll(widget.createdTeamData!.allRounder!.split(','));
    allplayername.addAll(widget.createdTeamData!.bowler!.split(','));
    allplayername.add(widget.createdTeamData!.wicketKeeper!);
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
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
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
                    BlocBuilder(
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
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        );
                      },
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
                    child: Container(),
                  ),
                  widget.createTeamPreviewType == CreateTeamPreviewType.created
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              widget.editCallback!();
                            },
                            child: Container(
                              width: AppBar().preferredSize.height - 20,
                              height: AppBar().preferredSize.height,
                              child: Icon(Icons.edit, color: Colors.white),
                            ),
                          ),
                        )
                      : SizedBox(),
                  widget.createTeamPreviewType == CreateTeamPreviewType.created
                      ? Material(
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
                        )
                      : SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerProfileScreen(
                        shedualData: widget.shedualData,
                        player: player,
                        isChoose: false,
                      ),
                      fullscreenDialog: true,
                    ),
                  );
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
                    '${player.fantasyPlayerRating}  Cr',
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
