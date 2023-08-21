import 'package:tempalteflutter/constance/global.dart' as globals;
import 'package:tempalteflutter/constance/sharedPreferences.dart';

class FirstTime {
  static getValues() async {
    globals.usertoken = (await MySharedPreferences().getUsertokenString())!;
    globals.userdata = await MySharedPreferences().getUserData();
  }
}
