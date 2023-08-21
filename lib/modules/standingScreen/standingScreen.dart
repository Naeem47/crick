// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/sharedPreferences.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/drawer/drawer.dart';
import 'package:tempalteflutter/modules/home/homeScreen.dart';
import 'package:tempalteflutter/modules/result/standingResult.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';

class StandingScree extends StatefulWidget {
  final void Function()? menuCallBack;

  const StandingScree({Key? key, this.menuCallBack}) : super(key: key);
  @override
  _StandingScreeState createState() => _StandingScreeState();
}

class _StandingScreeState extends State<StandingScree> with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyF = new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    updateData();
  }

  updateData() async {
    userData = (await MySharedPreferences().getUserData())!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        children: <Widget>[
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
          ),
          SafeArea(
            child: Scaffold(
              drawer: AppDrawer(
                mySettingClick: () {},
                referralClick: () {},
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                title: Text(
                  'Standings',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Text(
                        "Upcoming",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Live",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Completed",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                color: AllCoustomTheme.getThemeData().backgroundColor,
                child: TabBarView(
                  children: <Widget>[
                    Fixtures(),
                    Live(),
                    Results(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  UserData userData = new UserData();

  Widget drawerButton() {
    return InkWell(
      onTap: openDrawer,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
            radius: 14,
            child: AvatarImage(
              imageUrl: ConstanceData.appIcon,
              isCircle: true,
              radius: 28,
              sizeValue: 28,
              isAssets: false,
            ),
          ),
          Icon(Icons.sort, color: AllCoustomTheme.getReBlackAndWhiteThemeColors())
        ],
      ),
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      title: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Standings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: AllCoustomTheme.getThemeData().backgroundColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openDrawer() {
    widget.menuCallBack!();
  }
}

class Fixtures extends StatefulWidget {
  @override
  _FixturesState createState() => _FixturesState();
}

class _FixturesState extends State<Fixtures> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 4),
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          MatchesList(
            titel: "BYJU's jharkhand T20",
            country1Name: "South Africa",
            country2Name: "India",
            country1Flag: 'assets/19.png',
            country2Flag: 'assets/25.png',
            price: "₹2 Lakhs",
            time: '10m 13s',
          ),
          MatchesList(
            titel: 'Fancode ECS T10-Sweden',
            country1Name: "Sri Lnka",
            country2Name: "Bangladesh",
            country1Flag: 'assets/21.png',
            country2Flag: 'assets/23.png',
            price: "₹1 Lakhs",
            time: '18m 21s',
          ),
          MatchesList(
            titel: 'ICC Cricket World Cup',
            country1Name: "Pakistan",
            country2Name: "West Indies",
            country1Flag: 'assets/13.png',
            country2Flag: 'assets/17.png',
            price: "₹2 Lakhs",
            time: 'Fri, 13 Aug',
          ),
          MatchesList(
            titel: 'English One-Day Cup',
            country1Name: "South Africa",
            country2Name: "India",
            country1Flag: 'assets/19.png',
            country2Flag: 'assets/25.png',
            price: "₹50000",
            time: 'Mon, 9 Sep',
          ),
          MatchesList(
            titel: 'Fancode ECS T10-Sweden',
            country1Name: "Sri Lnka",
            country2Name: "Bangladesh",
            country1Flag: 'assets/21.png',
            country2Flag: 'assets/23.png',
            price: "₹1 Lakhs",
            time: '18m 21s',
          ),
          MatchesList(
            titel: 'ICC Cricket World Cup',
            country1Name: "Pakistan",
            country2Name: "West Indies",
            country1Flag: 'assets/13.png',
            country2Flag: 'assets/17.png',
            price: "₹2 Lakhs",
            time: 'Fri, 13 Aug',
          ),
          SizedBox(
            height: 70,
          )
        ],
      ),
    );
  }
}

class Live extends StatefulWidget {
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getTextThemeColors(),
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/cup.png',
            width: 50,
            height: 50,
          ),
        ),
        Text(
          "You haven't joined any contests that are Live\nJoin contests for any of the upcoming matches",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: ConstanceData.SIZE_TITLE14,
            color: AllCoustomTheme.getTextThemeColors(),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 1.3,
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              MatchesList(
                titel: 'ICC Cricket World Cup',
                country1Name: "Pakistan",
                country2Name: "West Indies",
                country1Flag: 'assets/13.png',
                country2Flag: 'assets/17.png',
                price: "₹2 Lakhs",
                time: 'Fri, 13 Aug',
              ),
              MatchesList(
                titel: 'Fancode ECS T10-Sweden',
                country1Name: "Sri Lnka",
                country2Name: "Bangladesh",
                country1Flag: 'assets/21.png',
                country2Flag: 'assets/23.png',
                price: "₹1 Lakhs",
                time: '18m 21s',
              ),
              MatchesList(
                titel: 'English One-Day Cup',
                country1Name: "South Africa",
                country2Name: "India",
                country1Flag: 'assets/19.png',
                country2Flag: 'assets/25.png',
                price: "₹50000",
                time: 'Mon, 9 Sep',
              ),
              MatchesList(
                titel: 'ICC Cricket World Cup',
                country1Name: "Pakistan",
                country2Name: "West Indies",
                country1Flag: 'assets/13.png',
                country2Flag: 'assets/17.png',
                price: "₹2 Lakhs",
                time: 'Fri, 13 Aug',
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        )
      ],
    );
  }
}

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              MatchesList(
                titel: "BYJU's jharkhand T20",
                country1Name: "South Africa",
                country2Name: "India",
                country1Flag: 'assets/19.png',
                country2Flag: 'assets/25.png',
                price: "1 contest joined",
                time: 'Completed',
              ),
              MatchesList(
                titel: 'Fancode ECS T10-Sweden',
                country1Name: "Sri Lnka",
                country2Name: "Bangladesh",
                country1Flag: 'assets/21.png',
                country2Flag: 'assets/23.png',
                price: "15 contest joined",
                time: 'Completed',
              ),
              MatchesList(
                titel: 'ICC Cricket World Cup',
                country1Name: "Pakistan",
                country2Name: "West Indies",
                country1Flag: 'assets/13.png',
                country2Flag: 'assets/17.png',
                price: "8 contest joined",
                time: 'Completed',
              ),
              MatchesList(
                titel: 'English One-Day Cup',
                country1Name: "South Africa",
                country2Name: "India",
                country1Flag: 'assets/19.png',
                country2Flag: 'assets/25.png',
                price: "12 contest joined",
                time: 'Completed',
              ),
              SizedBox(
                height: 70,
              )
            ],
          ),
        )
      ],
    );
  }
}

