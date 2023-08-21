// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/bankListResponseData.dart';
import 'package:tempalteflutter/models/userData.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  var paymet = '';
  var isProsses = false;
  var paymentController = new TextEditingController();
  List<AccountDetail> accountDetailList = <AccountDetail>[];
  UserData user = new UserData();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    paymentController.text = paymet;
    getBankData();
    super.initState();
  }

  @override
  void dispose() {
    paymentController.dispose();
    super.dispose();
  }

  void getBankData() async {
    setState(() {
      isProsses = true;
    });

    var profileData = ApiProvider().getProfile();
    if (profileData != null && profileData.data != null) {
      setState(() {
        user = profileData.data!;
      });
    }

    setState(() {
      isProsses = false;
    });
  }

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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            SafeArea(
              child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
                body: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Column(
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
                                          'Withdraw',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: AllCoustomTheme.getThemeData().backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: AppBar().preferredSize.height,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ModalProgressHUD(
                            inAsyncCall: isProsses,
                            color: Colors.transparent,
                            progressIndicator: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                            child: isProsses && user == null
                                ? SizedBox()
                                : SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 16),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Your Winnings Prices',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                                  fontSize: ConstanceData.SIZE_TITLE14,
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Text(
                                                user != null
                                                    ? user.winingAmount != ''
                                                        ? '₹${user.winingAmount}'
                                                        : '₹100'
                                                    : '₹100',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                                  fontSize: ConstanceData.SIZE_TITLE18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 4,
                                            left: 8,
                                            right: 8,
                                            bottom: 4,
                                          ),
                                          child: bankAccountList(),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                          child: Container(
                                            padding: EdgeInsets.only(left: 8, right: 8),
                                            child: TextFormField(
                                              controller: paymentController,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: ConstanceData.SIZE_TITLE16,
                                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                              ),
                                              autofocus: true,
                                              keyboardType: TextInputType.number,
                                              decoration: new InputDecoration(
                                                prefix: Text(
                                                  '₹',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                              inputFormatters: [
                                                // WhitelistingTextInputFormatter.digitsOnly,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 4,
                                            left: 16,
                                            right: 16,
                                            bottom: 16,
                                          ),
                                          child: Text(
                                            'min ₹200 & max ₹10,000 allowed per day',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE14,
                                              color: Colors.grey.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          height: 60,
                                          padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: AllCoustomTheme.getThemeData().primaryColor,
                                                    borderRadius: new BorderRadius.circular(4.0),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                                    ],
                                                  ),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      borderRadius: new BorderRadius.circular(4.0),
                                                      onTap: () async {
                                                        clickPayment();
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          'Add cash'.toUpperCase(),
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: ConstanceData.SIZE_TITLE12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bankAccountList() {
    var list = <Widget>[];
    accountDetailList.forEach((data) {
      list.add(
        Container(
          height: 70,
          padding: EdgeInsets.only(left: 8, right: 8),
          child: InkWell(
            onTap: () {
              getSetData(data.bankAccountId!);
            },
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 20,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: data.isSelected! ? AllCoustomTheme.getThemeData().primaryColor : Colors.transparent,
                            borderRadius: new BorderRadius.circular(32.0),
                            border: new Border.all(
                              width: 2.0,
                              color: data.isSelected!
                                  ? AllCoustomTheme.getThemeData().primaryColor
                                  : AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Center(
                              child: Center(
                                child: Icon(
                                  Icons.check,
                                  size: ConstanceData.SIZE_TITLE16,
                                  color: AllCoustomTheme.getThemeData().backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '${data.branchName}',
                                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: ConstanceData.SIZE_TITLE14),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 4),
                                child: Text(
                                  'A/C ${data.accountNo}',
                                  style: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: ConstanceData.SIZE_TITLE14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                ),
              ],
            ),
          ),
        ),
      );
    });
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: list,
      ),
    );
  }

  void getSetData(String bankId) {
    setState(() {
      accountDetailList.forEach((bankData) {
        if (bankData.bankAccountId == bankId) {
          bankData.isSelected = !bankData.isSelected!;
        } else {
          bankData.isSelected = false;
        }
      });
    });
  }

  String selectedBankId() {
    var selectedId = '';
    accountDetailList.forEach((data) {
      if (data.isSelected!) {
        selectedId = data.bankAccountId!;
        return;
      }
    });
    return selectedId;
  }

  void clickPayment() async {
    setState(() {
      isProsses = true;
    });
    if (selectedBankId() == '') {
      showInSnackBar('Please! select bank account');
    } else {
      var money = int.tryParse(paymentController.text);
      if (money != null && money >= 200 && money <= 10000) {
        if (selectedBankId() != '') {}
      } else {
        showInSnackBar('min ₹200 & max ₹10,000 only allowed');
      }
    }
    setState(() {
      isProsses = false;
    });
  }

  void showInSnackBar(String value) {
    var snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: new Text(
        value,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ConstanceData.SIZE_TITLE14,
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
