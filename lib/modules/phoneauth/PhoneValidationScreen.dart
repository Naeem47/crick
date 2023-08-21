// ignore_for_file: unused_element, deprecated_member_use

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/bloc/phoneEnteryBloc.dart';
import 'package:tempalteflutter/bloc/phoneVerificationBloc.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/controller/controller.dart';
import 'package:tempalteflutter/modules/login/continuebutton.dart';
import 'package:tempalteflutter/constance/global.dart' as globals;
import 'package:tempalteflutter/modules/login/otpTimer.dart';
import 'package:tempalteflutter/modules/login/otpValidationScreen.dart';
import 'package:url_launcher/url_launcher.dart';

var selectedCountryCode = '91';

class PhoneValidationScreen extends StatefulWidget {
  const PhoneValidationScreen({
    super.key,
  });

  @override
  _PhoneValidationScreenState createState() => _PhoneValidationScreenState();
}

class _PhoneValidationScreenState extends State<PhoneValidationScreen>
    with TickerProviderStateMixin {
  FirebaseAuth auth = FirebaseAuth.instance;

  late AnimationController _animationController;

  final phoneEntryBloc = PhoneEntryBloc(PhoneEntryBlocState.initial());

  String countryCode = "91";

  var phonNumberContorller = new TextEditingController();
  var phoneFocusNode = FocusNode();
  var phonNumber = '';

  var isLoginProsses = false;
  bool ismove = false;

  @override
  void initState() {
    globals.phoneVerificationBloc =
        PhoneVerificationBloc(PhoneVerificationBlocState.initial());
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 400));
    super.initState();
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    phonNumberContorller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().backgroundColor,
        ),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                ),
              ),
              title: Text(
                'Crick11',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getThemeData().primaryColor,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: ModalProgressHUD(
              inAsyncCall: isLoginProsses,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: ListView(
                  children: [
                    _row1(),
                    _phonNumber(),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'By continue, you are agree to our ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                      color: AllCoustomTheme.getThemeData()
                                          .primaryColor,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () async {
                                        const url =
                                            ConstanceData.TermsofService;
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    text: '\n & ',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                      color: AllCoustomTheme.getThemeData()
                                          .primaryColor,
                                    ),
                                    recognizer: new TapGestureRecognizer()
                                      ..onTap = () async {
                                        const url = ConstanceData.PrivacyPolicy;
                                        if (await canLaunch(url)) {
                                          await launch(url);
                                        } else {
                                          throw 'Could not launch $url';
                                        }
                                      },
                                  ),
                                  TextSpan(
                                    text: '.',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14, left: 14),
                      child: ContinueButton(
                        name: "Next",
                        callBack: () async {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: countryCode + phonNumberContorller.text.trim() ,
                            verificationCompleted:
                                (PhoneAuthCredential credential) async{
                                  await auth.signInWithCredential(credential);
                                },
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtpValidationScreen(
                                      verificationId: verificationId,
                                    ),
                                  ));
                            },
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );


                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _help() {
    return Container(
      padding: EdgeInsets.only(top: 28, right: 10),
      child: Row(
        children: <Widget>[
          Icon(
            FontAwesomeIcons.questionCircle,
            size: 14,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            'Help',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: ConstanceData.SIZE_TITLE10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _row1() {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Please enter your 10-digit\nmobile number.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: ConstanceData.SIZE_TITLE14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _phonNumber() {
    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 80,
            height: 60,
            child: CountryCodePicker(
              onChanged: (e) {
                print(e.toLongString());
                print(e.name);
                print(e.code);
                print(e.dialCode);
                setState(() {
                  countryCode = e.dialCode!;
                });
              },
              initialSelection: 'भारत',
              showFlagMain: true,
              showFlag: true,
              favorite: ['+91', 'भारत'],
            ),
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              child: BlocBuilder(
                bloc: phoneEntryBloc,
                builder: (BuildContext context, PhoneEntryBlocState state) =>
                    Theme(
                  data: AllCoustomTheme.buildLightTheme().copyWith(
                      backgroundColor: Colors.transparent,
                      scaffoldBackgroundColor: Colors.transparent),
                  child: TextField(
                    controller: phonNumberContorller,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE16,
                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                    ),
                    autofocus: true,
                    focusNode: phoneFocusNode,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: 'Mobile Number',
                      errorText: state.isPhoneError
                          ? 'phone length should be proper.'
                          : null,
                      prefix: Text("$countryCode"),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onChanged: (txt) {
                      phoneEntryBloc.onPhoneChanges(txt);
                      if (txt.length > 4) {
                        _animationController.forward();
                      } else {
                        _animationController.reverse();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
