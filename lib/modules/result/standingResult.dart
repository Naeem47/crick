// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/contests/contestsScreen.dart';
import 'package:tempalteflutter/modules/result/resultContest.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';

class StandingResult extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const StandingResult({Key? key, this.titel, this.country1Name, this.country1Flag, this.country2Name, this.country2Flag, this.time, this.price})
      : super(key: key);
  @override
  _StandingResultState createState() => _StandingResultState();
}

class _StandingResultState extends State<StandingResult> with SingleTickerProviderStateMixin {
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
      child: Scaffold(
        backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          title: Text(
            "Joined Contests",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
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
            Expanded(
              child: Padding(
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
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "${widget.country1Name}  213-10",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " (49.5)",
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
                          "${widget.country2Name}    224-8",
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
                    SizedBox(
                      height: 8,
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
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              pageController.jumpToPage(0);
                            });
                          },
                          child: Text(
                            "Player Points",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: pageNumber == 0
                                  ? Theme.of(context).primaryColor
                                  : HexColor(
                                      '#AAAFBC',
                                    ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              pageController.jumpToPage(1);
                            });
                          },
                          child: Text(
                            "Contest",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: pageNumber == 1
                                  ? Theme.of(context).primaryColor
                                  : HexColor(
                                      '#AAAFBC',
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (number) {
                          setState(() {
                            pageNumber = number;
                          });
                        },
                        children: [
                          playerPoint(),
                          contest(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contest() {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 4),
              child: Column(
                children: <Widget>[
                  Row(
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
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 24,
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
    );
  }

  ScrollController _scrollController = new ScrollController();
  TabController? controller;
  final PageController pageController = PageController(initialPage: 0);

  Widget contestsListData() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: ContestTabHeader(controller!),
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
          ),
        ],
      ),
    );
  }

  Widget playerPoint() {
    return Column(
      children: [
        Container(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Players",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: HexColor(
                      '#AAAFBC',
                    ),
                  ),
                ),
                Text(
                  'POINTS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/8.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Faf du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '58.0',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/11.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '20.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/115.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rohit Sharma',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '101.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/117.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shikhar Dhavan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '200.3',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/119.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Virat Kohali',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '195.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/123.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'MS Dhoni',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '137.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/131.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shami',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '452.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/159.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '136.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/161.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'hashim Amla',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '364.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/163.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Fat du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '108.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/167.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Lungi Ngidi',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '95.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/175.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Dale Steyn',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '203.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  int pageNumber = 0;
}
