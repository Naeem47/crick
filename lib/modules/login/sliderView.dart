// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';

class SliderView extends StatefulWidget {
  @override
  _SliderViewState createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  var pageController = PageController(initialPage: 0);

  int pageNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              child: PageView(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (number) {
                  setState(() {
                    pageNumber = number;
                  });
                },
                children: <Widget>[
                  ImageListView(
                    imageAsset: 'assets/cricketImage1.png',
                    txt: 'Select A Match',
                    subTxt: 'Select any of the upcoming matches from any of the current or\nupcoming cricket series',
                  ),
                  ImageListView(
                    imageAsset: 'assets/cricketImage2.png',
                    txt: 'Join A Contest',
                    subTxt:
                        'join any free or cash contest to win cash and the ultimate\nbragging rights to showoff your improvement in the free/Skill\ncontests on Fixturers!',
                  ),
                  ImageListView(
                    imageAsset: 'assets/cricketImage3.png',
                    txt: 'Create Your Team',
                    subTxt: 'Use your sports knowledge and showcase your skills to create\nyour team within a budget of 100 credits',
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: pageNumber == 0
                    ? AllCoustomTheme.getThemeData().backgroundColor
                    : AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
                radius: 6,
              ),
              SizedBox(
                width: 6,
              ),
              CircleAvatar(
                backgroundColor: pageNumber == 1
                    ? AllCoustomTheme.getThemeData().backgroundColor
                    : AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
                radius: 6,
              ),
              SizedBox(
                width: 6,
              ),
              CircleAvatar(
                backgroundColor: pageNumber == 2
                    ? AllCoustomTheme.getThemeData().backgroundColor
                    : AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
                radius: 6,
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),

          // PageIndicator(
          //   layout: PageIndicatorLayout.WARM,
          //   size: 10.0,
          //   controller: pageController,
          //   space: 5.0,
          //   count: 3,
          //   color: AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
          //   activeColor: AllCoustomTheme.getThemeData().backgroundColor,
          // ),
        ],
      ),
    );
  }
}

class ImageListView extends StatelessWidget {
  final String? imageAsset;
  final String? txt;
  final String? subTxt;

  const ImageListView({Key? key, this.imageAsset, this.txt = '', this.subTxt = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width - 60,
              child: Image.asset(imageAsset!),
            ),
          ),
        ],
      ),
    );
  }
}
