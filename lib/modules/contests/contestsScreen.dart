// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:core';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/contestsResponseData.dart';
import 'package:tempalteflutter/modules/contests/contestCodeScreen.dart';
import 'package:tempalteflutter/modules/contests/createContest.dart';
import 'package:tempalteflutter/modules/contests/createTeamButtonView.dart';
import 'package:tempalteflutter/modules/createTeam/createTeamScreen.dart';
import 'package:tempalteflutter/validator/validator.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'insideContest.dart';

class ContestsScreen extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const ContestsScreen({
    Key? key,
    this.titel,
    this.country1Name,
    this.country1Flag,
    this.country2Name,
    this.country2Flag,
    this.time,
    this.price,
  }) : super(key: key);
  @override
  _ContestsScreenState createState() => _ContestsScreenState();
}

class _ContestsScreenState extends State<ContestsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool iscontestsProsses = false;
  var categoryList = ContestsLeagueResponseData();
  bool tab1 = true;
  bool tab2 = false;
  bool tab3 = false;
  @override
  void initState() {
    categoryList.contestsCategoryLeagueListData = <ContestsLeagueCategoryListResponseData>[];
    categoryList.teamlist = [];
    categoryList.totalcontest = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
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
                                        child: Text(
                                          widget.titel!,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Image.asset(
                                        ConstanceData.wallet,
                                        height: 22,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      )
                                    ],
                                  ),
                                ),
                                MatchHadder(
                                  country1Flag: widget.country1Flag!,
                                  country2Flag: widget.country2Flag!,
                                  country1Name: widget.country1Name!,
                                  country2Name: widget.country2Name!,
                                  price: widget.price!,
                                  time: widget.time!,
                                  titel: widget.titel!,
                                )
                              ],
                            ),
                          ),
                          Flexible(
                            child: ModalProgressHUD(
                              inAsyncCall: iscontestsProsses,
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
        ),
        !tab2
            ? Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: IgnorePointer(
                  ignoring: iscontestsProsses,
                  child: Container(
                    width: double.infinity,
                    child: CreateTeamButton(
                      contestJoinedList: categoryList.totalcontest!,
                      teamList: categoryList.teamlist!.length,
                      createTeam: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateTeamScreen(),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }

  void showInSnackBar(String value, {bool isGreeen = false}) {
    var snackBar = SnackBar(
      backgroundColor: isGreeen ? Colors.green : Colors.red,
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
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = true;
                      tab2 = false;
                      tab3 = false;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "Contest",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: tab1 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        width: 80,
                        color: tab1 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getThemeData().backgroundColor,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = false;
                      tab2 = true;
                      tab3 = false;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "My contest",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: tab2 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        width: 80,
                        color: tab2 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getThemeData().backgroundColor,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      tab1 = false;
                      tab2 = false;
                      tab3 = true;
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "My Team",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: tab3 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        width: 80,
                        color: tab3 ? AllCoustomTheme.getThemeData().primaryColor : AllCoustomTheme.getThemeData().backgroundColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        tab1
            ? Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return StickyHeader(
                          header: new Container(
                            color: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4, bottom: 6, left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                    'Contest Number $index',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'The Ultimate Face Off',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: AllCoustomTheme.getThemeData().primaryColor,
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          content: Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8, top: 6, bottom: 100),
                            child: Column(
                              children: <Widget>[
                                contestnt('₹1000', '₹575', '2', '1 spot', "1", 0.2),
                                SizedBox(
                                  height: 8,
                                ),
                                contestnt('₹200', '₹225', '3', '', "2", 0.5),
                                SizedBox(
                                  height: 8,
                                ),
                                contestnt('₹100', '₹55', '1', '1 spot', "3", 0.8),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 140, left: 16, right: 16),
                      child: Container(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.4),
                                    borderRadius: new BorderRadius.circular(20),
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ContestCodeScreen(),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Center(
                                        child: Text(
                                          'Enter Contest Code',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                            fontSize: ConstanceData.SIZE_TITLE10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    splashColor: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.4),
                                    borderRadius: new BorderRadius.circular(20),
                                    onTap: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CreateContestScreen(
                                            country1Flag: widget.country1Flag!,
                                            country2Flag: widget.country2Flag!,
                                            country1Name: widget.country1Name!,
                                            country2Name: widget.country2Name!,
                                            price: widget.price!,
                                            time: widget.time!,
                                            titel: widget.titel!,
                                          ),
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Center(
                                        child: Text(
                                          'Create a Contest',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                            fontSize: ConstanceData.SIZE_TITLE10,
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
                    ),
                  ],
                ),
              )
            : tab2
                ? Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'You have not joined a contest yet!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Image.asset(
                        ConstanceData.g1,
                        fit: BoxFit.cover,
                        height: 200,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'What are you waiting for',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(left: 50, right: 50, bottom: 8),
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
                  )
                : Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.circle_sharp,
                                          color: Colors.orange,
                                          size: 14,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          '4 player not announced in lineups',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.orange,
                                            fontSize: ConstanceData.SIZE_TITLE14,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Container(
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(13),
                                          topRight: Radius.circular(13),
                                        ),
                                        image: DecorationImage(image: AssetImage(ConstanceData.cricketGround), fit: BoxFit.cover)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Enric354577 (T1)',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ConstanceData.SIZE_TITLE14,
                                                ),
                                              ),
                                              Expanded(child: SizedBox()),
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Icon(
                                                Icons.copy_all,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'SIN',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: ConstanceData.SIZE_TITLE14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  '4',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: ConstanceData.SIZE_TITLE14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'DHA',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: ConstanceData.SIZE_TITLE14,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  '4',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: ConstanceData.SIZE_TITLE14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      ConstanceData.dhoni,
                                                      height: 60,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(7)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                                                        child: Text(
                                                          'MS. Dhoni',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                            fontSize: ConstanceData.SIZE_TITLE12,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.grey[300],
                                                    radius: 13,
                                                    child: Text(
                                                      'C',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: ConstanceData.SIZE_TITLE12,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      ConstanceData.virat,
                                                      height: 60,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(7)),
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 8),
                                                        child: Text(
                                                          'Virat Kohli',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.white,
                                                            fontSize: ConstanceData.SIZE_TITLE12,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                CircleAvatar(
                                                  radius: 12,
                                                  backgroundColor: Colors.white,
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.grey[300],
                                                    radius: 13,
                                                    child: Text(
                                                      'VC',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: Colors.white,
                                                        fontSize: ConstanceData.SIZE_TITLE12,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Wk',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '4',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                          'BAT',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '3',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                          'AR',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '1',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                        Text(
                                          'BOWEL',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          '3',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getTextThemeColors(),
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                        Expanded(child: SizedBox()),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13),
                          ),
                          color: Colors.black.withOpacity(0.2),
                        ),
                      )
                    ],
                  )
      ],
    );
  }

  Widget contestnt(
    String txt1,
    String txt2,
    String txt3,
    String txt4,
    String txt5,
    double progress,
  ) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InsideContest(),
          fullscreenDialog: false,
        ),
      ),
      child: Card(
        margin: EdgeInsets.only(bottom: 8),
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Prize Pool',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        txt1,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Winners',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        txt5,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: AllCoustomTheme.getThemeData().primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          'Entry',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      InkWell(
                        onTap: () {
                          setshowDialog();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 14, left: 14, top: 4, bottom: 4),
                            child: Text(
                              txt2,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Theme.of(context).canvasColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 4,
            ),
            LinearPercentIndicator(
              lineHeight: 6,
              percent: progress,
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
              progressColor: AllCoustomTheme.getThemeData().primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    txt3 + 'spot left',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.orange[400],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    txt4,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      color: Colors.orange[400],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AllCoustomTheme.isLight ? HexColor("#f5f5f5") : Theme.of(context).disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      ConstanceData.prize,
                      height: 16,
                    ),
                    Image.asset(
                      ConstanceData.guaranteed,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setshowDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
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
                                  fontWeight: FontWeight.w500,
                                  color: AllCoustomTheme.getThemeData().primaryColor,
                                  fontSize: ConstanceData.SIZE_TITLE18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Container(
                              child: Text(
                                'Unutilized Balance + Winning = ₹1000',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
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
                            fontWeight: FontWeight.w600,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE14,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '₹575',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getThemeData().primaryColor,
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
                            fontWeight: FontWeight.w600,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE14,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '-₹0',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getThemeData().primaryColor,
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
                          '₹575',
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
                SizedBox(
                  height: 6,
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.only(left: 50, right: 50, bottom: 8),
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
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 20),
                  child: Text(
                    "By joining this contest, you accept FansyApp's T&C.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                      fontSize: ConstanceData.SIZE_TITLE12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void setSoCloseContestFilled(String price, String leagueId) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) => soCloseFilledPopup(price, leagueId),
    );
  }

  Widget soCloseFilledPopup(String price, String leagueId) {
    ContestsLeagueListData leageData = new ContestsLeagueListData();
    categoryList.contestsCategoryLeagueListData!.forEach((category) {
      category.contestsCategoryLeagueListData!.forEach((list) {
        if (int.tryParse('${list.remainingTeam}') != 0) {
          if (int.tryParse('${list.entryFees}') == int.tryParse('$price') && list.leagueId != leagueId) {
            leageData = list;
            return;
          }
        }
      });
    });
    if (leageData == null) {
      categoryList.contestsCategoryLeagueListData!.forEach((category) {
        category.contestsCategoryLeagueListData!.forEach((list) {
          if (int.tryParse('${list.remainingTeam}') != 0) {
            int? aa = int.tryParse('$price');
            if (int.tryParse('${list.entryFees}')! <= aa! && list.leagueId != leagueId) {
              leageData = list;
              return;
            }
          }
        });
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 16),
          color: Colors.white,
          child: Text(
            'So close! That contest filled up',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: ConstanceData.SIZE_TITLE20,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 8, right: 16),
          color: Colors.white,
          child: Text(
            "No worries, join this contest instead! It's exactly the same type",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.6),
              fontWeight: FontWeight.bold,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
        Divider(
          height: 1,
        ),
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      color: Colors.white,
                      child: Text(
                        'Prize Pool'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 4),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 12,
                            height: 12,
                            padding: EdgeInsets.only(top: 1.5),
                            child: Image.asset(ConstanceData.ruppeIcon),
                          ),
                          Text(
                            "${leageData.totalWiningAmount}".toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              fontWeight: FontWeight.bold,
                              fontSize: ConstanceData.SIZE_TITLE14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      color: Colors.white,
                      child: Text(
                        "Winners".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "${leageData.totalWiner}".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      color: Colors.white,
                      child: Text(
                        "Teams".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "${leageData.totalTeam}".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontWeight: FontWeight.bold,
                          fontSize: ConstanceData.SIZE_TITLE14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      color: Colors.white,
                      child: Text(
                        "Entry".toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                          fontSize: ConstanceData.SIZE_TITLE12,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8, top: 4),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 12,
                            height: 12,
                            padding: EdgeInsets.only(top: 1.5),
                            child: Image.asset(ConstanceData.ruppeIcon),
                          ),
                          Text(
                            "${leageData.entryFees}".toUpperCase(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              fontWeight: FontWeight.bold,
                              fontSize: ConstanceData.SIZE_TITLE14,
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
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 40,
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
        ),
        Container(
          padding: EdgeInsets.only(left: 16, bottom: 8, right: 16),
          color: Colors.white,
          child: Text(
            "You can check other competitors after joining the contest",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getTextThemeColors(),
              fontWeight: FontWeight.bold,
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
      ],
    );
  }

  Widget uderGroundDrawer(ContestsLeagueListData data) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.only(top: 4),
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'WINNING BREAKUP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ConstanceData.SIZE_TITLE16,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Prize Pool',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                      fontSize: ConstanceData.SIZE_TITLE16,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '₹' + data.totalWiningAmount!,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getTextThemeColors(),
                      fontWeight: FontWeight.bold,
                      fontSize: ConstanceData.SIZE_TITLE20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.leagueWiner!.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Rank: ' + data.leagueWiner![index].postion!,
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
                  Divider()
                ],
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

  Widget listItems(String name, String description) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 4, top: 8),
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Text(
                  description,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE14, color: AllCoustomTheme.getTextThemeColors()),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class MatchHadder extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const MatchHadder({
    Key? key,
    this.titel,
    this.country1Name,
    this.country1Flag,
    this.country2Name,
    this.country2Flag,
    this.time,
    this.price,
  }) : super(key: key);

  @override
  _MatchHadderState createState() => _MatchHadderState();
}

class _MatchHadderState extends State<MatchHadder> {
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
                  child: Image.asset(widget.country1Flag!),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    widget.country1Name!,
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
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 8),
                  child: Text(
                    widget.country2Name!,
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
                  child: Image.asset(widget.country2Flag!),
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Container(
                  child: Text(
                    widget.time!,
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
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