class MatchesList extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const MatchesList({
    Key? key,
    this.titel,
    this.country1Name,
    this.country2Name,
    this.time,
    this.price,
    this.country1Flag,
    this.country2Flag,
  }) : super(key: key);

  @override
  _MatchesListState createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StandingResult(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: widget.time,
              titel: widget.titel,
            ),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (
            BuildContext context,
          ) =>
              UnderGroundDrawer(
            country1Flag: widget.country1Flag,
            country2Flag: widget.country2Flag,
            country1Name: widget.country1Name,
            country2Name: widget.country2Name,
            price: widget.price,
            time: widget.time,
            titel: widget.titel,
          ),
        );
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        widget.titel!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE12,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Image.asset(
                        ConstanceData.lineups,
                        height: 14,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.notification_add_outlined,
                        size: 16,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.3,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.country1Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        widget.country2Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(widget.country1Flag!),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 3,
                            backgroundColor: Colors.green,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            widget.time!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE12,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.asset(widget.country2Flag!),
                      ),
                    ],
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
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3, left: 3),
                        child: Text(
                          "Mega",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      widget.price!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset(
                      ConstanceData.tv,
                      height: 18,
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
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final TabController controller;

  PersistentHeader(
    this.controller,
  );

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          color: AllCoustomTheme.getThemeData().backgroundColor,
          child: new TabBar(
            unselectedLabelColor: AllCoustomTheme.getTextThemeColors(),
            indicatorColor: AllCoustomTheme.getThemeData().primaryColor,
            labelColor: AllCoustomTheme.getThemeData().primaryColor,
            tabs: [
              new Tab(text: 'Fixtures'),
              new Tab(text: 'Live'),
              new Tab(text: 'Results'),
            ],
            controller: controller,
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  @override
  double get maxExtent => 41.0;

  @override
  double get minExtent => 41.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
