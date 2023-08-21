// ignore_for_file: unused_local_variable, unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/contestsResponseData.dart';
import 'package:tempalteflutter/models/leagueMemberListResponse.dart' as leagues;
import 'package:tempalteflutter/models/leagueMemberTeamResponse.dart' as leagueMember;
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/scorecardResponce.dart';
import 'package:tempalteflutter/models/shedualResults.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/contests/contestsPoolView.dart';
import 'package:tempalteflutter/modules/contests/leagueTeamPreview.dart';
import 'package:tempalteflutter/modules/contests/playersPointInfoScreen.dart';
import 'package:tempalteflutter/modules/createTeam/createTeamScreen.dart';
import 'package:tempalteflutter/modules/home/standingScreen.dart';
import 'package:tempalteflutter/modules/joinContest/teamSelectionScreen.dart';
import 'package:tempalteflutter/modules/myProfile/publicProfile.dart';
import 'package:tempalteflutter/modules/pymentOptions/pymentOptionsScreen.dart';
import 'package:tempalteflutter/constance/global.dart' as globals;
import 'package:tempalteflutter/models/teamResponseData.dart' as teamData;
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';

class LeagueInfoScreen extends StatefulWidget {
  final ShedualData? shedualData;
  final LeagueData? contestJoinedData;
  final TabType? tabtype;
  final ContestsLeagueListData? listData;

  const LeagueInfoScreen({
    Key? key,
    this.shedualData,
    this.listData,
    this.tabtype = TabType.Upcoming,
    this.contestJoinedData,
  }) : super(key: key);

  @override
  _LeagueInfoScreenState createState() => _LeagueInfoScreenState();
}

