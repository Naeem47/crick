import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/widgets/createTeamClipper.dart';

class CreateTeamProgressbarView extends StatelessWidget {
  final int? teamCount;

  const CreateTeamProgressbarView({Key? key, this.teamCount = 0})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Center(
        child: Stack(
          children: <Widget>[
            new ClipPath(
              clipper: CreateTeamClipper(
                  teamCount: 11, gap: 4, lead: 10, totalCount: 11),
              child: Container(
                height: 16,
                color: Colors.white,
              ),
            ),
            new ClipPath(
              clipper: CreateTeamClipper(
                  teamCount: teamCount!, gap: 4, lead: 10, totalCount: 11),
              child: Container(
                height: 16,
                color: Colors.green,
              ),
            ),
            Container(
              height: 16,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 11,
                itemBuilder: (context, index) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 32) / 11,
                    height: 16,
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: teamCount == index + 1
                                ? Colors.white
                                : index + 1 == 11
                                    ? Colors.black
                                    : Colors.transparent,
                            fontSize: MediaQuery.of(context).size.width > 360
                                ? ConstanceData.SIZE_TITLE12
                                : ConstanceData.SIZE_TITLE10),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
