// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/contests/contestsScreen.dart';
import 'package:tempalteflutter/modules/result/joinContestPlayerpoint.dart';
import 'package:tempalteflutter/validator/validator.dart';

class ResultContestScreen extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const ResultContestScreen({Key? key, this.titel, this.country1Name, this.country1Flag, this.country2Name, this.country2Flag, this.time, this.price})
      : super(key: key);
  @override
  _ResultContestScreenState createState() => _ResultContestScreenState();
}

class _ResultContestScreenState extends State<ResultContestScreen> with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    super.initState();
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
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "Contests",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
                  ),
                ),
                centerTitle: true,
              ),
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      MatchHadder(
                        country1Flag: widget.country1Flag,
                        country2Flag: widget.country2Flag,
                        country1Name: widget.country1Name,
                        country2Name: widget.country2Name,
                        price: widget.price,
                        time: widget.time,
                        titel: widget.titel,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "SCORECARD",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: HexColor(
                                      '#AAAFBC',
                                    ),
                                    fontSize: 14,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "SA   213-10",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "  (49.5)",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor(
                                      '#AAAFBC',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('|'),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "IND   224-8",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "  (50)",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor(
                                      '#AAAFBC',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  'India won by 11 runs',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    color: HexColor(
                                      '#AAAFBC',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(
                              color: HexColor(
                                '#AAAFBC',
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JoinContestPlayerPoint(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'View Player Status',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: AllCoustomTheme.getThemeData().primaryColor,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResultContestScreen(),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Prize Pool',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: HexColor(
                                            '#AAAFBC',
                                          ),
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                        ),
                                      ),
                                      Text(
                                        '₹25',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Spots',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: HexColor(
                                            '#AAAFBC',
                                          ),
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                        ),
                                      ),
                                      Text(
                                        '2',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: HexColor(
                                            '#AAAFBC',
                                          ),
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        'Entry',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: HexColor(
                                            '#AAAFBC',
                                          ),
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                        ),
                                      ),
                                      Text(
                                        '₹15',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              height: 24,
                              color: Color(0xFFf5f5f5),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      FontAwesomeIcons.trophy,
                                      color: HexColor(
                                        '#AAAFBC',
                                      ),
                                      size: 10,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      '1 WINNER',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                        color: HexColor('#AAAFBC'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: contestsListData(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ScrollController _scrollController = new ScrollController();

  Widget contestsListData() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: ContestTabHeader(controller),
          ),
        ];
      },
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 40,
                color: Color(0xFFf5f5f5),
                child: Padding(
                  padding: const EdgeInsets.only(right: 14, left: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'team Locked!\nNow download all teams',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE12,
                          color: HexColor('#AAAFBC'),
                        ),
                      ),
                      Container(
                        height: 26,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(5),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5),
                              offset: Offset(0, 1),
                              blurRadius: 5.0,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.4),
                            borderRadius: new BorderRadius.circular(20),
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(left: 8, right: 8),
                              child: Center(
                                child: Text(
                                  'Download Team',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: AllCoustomTheme.getThemeData().primaryColor,
                                    fontSize: ConstanceData.SIZE_TITLE10,
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
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'ALL TEAMS',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: HexColor('#AAAFBC'),
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'POINTS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: HexColor('#AAAFBC'),
                            fontSize: ConstanceData.SIZE_TITLE14,
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          'RANK',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: HexColor('#AAAFBC'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          ConstanceData.userAvatar,
                        ),
                      ),
                      Text(
                        'Oliver Smith(T1)',
                      ),
                      Expanded(
                        child: Text(
                          '132.0',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: HexColor('#AAAFBC'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '#2',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        ConstanceData.userAvatar,
                      ),
                    ),
                    Text(
                      'Oliver Smith(T2)',
                    ),
                    Expanded(
                      child: Text(
                        '356.0',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: HexColor('#AAAFBC'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '#1',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 24,
                  color: Color(0xFFf5f5f5),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 14, left: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'RANK',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: HexColor('#AAAFBC'),
                          ),
                        ),
                        Text(
                          'Prize',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: HexColor('#AAAFBC'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 8, left: 8, top: 4),
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
            ),
          ),
        ],
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
