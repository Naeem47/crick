import 'dart:math';
import 'package:flutter/material.dart';

class CreateTeamClipper extends CustomClipper<Path> {
  final int teamCount;
  final int totalCount;
  final int gap;
  final int lead;
  CreateTeamClipper({this.teamCount = 11, this.totalCount = 11, this.lead = 8, this.gap = 2});

  @override
  Path getClip(Size size) {
    final path = Path();
    final cellWidth = size.width / totalCount;
    path.moveTo(0, size.height);
    for (var i = 0; i < totalCount; i++) {
      if (teamCount >= i + 1) {
        if (i == 0) {
          path.lineTo(i * cellWidth, size.height);
          path.lineTo(i * cellWidth + lead, 0);
          path.lineTo(i * cellWidth + cellWidth + gap, 0);
          path.lineTo(i * cellWidth + cellWidth - lead + gap, size.height);
        } else if (i == totalCount - 1) {
          path.lineTo(i * cellWidth - gap, size.height);
          path.lineTo(i * cellWidth + lead - gap, 0);
          path.lineTo(i * cellWidth + cellWidth, 0);
          path.lineTo(i * cellWidth + cellWidth - lead, size.height);
        } else {
          path.lineTo(i * cellWidth - gap, size.height);
          path.lineTo(i * cellWidth + lead - gap, 0);
          path.lineTo(i * cellWidth + cellWidth + gap, 0);
          path.lineTo(i * cellWidth + cellWidth - lead + gap, size.height);
        }
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CreateTeamClipper oldClipper) => true;

  double degreeToRadians(double degree) {
    var redian = (pi / 180) * degree;

    return redian;
  }
}

class LinearGradientTeamClipper extends CustomClipper<Path> {
  final double lead;
  LinearGradientTeamClipper({this.lead = 8});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(lead, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width - lead, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(LinearGradientTeamClipper oldClipper) => true;
}
