// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';

class CreateTeamButton extends StatelessWidget {
  final VoidCallback? createTeam;
  final VoidCallback? myTeams;
  final VoidCallback? joindContests;
  final ShedualData? shedualData;
  final int? teamList;
  final int? contestJoinedList;

  const CreateTeamButton({Key? key, this.createTeam, this.shedualData, this.teamList, this.myTeams, this.joindContests, this.contestJoinedList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          teamList == null || teamList == 0
              ? Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                  child: Opacity(
                    opacity: teamList == null ? 0.2 : 1.0,
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
                          onTap: () {
                            createTeam!();
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
                )
              : Container(
                  color: AllCoustomTheme.getThemeData().backgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                        height: 1,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  myTeams!();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 8, top: 2, bottom: 4, right: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.circular(8.0),
                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                          ),
                                          child: Text(
                                            '$teamList',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          child: Text(
                                            'MY TEAMS',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
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
                          Container(
                            width: 1,
                            height: 40,
                            color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                          ),
                          Expanded(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  joindContests!();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 8, top: 2, bottom: 4, right: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.circular(8.0),
                                            color: contestJoinedList == 0
                                                ? AllCoustomTheme.getTextThemeColors().withOpacity(0.5)
                                                : AllCoustomTheme.getThemeData().primaryColor,
                                          ),
                                          child: Text(
                                            '$contestJoinedList',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(4),
                                          child: Text(
                                            'JOINED CONTESTS',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
    );
  }
}
