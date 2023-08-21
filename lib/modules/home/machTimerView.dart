import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tempalteflutter/validator/validator.dart';

class TimerView extends StatefulWidget {
  final String? dateStart;
  final String? timestart;
  final TimerType? timerType;
  final double? fontSize;
  final bool? fontWeight;
  final Color? color;

  const TimerView({
    Key? key,
    this.dateStart = '',
    this.timestart = '',
    this.timerType = TimerType.isHomeScreen,
    this.fontSize = 14,
    this.fontWeight = true,
    this.color,
  }) : super(key: key);

  @override
  _TimerViewState createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  var timeCountDountxt = '15:15:00';
  Color colors = Colors.red;
  DateTime? finaledate;
  Timer? timer;
  bool isToday = false;

  @override
  void initState() {
    if (widget.color != null) {
      colors = widget.color!;
    }
    finaledate = DateFormat('yyyy-MM-dd HH:mm:ss')
        .parse(widget.dateStart! + " " + widget.timestart!);
    setTime();
    super.initState();
  }

  void setTime() {
    if (finaledate!.difference(DateTime.now()).inSeconds < 0) {
      setState(() {
        timeCountDountxt = '00' + ' : ' + '00' + ' : ' + '00';
      });
    } else {
      if (finaledate!.difference(DateTime.now()).inHours < 24) {
        isToday = false;
        timer?.cancel();
        setJustTime();
        timer = new Timer(new Duration(seconds: 1), () {
          setJustTime();
          setTime();
        });
      } else {
        isToday = true;
        final date = DateFormat('yyyy-MM-dd').parse(widget.dateStart!);
        final today = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
        print(today);
        if (date.difference(today).inDays == 1) {
          timeCountDountxt = 'Tomorrow';
        } else {
          if (!mounted) return;
          setState(() {
            timeCountDountxt = DateFormat.E().format(date) +
                ', ' +
                DateFormat.d().format(date) +
                ' ' +
                DateFormat.MMM().format(date);
          });
        }
      }
    }
  }

  void setJustTime() {
    final seconds = finaledate!.difference(DateTime.now()).inSeconds;
    if (!mounted) return;
    setState(() {
      timeCountDountxt = secondsToHoursMinutesSeconds(seconds);
    });
  }

  String secondsToHoursMinutesSeconds(int seconds) {
    var hourCount = seconds ~/ 3600;
    var minuteCount = (seconds % 3600) ~/ 60;
    var secondCount = (seconds % 3600) % 60;

    final finalHourText = hourCount < 10 ? '0$hourCount' : '$hourCount';
    final finalMinuteText = minuteCount < 10 ? '0$minuteCount' : '$minuteCount';
    final finalSecondText = secondCount < 10 ? '0$secondCount' : '$secondCount';
    var finaltext =
        finalHourText + ' : ' + finalMinuteText + ' : ' + finalSecondText;
    if (widget.timerType == TimerType.isHomeScreen) {
      finaltext =
          finalHourText + ' : ' + finalMinuteText + ' : ' + finalSecondText;
    } else if (widget.timerType == TimerType.isCreateTeam) {
      finaltext =
          finalHourText + ' : ' + finalMinuteText + ' : ' + finalSecondText;
    }
    return finaltext;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        timeCountDountxt,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: widget.fontSize,
          fontWeight: (widget.fontWeight! ? FontWeight.bold : FontWeight.normal),
          color: (widget.timerType == TimerType.isHomeScreen)
              ? !isToday
                  ? colors
                  : HexColor('#AAAFBC')
              : colors,
        ),
      ),
    );
  }
}

enum TimerType {
  isCreateTeam,
  isHomeScreen,
}
