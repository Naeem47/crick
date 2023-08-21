// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

class PublicProfileScreen extends StatefulWidget {
  final String? userId;

  const PublicProfileScreen({Key? key, this.userId}) : super(key: key);
  @override
  _PublicProfileScreenState createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen>
    with SingleTickerProviderStateMixin {
  var name = '';
  late TabController controller;
  var imageUrl = '';
  ScrollController _scrollController = new ScrollController();
  late UserData userData;

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
              colors: [
                AllCoustomTheme.getThemeData().primaryColor,
                AllCoustomTheme.getThemeData().primaryColor,
                AllCoustomTheme.getThemeData().backgroundColor,
                AllCoustomTheme.getThemeData().backgroundColor,
              ],
            ),
          ),
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
            body: Stack(
              children: <Widget>[
                ModalProgressHUD(
                  inAsyncCall: userData != null ? false : true,
                  color: Colors.transparent,
                  progressIndicator: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                  child: userData != null
                      ? NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: AppBarHeader(
                                  userData,
                                  () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              SliverPersistentHeader(
                                pinned: true,
                                delegate: PersistentHeader(controller),
                              ),
                            ];
                          },
                          body: Container(
                            color:
                                AllCoustomTheme.getThemeData().backgroundColor,
                            child: TabBarView(
                              controller: controller,
                              children: <Widget>[
                                AccountInfoScreen(
                                  userData: userData,
                                ),
                                PlayingHistory(
                                  userData: userData,
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 44,
            width: 44,
            child: AvatarImage(
              sizeValue: 44,
              radius: 44,
              isCircle: true,
              imageUrl: imageUrl,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            '$name',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 26,
              color: AllCoustomTheme.getThemeData().backgroundColor,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfoScreen extends StatelessWidget {
  final UserData? userData;

  const AccountInfoScreen({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
      body: Container(
        child: ModalProgressHUD(
          inAsyncCall: userData != null ? false : true,
          color: Colors.transparent,
          progressIndicator: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: userData!.name != ''
                ? Container(
                    padding: EdgeInsets.only(top: 16),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  userData!.name!,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  userData!.email!,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'Mobile No',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  userData!.mobileNumber!,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'Date of Birth',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  DateFormat('dd MMM, yyyy').format(
                                      DateFormat('dd/MM/yyyy')
                                          .parse(userData!.dob!)),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  userData!.gender![0].toUpperCase() +
                                      userData!.gender!.substring(1),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'Country',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  userData!.country == '' ? 'India' : '',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'State',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  userData!.state!,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          padding: EdgeInsets.only(
                              right: 16, left: 16, top: 16, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                child: Text(
                                  'City',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    color: AllCoustomTheme.getTextThemeColors(),
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  userData!.city!,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ),
        ),
      ),
    );
  }
}

class PlayingHistory extends StatelessWidget {
  final UserData? userData;

  const PlayingHistory({Key? key, this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Center(
        child: ModalProgressHUD(
          inAsyncCall: userData != null ? false : true,
          color: Colors.transparent,
          progressIndicator: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
          child: userData!.name != ''
              ? Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          right: 16, left: 16, top: 16, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              'Contests',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              userData!.totalLeague! == ''
                                  ? '0'
                                  : userData!.totalLeague!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(
                          right: 16, left: 16, top: 16, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              'Matches',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              userData!.totalMatches! == ''
                                  ? '0'
                                  : userData!.totalMatches!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(
                          right: 16, left: 16, top: 16, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              'Series',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              userData!.totalSeries! == ''
                                  ? '0'
                                  : userData!.totalSeries!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(
                          right: 16, left: 16, top: 16, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: 100,
                            child: Text(
                              'Wins',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              userData!.totalWins! == ''
                                  ? '0'
                                  : userData!.totalWins!,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : SizedBox(),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
              new Tab(text: 'Account Info'),
              new Tab(text: 'Playing History'),
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

class AppBarHeader extends SliverPersistentHeaderDelegate {
  final UserData userData;
  final VoidCallback callBack;

  AppBarHeader(
    this.userData,
    this.callBack,
  );

  String getName() {
    final txt = userData.name!.trim().split(' ');
    return txt[0][0].toUpperCase() + txt[0].substring(1, txt[0].length);
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 4, right: 16),
          height: AppBar().preferredSize.height,
          color: AllCoustomTheme.getThemeData().primaryColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 48,
                height: AppBar().preferredSize.height,
                child: IconButton(
                  onPressed: () {
                    callBack();
                  },
                  icon: Icon(
                    Icons.close,
                    color: AllCoustomTheme.getThemeData().backgroundColor,
                  ),
                ),
              ),
              Container(
                height: AppBar().preferredSize.height - 4,
                width: AppBar().preferredSize.height - 4,
                child: AvatarImage(
                  sizeValue: AppBar().preferredSize.height - 16,
                  radius: AppBar().preferredSize.height - 16,
                  isCircle: true,
                  imageUrl: userData.image!,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                getName(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 26,
                  color: AllCoustomTheme.getThemeData().backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => AppBar().preferredSize.height;

  @override
  double get minExtent => AppBar().preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
