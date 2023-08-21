// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/contestsResponseData.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/validator/validator.dart';
import 'package:tempalteflutter/widgets/createTeamClipper.dart';

class ContestsPoolView extends StatelessWidget {
  final ContestsLeagueListData? data;
  final VoidCallback? clickPrice;
  final VoidCallback? clickWinners;
  final VoidCallback? clickLogPress;
  final VoidCallback? allClick;
  final ShedualData? shedualData;

  const ContestsPoolView({
    Key? key,
    this.data,
    this.clickPrice,
    this.clickWinners,
    this.clickLogPress,
    this.shedualData,
    this.allClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          allClick!();
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
              child: Column(
                children: <Widget>[
                  getPriceList(),
                  SizedBox(
                    height: 12,
                  ),
                  progressBar(),
                  SizedBox(
                    height: 4,
                  ),
                  winnerLeft(),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Divider(
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  Widget getPriceList() {
    var remainingteam = int.tryParse(data!.remainingTeam.toString()) ?? 0;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    'Prize Pool',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 22,
                      padding: EdgeInsets.only(top: 2),
                      child: Image.asset(ConstanceData.ruppeIcon),
                    ),
                    Container(
                      child: Text(
                        (data!.totalWiningAmount)!,
                        style: TextStyle(
                            fontFamily: 'Poppins', fontSize: 28, color: AllCoustomTheme.getBlackAndWhiteThemeColors(), fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Center(
              child: InkWell(
                onTap: () {
                  clickWinners!();
                },
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Winners',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Container(
                      child: Text(
                        data!.totalWiner!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Text(
                    'Entry',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE14,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                remainingteam != 0
                    ? Container(
                        height: 30,
                        width: 70,
                        decoration: new BoxDecoration(
                          color: remainingteam == 0 ? Colors.black.withOpacity(0.2) : Colors.green,
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: new BorderRadius.circular(4.0),
                            onTap: remainingteam != 0
                                ? ()  {
                                    clickPrice!();
                                  }
                                : null,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    height: 10,
                                    padding: EdgeInsets.only(top: 0.5),
                                    child: Image.asset(
                                      ConstanceData.ruppeIcon,
                                      color: AllCoustomTheme.getThemeData().backgroundColor,
                                    ),
                                  ),
                                  Text(
                                    data!.entryFees!,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE14,
                                      color: AllCoustomTheme.buildLightTheme().bottomAppBarColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              height: 10,
                              padding: EdgeInsets.only(top: 0.5),
                              child: Image.asset(
                                ConstanceData.ruppeIcon,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.5),
                              ),
                            ),
                            Text(
                              data!.entryFees!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget progressBar() {
    var totalteam = int.tryParse(data!.totalTeam.toString());
    var remainingteam = int.tryParse(data!.remainingTeam.toString());
    var per = (((totalteam! - remainingteam!) * 100) / totalteam);
    return Container(
      height: 10,
      child: LinearGradientProgressbarView(
        progressbarPoint: per,
      ),
    );
  }

  Widget winnerCount() {
    return InkWell(
      onTap: () {
        clickWinners!();
      },
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              data!.leagueWiner!.length.toString() == '1' || data!.leagueWiner!.length.toString() == '0'
                  ? data!.leagueWiner!.length.toString() + ' Winner'
                  : data!.leagueWiner!.length.toString() + ' Winners',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE14,
                color: AllCoustomTheme.getThemeData().primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget winnerLeft() {
    var remainingteam = int.tryParse(data!.remainingTeam.toString()) ?? 0;
    return Row(
      children: <Widget>[
        Text(
          '${remainingteam == 0 ? 'Contest Full' : data!.remainingTeam! + ' spots left'}',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: ConstanceData.SIZE_TITLE14,
            fontWeight: FontWeight.bold,
            color: remainingteam == 0 ? Colors.red : HexColor('#F8A018'),
          ),
        ),
        Flexible(
          child: Container(),
        ),
        Text(
          data!.totalTeam! + ' spots',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: ConstanceData.SIZE_TITLE14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class LinearGradientProgressbarView extends StatelessWidget {
  final double progressbarPoint;

  const LinearGradientProgressbarView({Key? key, this.progressbarPoint = 0.0}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          new ClipPath(
            clipper: LinearGradientTeamClipper(lead: 6.0),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    HexColor('#FDC81F'),
                    Colors.red,
                  ],
                ),
              ),
            ),
          ),
          new ClipPath(
            clipper: LinearGradientTeamClipper(lead: 6.0),
            child: Container(
              width: ((MediaQuery.of(context).size.width - 32) * (100 - progressbarPoint) / 100),
              color: HexColor('#ECECEC'),
            ),
          ),
        ],
      ),
    );
  }
}
