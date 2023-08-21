// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/cityResponseData.dart';
import 'package:tempalteflutter/models/countryResponseData.dart';
import 'package:tempalteflutter/models/stateResponseData.dart';
import 'package:tempalteflutter/modules/home/tabScreen.dart';
import 'package:tempalteflutter/modules/login/continuebutton.dart';
import 'package:tempalteflutter/modules/login/loginScreen.dart';

class RegisterView extends StatefulWidget {
  final void Function()? callBack;

  const RegisterView({Key? key, this.callBack}) : super(key: key);
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  var countryList = <CountryList>[];
  var stateList = <StateList>[];
  var cityList = <CityList>[];

  var imageUrl = '';
  var userNameController = new TextEditingController();
  var emailController = new TextEditingController();
  var referCodeController = new TextEditingController();
  var phoneController = new TextEditingController();

  var userNameFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var dobFocusNode = FocusNode();
  var stateFocusNode = FocusNode();
  var cityFocusNode = FocusNode();
  var referFocusNode = FocusNode();
  var date = DateTime.now();
  var isLoginProsses = false;
  CountryList selectedCountry = new CountryList();
  StateList slectedState = new StateList();

  CityList slectedCity = new CityList();

  String countryCode = "";
  File? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    slectedState = StateList(name: 'selecte your state');
    stateList.insert(0, slectedState);
    slectedCity = CityList(name: 'selecte your city');
    cityList.insert(0, slectedCity);
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    referCodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoginProsses,
      color: Colors.transparent,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 0, top: 50),
            child: Container(
              padding: EdgeInsets.only(bottom: 0),
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getThemeData().backgroundColor,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.text,
                                    controller: userNameController,
                                    decoration: InputDecoration(
                                      hintText: "User Name",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Date of Birth",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: "Gender",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Enter State Name",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Enter City Name",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Refer Code",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 60,
                            child: Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: TextField(
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                      fillColor: Colors.black,
                                      border: InputBorder.none,
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: ConstanceData.SIZE_TITLE16,
                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14, left: 14, bottom: 14),
                      child: ContinueButton(
                        name: "Next",
                        callBack: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          _submit();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 96,
                  width: 96,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(color: Colors.black45, offset: Offset(1.1, 1.1), blurRadius: 3.0),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new ClipRRect(
                        borderRadius: new BorderRadius.circular(48.0),
                        child: Container(
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Container(
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 48,
                              child: _image == null
                                  ? loginUserData.image == '' || loginUserData.image == null
                                      ? Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                ConstanceData.playerImage,
                                              ),
                                            ),
                                          ),
                                        )
                                      : new CachedNetworkImage(
                                          imageUrl: imageUrl,
                                          placeholder: (context, url) => CircularProgressIndicator(
                                            strokeWidth: 2.0,
                                          ),
                                          errorWidget: (context, url, error) => new Icon(Icons.error),
                                          fit: BoxFit.cover,
                                        )
                                  : new Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    ),
                              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                new Positioned(
                  left: 70.0,
                  top: 70.0,
                  child: Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Colors.black54, offset: Offset(1.1, 1.1), blurRadius: 2.0),
                      ],
                    ),
                    height: 20,
                    width: 20,
                    child: GestureDetector(
                      child: new CircleAvatar(
                        backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
                        child: Icon(Icons.edit, size: 14, color: AllCoustomTheme.getThemeData().primaryColor),
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  var genderList = ['male', 'female', 'other'];
  var selectedGender = 'male';
  var genderListIndex = 0;

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TabScreen(),
      ),
    );
  }
}
