import 'dart:ui';

import 'package:intl/intl.dart';

class Validators {
  bool emailValidator(String email) {
    const Pattern _pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp _regex = new RegExp(_pattern.toString());

    if (_regex.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  phoneValidator(String phone) {
    if (phone.length > 5) {
      return true;
    } else {
      return false;
    }
  }

  passwordValidator(String password) {
    if (password.length > 6) {
      return true;
    } else {
      return false;
    }
  }

  String timeForApi(int seconds) {
    var secondOfDate = new DateTime.fromMillisecondsSinceEpoch(seconds);
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedString = formatter.format(secondOfDate);
    return formattedString;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
