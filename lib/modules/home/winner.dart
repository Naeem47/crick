import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tempalteflutter/constance/constance.dart';

class Winner extends StatefulWidget {
  const Winner({Key? key}) : super(key: key);

  @override
  _WinnerState createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Column(
              children: [
                Text(
                  "Mega Contest Winner",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Recent Matches",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Text(
              "Filter by Series",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE12,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Icon(Icons.filter_list),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(right: 4, left: 4),
              children: [
                Column(
                  children: [
                    winnerDetails(
                      "BYJU's jharkhand T20",
                      "India",
                      "South Africa",
                      'assets/25.png',
                      'assets/19.png',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    winnerDetails(
                      'Fancode ECS T10-Sweden',
                      "Sri Lanka",
                      "Bangladesh",
                      'assets/21.png',
                      'assets/23.png',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    winnerDetails(
                      'ICC Cricket World Cup',
                      "Pakistan",
                      "West Indies",
                      'assets/13.png',
                      'assets/17.png',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    winnerDetails(
                      "English One-Day Cup",
                      "South Africa",
                      "India",
                      'assets/19.png',
                      'assets/25.png',
                    ),
                  ],
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget winnerDetails(
    String txt,
    String txt1,
    String txt2,
    String img1,
    String img2,
  ) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      txt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      "03, Aug, 2021",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1.3,
                ),
                Row(
                  children: [
                    Text(
                      txt1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Text(
                      txt2,
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
                  height: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset(img1),
                    ),
                    Text(
                      "Vs",
                      style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE12, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      child: Image.asset(img2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 1.3,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, top: 8),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.trophy,
                  size: 18,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "₹5",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE16,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Lakhs",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 180,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      rank("Rank #1", "Virat k 13", "won ₹9,000", ConstanceData.virat),
                      SizedBox(
                        width: 4,
                      ),
                      rank("Rank #2", "Dhoni k 13", "won ₹7,000", ConstanceData.dhoni),
                      SizedBox(
                        width: 4,
                      ),
                      rank("Rank #3", "Rehna k 13", "won ₹5,000", ConstanceData.playerImage),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rank(String txt1, String txt2, String txt3, String txt4) {
    return Card(
      elevation: 6,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Container(
        width: 130,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 6, right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    txt1,
                    style: TextStyle(fontFamily: 'Poppins', fontSize: ConstanceData.SIZE_TITLE12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    txt2,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE12,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                      right: 25,
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage(txt4),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  txt3,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