class _LeagueInfoScreenState extends State<LeagueInfoScreen> with SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController? controller;
  var leagueMemberList = <leagues.LeagueMember>[];
  var isProsses = false;
  var isGetTeam = false;
  var listData = ContestsLeagueListData();
  var teamList = <teamData.TeamData>[];
  var contestJoinedData = LeagueData();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScorecardResponce? scorecardResponce;
  ContestsLeagueResponseData? categoryList;

  @override
  void initState() {
    super.initState();
    listData = widget.listData!;
    contestJoinedData = widget.contestJoinedData!;
    controller = new TabController(length: 2, vsync: this);
    getLeaguesList(false);
  }

  var id = '';

  Future getLeaguesList(bool isPool) async {
    setState(() {
      isGetTeam = true;
      leagueMemberList.clear();
      if (!isPool) {
        isProsses = true;
      }
    });
    if (widget.tabtype == TabType.Upcoming) {
      id = listData.leagueId!;
    } else if (widget.tabtype == TabType.Live) {
      id = contestJoinedData.leagueId!;
    } else {
      id = contestJoinedData.leagueId!;
    }

    getLeadData();
    getResults();

    setState(() {
      isProsses = false;
      isGetTeam = false;
    });
  }

  Future getLeadData() async {
    var id = '';
    if (widget.tabtype == TabType.Upcoming) {
      id = listData.leagueId!;
    } else if (widget.tabtype == TabType.Live) {
      id = contestJoinedData.leagueId!;
    } else {
      id = contestJoinedData.leagueId!;
    }
    categoryList = await ApiProvider().postContestList();
    categoryList!.contestsCategoryLeagueListData!.forEach((list) {
      list.contestsCategoryLeagueListData!.forEach((data) {
        if (data.leagueId == id) {
          listData = data;
        }
      });
    });
    setState(() {});
  }

  var txt = 'F';
  void getResults() async {
    var id = '';

    if (widget.tabtype == TabType.Upcoming) {
      id = listData.leagueId!;
      txt = 'F';
    } else if (widget.tabtype == TabType.Live) {
      id = contestJoinedData.leagueId!;
      txt = 'L';
    } else {
      id = contestJoinedData.leagueId!;
      txt = 'R';
    }

    await getTeamList();
    if (!mounted) return;
    setState(() {});
  }

  Future getTeamList() async {
    var team = await ApiProvider().getCreatedTeamList('${widget.shedualData!.matchId}');
    if (team != null && team.success == 1) {
      if (team.teamData!.length > 0) {
        teamList = team.teamData!;
      } else {
        teamList = <teamData.TeamData>[];
      }
    }
    if (!mounted) return;
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
              key: _scaffoldKey,
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: Stack(
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
                                        'Contest',
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
                        child: ModalProgressHUD(
                          inAsyncCall: isProsses,
                          color: Colors.transparent,
                          progressIndicator: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                          child: Container(
                            child: contestsListData(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uderGroundDrawer(ContestsLeagueListData data) {
    return Column(
      children: <Widget>[
        Container(
          height: 24,
          padding: EdgeInsets.only(left: 16, right: 16),
          color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'RANK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getTextThemeColors().withOpacity(0.8),
                  fontSize: ConstanceData.SIZE_TITLE14,
                ),
              ),
              Text(
                'PRIZE',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getTextThemeColors().withOpacity(0.8),
                  fontSize: ConstanceData.SIZE_TITLE14,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.leagueWiner!.length,
            itemBuilder: (context, index) {
              return Container(
                height: 34,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 16, left: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                '# ' + data.leagueWiner![index].postion!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            ),
                            Text(
                              '₹ ' + data.leagueWiner![index].price!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AllCoustomTheme.getTextThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8, bottom: 4),
          child: Text(
            'Note: The actual prize money may be different than the prize money mentioned above if there is a tie for any of the winning position. Check FQAs for further details.as per government regulations, a tax of 31.2% will be deducted if an individual wins more than Rs. 10,000',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getTextThemeColors(),
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        )
      ],
    );
  }

  Widget scorecard() {
    return scorecardResponce == null
        ? widget.tabtype != TabType.Upcoming
            ? Container(
                height: 1,
                child: LinearProgressIndicator(),
              )
            : SizedBox()
        : Column(
            children: <Widget>[
              widget.tabtype != TabType.Upcoming
                  ? Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 8, top: 8, bottom: 4),
                            child: Text(
                              'SCORECARD',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE12,
                                fontWeight: FontWeight.bold,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                          ),
                          scorecardResponce!.teams!.length == 2
                              ? Container(
                                  padding: EdgeInsets.only(left: 8, top: 4, bottom: 4),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        scorecardResponce!.teams![0].overs != ''
                                            ? TextSpan(
                                                text: '${scorecardResponce!.teams![0].shortName}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        scorecardResponce!.teams![0].scores != ''
                                            ? TextSpan(
                                                text: '       ${scorecardResponce!.teams![0].scores!.replaceAll('/', ' - ')}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        scorecardResponce!.teams![0].overs != ''
                                            ? TextSpan(
                                                text: ' (${scorecardResponce!.teams![0].overs})',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        scorecardResponce!.teams![0].overs != '' && scorecardResponce!.teams![1].overs != ''
                                            ? TextSpan(
                                                text: '     |     ',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        scorecardResponce!.teams![1].overs != ''
                                            ? TextSpan(
                                                text: '${scorecardResponce!.teams![1].shortName}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        scorecardResponce!.teams![1].scores != ''
                                            ? TextSpan(
                                                text: '       ${scorecardResponce!.teams![1].scores!.replaceAll('/', ' - ')}',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                        scorecardResponce!.teams![1].overs != ''
                                            ? TextSpan(
                                                text: ' (${scorecardResponce!.teams![1].overs})',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              )
                                            : TextSpan(
                                                text: '',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          scorecardResponce!.statusNote != ''
                              ? Container(
                                  padding: EdgeInsets.only(left: 4, top: 4, bottom: 8),
                                  child: Text(
                                    '${scorecardResponce!.statusNote}' != '' ? '${scorecardResponce!.statusNote}' : '',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                      fontWeight: FontWeight.bold,
                                      color: AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 8,
                                ),
                          Divider(
                            color: Colors.black,
                            height: 1,
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
              widget.tabtype != TabType.Upcoming
                  ? InkWell(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PlayersPointInfoScreen(
                              shedualData: widget.shedualData!,
                            ),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'View Player Stats',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getThemeData().primaryColor,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.chevron_right),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: Colors.black,
                              height: 1,
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          );
  }

  void setPriceClickEvent(ContestsLeagueListData listData) async {
    setState(() {
      isProsses = true;
    });
    var userData = await ApiProvider().drawerInfoList();
    await getLeadData();
    setState(() {
      isProsses = false;
    });
    if (double.parse(listData.entryFees!) <= double.parse(userData.data!.balance!)) {
      if (categoryList!.teamlist!.length != listData.leagueMember!.length) {
        if (categoryList!.teamlist!.length > 0) {
          var count = categoryList!.teamlist!.length - listData.leagueMember!.length;
          if (count >= 2) {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamSelectionScreen(
                  teamSelectionType: TeamSelectionType.regular,
                  shedualData: widget.shedualData!,
                  leagueId: listData.leagueId!,
                  entryfee: listData.entryFees!,
                ),
                fullscreenDialog: true,
              ),
            );
          } else {
            var teamId = '';
            categoryList!.teamlist!.forEach((data) {
              bool isMach = false;
              listData.leagueMember!.forEach((jList) {
                if (jList == data) {
                  isMach = true;
                }
              });
              if (!isMach) {
                teamId = data;
              }
            });
            setshowDialog(teamId, listData.leagueId!, listData.entryFees!, userData.data!);
          }
        }
      } else {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateTeamScreen(),
            fullscreenDialog: true,
          ),
        );
        await getLeaguesList(false);
        await getLeadData();
        setState(() {
          isProsses = false;
        });
        if (categoryList!.teamlist!.length > 0) {
          var teamId = '';
          categoryList!.teamlist!.forEach((data) {
            bool isMach = false;
            listData.leagueMember!.forEach((jList) {
              if (jList == data) {
                isMach = true;
              }
            });
            if (!isMach) {
              teamId = data;
            }
          });
          if (teamId != '') {
            setshowDialog(teamId, listData.leagueId!, listData.entryFees!, userData.data!);
          }
        }
      }
    } else {
      bool isTruePayment = false;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PymentScreen(
              paymetMoney: '${double.parse(listData.entryFees!) - double.parse(userData.data!.balance!)}',
              entryFees: listData.entryFees,
              isTruePayment: () {
                isTruePayment = true;
              }),
          fullscreenDialog: true,
        ),
      );
      if (isTruePayment) {
        setPriceClickEvent(listData);
      }
    }
    getLeaguesList(false);
    setState(() {
      isProsses = false;
    });
  }

  Widget _buildSliverFixedExtentList(BuildContext context) {
    return widget.tabtype == TabType.Upcoming
        ? SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return ContestsPoolView(
                shedualData: widget.shedualData,
                data: listData,
                clickLogPress: () {},
                clickWinners: () {},
                clickPrice: () async {
                  setPriceClickEvent(listData);
                },
                allClick: () {},
              );
            }, childCount: 1),
          )
        : SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: getPriceList(),
                    ),
                    widget.tabtype != TabType.Upcoming && contestJoinedData.isFull != '0'
                        ? Container(
                            padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                            child: listData == null ? SizedBox() : progressBar(),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 12,
                    ),
                    Divider(
                      height: 1,
                    )
                  ],
                ),
              );
            }, childCount: 1),
          );
  }

  Widget getPriceList() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
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
                      contestJoinedData.totalWiningAmount!,
                      style: TextStyle(
                          fontFamily: 'Poppins', fontSize: 28, color: AllCoustomTheme.getBlackAndWhiteThemeColors(), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Spots',
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
                      '${int.tryParse(contestJoinedData.totalTeam.toString())! - int.parse(widget.contestJoinedData!.remainingTeam.toString())}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black.withOpacity(0.7),
                        fontSize: ConstanceData.SIZE_TITLE16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Text(
                  'Entry',
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
                    height: 13,
                    padding: EdgeInsets.only(top: 2),
                    child: Image.asset(
                      ConstanceData.ruppeIcon,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  Container(
                    child: Text(
                      contestJoinedData.entryFees!,
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14, color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void setshowDialog(String teamId, String leagueId, String entryFee, UserData userData) {
    var cashBonus = '';
    var unutilizedBalanceWinning = '${(double.tryParse(userData.winingAmount!)! + double.parse(userData.balance!)).toStringAsFixed(2)}';

    if ((double.tryParse(entryFee)! * 0.20) < double.parse(userData.cashBonus!)) {
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
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
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
                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
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
                                '₹${(double.tryParse(entryFee)! - double.parse(cashBonus)).toStringAsFixed(2)}',
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
                                      setContestJoin(teamId, leagueId);
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

  Future setContestJoin(String teamId, String leagueId) async {
    setState(() {
      isProsses = true;
    });

    setState(() {
      isProsses = false;
    });
    getLeaguesList(false);
  }

  Widget progressBar() {
    return Container(
      child: Container(
        color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
        padding: EdgeInsets.only(top: 4, bottom: 4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 2),
              child: Image.asset(
                ConstanceData.greencup,
                width: 12,
                height: 12,
                color: AllCoustomTheme.getTextThemeColors(),
              ),
            ),
            Text(
              '  ${listData.totalWiner}  WINNER!',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE10,
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getTextThemeColors(),
              ),
            ),
          ],
        ),
      ),
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

  Widget contestsListData() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
              return scorecard();
            }, childCount: 1),
          ),
          _buildSliverFixedExtentList(context),
          SliverPersistentHeader(
            pinned: true,
            delegate: ContestTabHeader(controller!),
          ),
        ];
      },
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                dowunloadbar(),
                tableHaderBar(),
                Expanded(
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: () async {
                      await getLeaguesList(true);
                    },
                    child: isProsses || isGetTeam
                        ? Container()
                        : leagueMemberList.length > 0
                            ? ListView.builder(
                                padding: EdgeInsets.only(bottom: 80),
                                physics: BouncingScrollPhysics(),
                                itemCount: leagueMemberList.length,
                                itemBuilder: (context, index) {
                                  return LeaguesListView(
                                    contestJoinedData: contestJoinedData,
                                    listData: listData,
                                    tabtype: widget.tabtype!,
                                    swapeTeamClick: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TeamSelectionScreen(
                                            shedualData: widget.shedualData!,
                                            leagueId: listData.leagueId!,
                                            selectedTeamId: leagueMemberList[index].teamId!,
                                            teamSelectionType: TeamSelectionType.swap,
                                          ),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    allClick: () {},
                                    userImageClick: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PublicProfileScreen(
                                            userId: leagueMemberList[index].userId!,
                                          ),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    leagueTeam: leagueMemberList[index],
                                  );
                                },
                              )
                            : Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(bottom: 16),
                                      child: Text(
                                        'No team has joined this contest yet',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: Image.asset(ConstanceData.users),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 16),
                                      child: Text(
                                        'Be the first one to join this contest & start winning!',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                  ),
                ),
                listData != null && widget.tabtype != TabType.Upcoming && listData.isFull == '0'
                    ? Container(
                        padding: EdgeInsets.only(left: 16, bottom: 8, right: 16, top: 4),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Your entry fee has been refunded for the ',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text: 'Rs.${listData.entryFees}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' contest. The contest you joined had to be cancelled as all the slots were not filled.',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          ),
          listData == null ? SizedBox() : uderGroundDrawer(listData),
        ],
      ),
    );
  }

  Widget tableHaderBar() {
    return Column(
      children: <Widget>[
        Divider(
          height: 1,
        ),
        Container(
          padding: EdgeInsets.only(left: 16, right: 8, bottom: 4, top: 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Text(
                    'ALL TEAMS',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE12,
                      color: AllCoustomTheme.getTextThemeColors(),
                    ),
                  ),
                ),
              ),
              widget.tabtype != TabType.Upcoming
                  ? Container(
                      child: Text(
                        'POINTS',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE12,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    )
                  : SizedBox(),
              widget.tabtype != TabType.Upcoming
                  ? Container(
                      width: 80,
                      child: Text(
                        'RANK',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE12,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
      ],
    );
  }

  Widget dowunloadbar() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(6),
      color: contestJoinedData != null && contestJoinedData.isFull == '0'
          ? Colors.red.withOpacity(0.1)
          : AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8),
              child: widget.tabtype == TabType.Upcoming
                  ? Text(
                      'view all teams \nafter the deadline',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE12, color: AllCoustomTheme.getTextThemeColors()),
                    )
                  : contestJoinedData.isFull == '0'
                      ? Container(
                          padding: EdgeInsets.only(top: 2, bottom: 2),
                          child: Container(
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'The league did not fill up!',
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE14, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 2),
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                    size: 12,
                                  ),
                                ),
                                Text(
                                  'Teams Locked!',
                                  style: TextStyle(
                                      fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE12, color: AllCoustomTheme.getTextThemeColors()),
                                )
                              ],
                            ),
                            Text(
                              ' Now download all teams',
                              style:
                                  TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE12, color: AllCoustomTheme.getTextThemeColors()),
                            )
                          ],
                        ),
            ),
          ),
          Container(
            child: Opacity(
              opacity: widget.tabtype != TabType.Upcoming && contestJoinedData.isFull != '0' ? 1.0 : 0.4,
              child: Container(
                width: 150,
                height: 24,
                decoration: BoxDecoration(
                  color: AllCoustomTheme.getThemeData().backgroundColor,
                  borderRadius: new BorderRadius.circular(4.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.3), offset: Offset(0, 1), blurRadius: 5.0),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (widget.tabtype != TabType.Upcoming) {
                        getPDF();
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Download Teams ',
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE10, color: AllCoustomTheme.getTextThemeColors()),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(
                            Icons.file_download,
                            color: AllCoustomTheme.getTextThemeColors(),
                            size: 14,
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
    );
  }

  void getPDF() async {
    setState(() {
      isProsses = true;
    });

    setState(() {
      isProsses = false;
    });
  }

  void gotoleagueTeamPreview(leagueMember.Leagues teamdata) async {
    var isEdite = false;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LeagueTeamPreviewScreen(
          shreCallback: () {},
          leagueTeamData: teamdata,
          shedualData: widget.shedualData!,
          editeCallBack: () async {
            isEdite = true;
          },
        ),
        fullscreenDialog: true,
      ),
    );
    if (isEdite) {
      await Future.delayed(const Duration(milliseconds: 500));
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateTeamScreen(
            createdTeamData: teamdata.leagueMember![0],
            createTeamtype: CreateTeamType.editTeam,
          ),
          fullscreenDialog: true,
        ),
      );
    }
    getLeaguesList(false);
  }
}

