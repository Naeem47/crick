// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/validator/validator.dart';

class InsideContest extends StatefulWidget {
  @override
  _InsideContestState createState() => _InsideContestState();
}

class _InsideContestState extends State<InsideContest>
    with SingleTickerProviderStateMixin {
  bool iscontestsProsses = false;

  ScrollController _scrollController = new ScrollController();
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
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
                                        'Contests',
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
                            MatchHadder(),
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
                            child: contestsData(),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget contestsData() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 6),
          child: Column(
            children: <Widget>[
              Row(
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
                        height: 4,
                      ),
                      Text(
                        '₹10000',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
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
                      SizedBox(height: 4),
                      Text(
                        '1',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
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
                        height: 4,
                      ),
                      Container(
                        height: 30,
                        width: 90,
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            '₹575',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              backgroundColor:
                                  AllCoustomTheme.getThemeData().primaryColor,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              LinearPercentIndicator(
                lineHeight: 6,
                percent: 0.5,
                linearStrokeCap: LinearStrokeCap.roundAll,
                backgroundColor:
                    AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
                progressColor: AllCoustomTheme.getThemeData().primaryColor,
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Row(
                  children: <Widget>[
                    Text(
                      '2 spot left',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[400]),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 6,
              ),
              Divider(
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ],
          ),
        ),
        Expanded(child: contestsListData())
      ],
    );
  }

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
          dowunloadbar(),
          prizeBreackup(),
        ],
      ),
    );
  }

  Widget prizeBreackup() {
    return Column(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
          height: 50,
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'RANK',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: AllCoustomTheme.getTextThemeColors(),
                  ),
                ),
                Text(
                  'PRIZE',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: AllCoustomTheme.getTextThemeColors(),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '# 1',
                    ),
                    Text(
                      '₹ 10000.00',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '# 2 - 100',
                    ),
                    Text(
                      '₹ 1000.00',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '# 101 - 1000',
                    ),
                    Text(
                      '₹ 100.00',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '# 1001 - 5000',
                    ),
                    Text(
                      '₹ 10.00',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
            ],
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
              fontSize: ConstanceData.SIZE_TITLE12,
            ),
          ),
        ),
        SizedBox(
          height: 70,
        ),
      ],
    );
  }

  Widget dowunloadbar() {
    return Column(
      children: <Widget>[
        Container(
          height: 50,
          color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'view all teams \nafter the deadline',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: AllCoustomTheme.getTextThemeColors(),
                  ),
                ),
                Container(
                  child: Opacity(
                    opacity: 0.6,
                    child: Container(
                      width: 150,
                      height: 24,
                      decoration: BoxDecoration(
                        color: AllCoustomTheme.getThemeData().backgroundColor,
                        borderRadius: new BorderRadius.circular(4.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors()
                                      .withOpacity(0.3),
                              offset: Offset(0, 1),
                              blurRadius: 5.0),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Download Teams ',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE10,
                                    color:
                                        AllCoustomTheme.getTextThemeColors()),
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
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 10, top: 4, right: 10),
          child: Row(
            children: <Widget>[
              Text(
                'All Teams',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getTextThemeColors(),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Text(
                  'No team has joined this contest yet',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AllCoustomTheme.getTextThemeColors(),
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: 100,
                  height: 100,
                  child: Image.asset(ConstanceData.users),
                ),
                Container(
                  child: Text(
                    'Be the first one to join this contest & start winning!',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  final TabController controller;

  ContestTabHeader(this.controller);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AllCoustomTheme.getThemeData().backgroundColor,
      child: Column(
        children: <Widget>[
          Expanded(
            child: new TabBar(
              unselectedLabelColor:
                  AllCoustomTheme.getTextThemeColors().withOpacity(0.6),
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
