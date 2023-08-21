// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tempalteflutter/bloc/standingsTabBloc.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/sharedPreferences.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/contests/contestsScreen.dart';
import 'package:tempalteflutter/modules/home/homeScreen.dart';
import 'package:tempalteflutter/modules/home/machTimerView.dart';
import 'package:tempalteflutter/modules/notification/notificationScreen.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';

class StandingScreen extends StatefulWidget {
  final void Function()? menuCallBack;
  final VoidCallback? upComingMatchesClick;

  const StandingScreen({Key? key, this.menuCallBack, this.upComingMatchesClick}) : super(key: key);
  @override
  _StandingScreenState createState() => _StandingScreenState();
}

class _StandingScreenState extends State<StandingScreen> with SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  final standingsTabBloc = StandingsTabBloc(StandingsTabBlocState.initial());
  late TabController controller;
  double _appBarHeight = 100.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  late UserData userData;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyF = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyL = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyR = new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    updateData();
    controller = new TabController(length: 3, vsync: this);
    standingsTabBloc.cleanList();
  }

  updateData() async {
    userData = (await MySharedPreferences().getUserData())!;
    setState(() {});
  }

  void openDrawer() {
    widget.menuCallBack!();
  }

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
          Icon(
            Icons.sort,
            color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
          )
        ],
      ),
    );
  }

  Widget notificationButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationScreen(),
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.notifications,
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              leading: Container(),
              expandedHeight: _appBarHeight,
              pinned: _appBarBehavior == AppBarBehavior.pinned,
              floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
              snap: _appBarBehavior == AppBarBehavior.snapping,
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              primary: true,
              centerTitle: false,
              flexibleSpace: sliverText(),
              elevation: 0.0,
              actions: <Widget>[
                drawerButton(),
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: PersistentHeader(controller),
            ),
          ];
        },
        body: Container(
          color: AllCoustomTheme.getThemeData().backgroundColor,
          child: TabBarView(
            controller: controller,
            children: <Widget>[
              StandingsTabScreen(
                tabType: TabType.Upcoming,
                refreshIndicatorKey: refreshIndicatorKeyF,
                context: context,
                standingsTabBloc: standingsTabBloc,
                upComingMatchesClick: () {
                  widget.upComingMatchesClick!();
                },
                click: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContestsScreen(),
                    ),
                  );
                  standingsTabBloc.cleanList();
                },
              ),
              StandingsTabScreen(
                upComingMatchesClick: () {
                  widget.upComingMatchesClick!();
                },
                tabType: TabType.Live,
                refreshIndicatorKey: refreshIndicatorKeyL,
                context: context,
                standingsTabBloc: standingsTabBloc,
                click: () async {
                  standingsTabBloc.cleanList();
                },
              ),
              StandingsTabScreen(
                tabType: TabType.Results,
                refreshIndicatorKey: refreshIndicatorKeyR,
                upComingMatchesClick: () {
                  widget.upComingMatchesClick!();
                },
                standingsTabBloc: standingsTabBloc,
                context: context,
                click: () async {
                  standingsTabBloc.cleanList();
                },
              ),
            ],
          ),
        ),
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
                fontSize: 26,
                color: AllCoustomTheme.getThemeData().backgroundColor,
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

enum TabType { Upcoming, Live, Results }

class StandingsTabScreen extends StatelessWidget {
  final Function()? click;
  final VoidCallback? upComingMatchesClick;
  final StandingsTabBloc? standingsTabBloc;
  final TabType? tabType;
  final GlobalKey<RefreshIndicatorState>? refreshIndicatorKey;
  final BuildContext? context;