class LeaguesListView extends StatelessWidget {
  final VoidCallback? swapeTeamClick;
  final VoidCallback? allClick;
  final VoidCallback? userImageClick;
  final leagues.LeagueMember? leagueTeam;
  final TabType? tabtype;
  final ContestsLeagueListData? listData;
  final LeagueData? contestJoinedData;

  const LeaguesListView({
    Key? key,
    this.leagueTeam,
    this.swapeTeamClick,
    this.allClick,
    this.userImageClick,
    this.tabtype = TabType.Upcoming,
    this.listData,
    this.contestJoinedData,
  }) : super(key: key);

  bool isInWin() {
    if (listData != null && tabtype != TabType.Upcoming) {
      if (contestJoinedData!.isFull != '0') {
        int lastPotion = 0;
        listData!.leagueWiner!.forEach((data) {
          var listPotition = data.postion!.replaceAll(' ', '').trim().split('-');
          listPotition.forEach((potition) {
            final pInt = int.tryParse('$potition');
            if (lastPotion < pInt!) {
              lastPotion = pInt;
            }
          });
        });
        if (leagueTeam!.rank! <= lastPotion) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: leagueTeam!.userId == globals.userdata!.userId ? AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.1) : Colors.transparent,
      child: InkWell(
        onTap: () {
          allClick!();
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8, bottom: 4, top: 4, right: 8),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      userImageClick!();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: leagueTeam!.image != ""
                          ? AvatarImage(
                              imageUrl: ConstanceData.UserImageUrl + leagueTeam!.image!,
                              sizeValue: 44,
                              radius: 44,
                              isCircle: true,
                            )
                          : Image.asset(ConstanceData.userAvatar),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            leagueTeam!.teamName!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                          tabtype != TabType.Upcoming && leagueTeam!.winningStatus == "true"
                              ? Container(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 2),
                                        child: Image.asset(
                                          ConstanceData.greencup,
                                          width: 12,
                                          height: 12,
                                        ),
                                      ),
                                      tabtype == TabType.Live
                                          ? Text(
                                              '  IN WINNING...',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            )
                                          : Text(
                                              leagueTeam!.winningAmount != "" ? '  YOU WON ₹${leagueTeam!.winningAmount}' : '  WINNER! ',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE10,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                    ],
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  ),
                  tabtype != TabType.Upcoming
                      ? Container(
                          child: Text(
                            '${leagueTeam!.points}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              color: Colors.black.withOpacity(0.6),
                            ),
                          ),
                        )
                      : SizedBox(),
                  tabtype == TabType.Upcoming
                      ? Container(
                          width: 50,
                          height: 50,
                          child: leagueTeam!.userId == globals.userdata!.userId
                              ? InkWell(
                                  onTap: () {
                                    swapeTeamClick!();
                                  },
                                  child: Icon(Icons.swap_horiz),
                                )
                              : SizedBox(),
                        )
                      : Container(
                          padding: EdgeInsets.only(right: 4),
                          width: 80,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                '#',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '${leagueTeam!.rank}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              tabtype == TabType.Live
                                  ? leagueTeam!.pointsStatus == "="
                                      ? Container(
                                          width: 22,
                                          height: 22,
                                          child: Image.asset(ConstanceData.arrowE),
                                        )
                                      : leagueTeam!.pointsStatus == ">"
                                          ? Container(
                                              width: 22,
                                              height: 22,
                                              child: Image.asset(ConstanceData.arrowG),
                                            )
                                          : leagueTeam!.pointsStatus == "<"
                                              ? Container(
                                                  width: 22,
                                                  height: 22,
                                                  child: Image.asset(ConstanceData.arrowL),
                                                )
                                              : SizedBox()
                                  : SizedBox()
                            ],
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
      ),
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  final TabController controller;

  ContestTabHeader(
    this.controller,
  );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AllCoustomTheme.getThemeData().backgroundColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: new TabBar(
              unselectedLabelColor: AllCoustomTheme.getTextThemeColors().withOpacity(0.6),
              indicatorColor: AllCoustomTheme.getThemeData().primaryColor,
              labelColor: AllCoustomTheme.getThemeData().primaryColor,
              labelStyle: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE14,
              ),
              tabs: [
                new Tab(text: 'Leaderboard'),
                new Tab(text: 'Prize Breakup'),
              ],
              controller: controller,
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 42.0;

  @override
  double get minExtent => 42.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class MatchHadder extends StatelessWidget {
  const MatchHadder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AllCoustomTheme.getThemeData().backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            height: 36,
            padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: Row(
              children: <Widget>[
                Container(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/19.png'),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    "SA",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontSize: ConstanceData.SIZE_TITLE12,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'vs',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    'IND',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontSize: ConstanceData.SIZE_TITLE12,
                    ),
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  child: Image.asset('assets/25.png'),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  child: Text(
                    'Mon, 9 Sep',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: HexColor(
                        '#AAAFBC',
                      ),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
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
