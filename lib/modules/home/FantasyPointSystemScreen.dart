// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';

class FantasyPointSystemScreen extends StatefulWidget {
  @override
  _FantasyPointSystemScreenState createState() => _FantasyPointSystemScreenState();
}

class _FantasyPointSystemScreenState extends State<FantasyPointSystemScreen> {
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
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
          body: Column(
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
                                'How to Play',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
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
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(15),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        card(
                          'What is Fantasy',
                          FontAwesomeIcons.trophy,
                          AssetImage(
                            ConstanceData.palyerProfilePic,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        card(
                          'Cricket',
                          FontAwesomeIcons.bowlingBall,
                          AssetImage(
                            ConstanceData.cricketPlayer,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        card(
                          'Football',
                          FontAwesomeIcons.footballBall,
                          AssetImage(
                            ConstanceData.footballPlayer,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        card(
                          'Kabaddi',
                          Icons.sports_handball,
                          AssetImage(
                            ConstanceData.kabadiplayer,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget card(String txt1, IconData icon, AssetImage image) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(image: image, fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                txt1,
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: Colors.white,
                      letterSpacing: 0.6,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