  const StandingsTabScreen({
    Key? key,
    this.click,
    this.upComingMatchesClick,
    this.standingsTabBloc,
    this.tabType,
    this.refreshIndicatorKey,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: standingsTabBloc,
        builder: (context, StandingsTabBlocState state) {
          return standingsTabBloc!.getData(tabType!).length == 0 && state.isProgress
              ? Container(
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                        child: standingsTabBloc!.getData(tabType!).length > 0
                            ? Container(
                                child: RefreshIndicator(
                                  key: refreshIndicatorKey,
                                  onRefresh: () async {
                                    if (tabType == TabType.Upcoming) {
                                      await standingsTabBloc!.upcoming();
                                    } else if (tabType == TabType.Live) {
                                      await standingsTabBloc!.live();
                                    } else if (tabType == TabType.Results) {
                                      await standingsTabBloc!.results();
                                    }
                                  },
                                  child: ListView.builder(
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return listItems();
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: RefreshIndicator(
                                        key: refreshIndicatorKey,
                                        onRefresh: () async {
                                          if (tabType == TabType.Upcoming) {
                                            await standingsTabBloc!.upcoming();
                                          } else if (tabType == TabType.Live) {
                                            await standingsTabBloc!.live();
                                          } else if (tabType == TabType.Results) {
                                            await standingsTabBloc!.results();
                                          }
                                        },
                                        child: ListView.builder(
                                          itemCount: standingsTabBloc!.getScheduleData().length,
                                          itemBuilder: (context, index) {
                                            return index == 0 ? infoView() : sheduallist(standingsTabBloc!.getScheduleData()[index]);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                  ],
                );
        },
      ),
    );
  }

  Widget infoView() {
    var txt = '';
    if (tabType == TabType.Upcoming) {
      txt = 'upcoming';
    } else if (tabType == TabType.Live) {
      txt = 'live';
    } else {
      txt = 'completed recently';
    }
    return Container(
      color: AllCoustomTheme.getThemeData().backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          Container(
            width: 120,
            height: 120,
            child: Image.asset(
              ConstanceData.cupImage,
              width: 80,
              height: 80,
              scale: 0.2,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Text(
              tabType == TabType.Upcoming ? "You haven't joined any $txt contests" : "You haven't joined any contests that are $txt",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE14,
                color: AllCoustomTheme.getTextThemeColors(),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Join contests for any of the upcoming matches',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: ConstanceData.SIZE_TITLE14,
              color: AllCoustomTheme.getTextThemeColors(),
            ),
          ),
          SizedBox(
            height: 34,
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }

  Widget listItems() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            click!();
          },
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          'Lineups Out',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/19.png'),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            'South Africa vs India',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE12,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      'SA',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'vs',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                      fontWeight: FontWeight.bold,
                                      color: AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Text(
                                      'IND',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE14,
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Mon, 9 Sep',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset('assets/25.png'),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 0, right: 8, bottom: 8, top: 4),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '2',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE14,
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          '  contest joined',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE14,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.5),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  String getData(ShedualData shedualData) {
    var timeCountDountxt = '';
    final date = DateFormat('yyyy-MM-dd').parse(shedualData.dateStart!);
    final today = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
    print(today);
    if (today.difference(date).inDays == 1) {
      timeCountDountxt = 'Yesterday';
    } else {
      timeCountDountxt = DateFormat.E().format(date) + ', ' + DateFormat.d().format(date) + ' ' + DateFormat.MMM().format(date);
    }
    return timeCountDountxt;
  }

  Widget sheduallist(ShedualData shedualData) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            if (shedualData.preSquad == 'true') {
              Navigator.push(
                context!,
                MaterialPageRoute(
                  builder: (context) => ContestsScreen(),
                ),
              );
            } else {
              showInSnackBar('Contests for this match will open soon. Stay tuned!');
            }
          },
          onLongPress: () {
            if (shedualData.preSquad == 'true') {
              showModalBottomSheet<void>(
                context: context!,
                builder: (
                  BuildContext context,
                ) =>
                    UnderGroundDrawer(shedualData: shedualData),
              );
            } else {
              showInSnackBar('Contests for this match will open soon. Stay tuned!');
            }
          },
          child: Opacity(
            opacity: shedualData.preSquad == 'true' ? 1.0 : 0.4,
            child: Column(
              children: <Widget>[
                shedualData.lineupsOut == 'true'
                    ? Container(
                        padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text(
                                'Lineups Out',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ConstanceData.SIZE_TITLE12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox(),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    top: shedualData.lineupsOut == 'true' ? 0 : 16,
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        child: new CachedNetworkImage(
                          imageUrl: shedualData.teamLogo!.a!.logoUrl!,
                          placeholder: (context, url) => Center(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Text(
                              shedualData.seriesName!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE12,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Text(
                                        shedualData.teamLogo!.a!.shortName!,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          fontWeight: FontWeight.bold,
                                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'vs',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(right: 8),
                                      child: Text(
                                        shedualData.teamLogo!.b!.shortName!,
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          fontWeight: FontWeight.bold,
                                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            TimerView(
                              dateStart: shedualData.dateStart,
                              timestart: shedualData.timeStart,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: new CachedNetworkImage(
                          imageUrl: shedualData.teamLogo!.b!.logoUrl!,
                          placeholder: (context, url) => Center(
                            child: Container(
                              padding: EdgeInsets.all(12),
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => new Icon(Icons.error),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
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
    );
  }

  void showInSnackBar(String value) {
    var snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: new Text(
        value,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ConstanceData.SIZE_TITLE14,
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
      ),
    );

    ScaffoldMessenger.of(context!).showSnackBar(snackBar);
  }
}

class UnderGroundDrawer extends StatefulWidget {
  final ShedualData? shedualData;

  const UnderGroundDrawer({Key? key, this.shedualData}) : super(key: key);
  @override
  _UnderGroundDrawerState createState() => _UnderGroundDrawerState();
}

class _UnderGroundDrawerState extends State<UnderGroundDrawer> {
  bool isLoginProsses = false;
  @override
  void initState() {
    getMatchInfo();
    super.initState();
  }

  Future<Null> getMatchInfo() async {
    setState(() {
      isLoginProsses = true;
    });

    setState(() {
      isLoginProsses = false;
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          matchSchedulData(),
          Divider(
            height: 1,
          ),
          Expanded(
            child: matchInfoList(),
          ),
        ],
      ),
    );
  }

  Widget matchInfoList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Match',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'SA vs IND',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Series',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'ICC Cricket World Cup',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Start Date',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        '2019-09-05',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Start Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        '15:00:00',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Venue',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'India',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Umpires',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Martine',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Referee',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Charls piter',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Match Format',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Match Formate',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Location',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'India',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }

  Widget matchSchedulData() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      color: AllCoustomTheme.buildLightTheme().bottomAppBarColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.asset('assets/19.png'),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 4),
            child: new Text(
              'SA',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              'vs',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: new Text(
              'IND',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4),
            child: Container(
              child: Container(
                width: 50,
                height: 50,
                child: Image.asset('assets/25.png'),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
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
        ],
      ),
    );
  }
}
