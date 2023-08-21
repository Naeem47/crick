// ignore_for_file: deprecated_member_use, unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/bankListResponseData.dart';
import 'package:tempalteflutter/models/bankinfoResponce.dart';

class BankAccountVerificationScreen extends StatefulWidget {
  @override
  _BankAccountVerificationScreenState createState() => _BankAccountVerificationScreenState();
}

class _BankAccountVerificationScreenState extends State<BankAccountVerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;
  bool isFirstTime = true;
  bool emialApproved = false;
  bool pancardApproved = false;
  bool isVerify = false;
  var pancardDetail = PancardDetail();
  var date = DateTime.now();

  var acountNameController = new TextEditingController();
  var acountNoController = new TextEditingController();
  var ifscCodeController = new TextEditingController();
  var branchNameController = new TextEditingController();
  var addressController = new TextEditingController();
  List<AccountDetail> accountDetail = <AccountDetail>[];

  @override
  void initState() {
    getPancardData();
    super.initState();
  }

  void getPancardData() async {
    setState(() {
      isProsses = true;
      emialApproved = true;
    });

    setState(() {
      isFirstTime = false;
      isProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: FloatingActionButton(
                  foregroundColor: AllCoustomTheme.getThemeData().backgroundColor,
                  backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ADDBankAccount(),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                ),
              ),
              key: _scaffoldKey,
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: ModalProgressHUD(
                inAsyncCall: isProsses,
                color: Colors.transparent,
                progressIndicator: CircularProgressIndicator(
                  strokeWidth: 2.0,
                ),
                child: !isFirstTime
                    ? emialApproved && pancardApproved
                        ? accountDetail.length == 0 && isProsses
                            ? SizedBox()
                            : accountDetail.length == 0
                                ? Container(
                                    padding: EdgeInsets.only(bottom: 150),
                                    child: Center(
                                      child: Text(
                                        'please! add bank account',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.grey,
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                        ),
                                      ),
                                    ),
                                  )
                                : expandData()
                        : Container(
                            padding: EdgeInsets.only(bottom: 150),
                            child: Center(
                              child: Text(
                                'please! you first verify your both\npan and email detail',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            ),
                          )
                    : SizedBox(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget expandData() {
    return Container(
      padding: EdgeInsets.only(),
      width: double.infinity,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: accountDetail.length,
        itemBuilder: (context, index) => AccountView(
          accountDetail: accountDetail[index],
        ),
      ),
    );
  }
}

class AccountView extends StatelessWidget {
  final AccountDetail? accountDetail;

  const AccountView({Key? key, this.accountDetail}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: double.infinity,
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          accountDetail!.branchName!,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: ConstanceData.SIZE_TITLE16,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          'A/C ${accountDetail!.accountNo}',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: ConstanceData.SIZE_TITLE14),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        child: Text(
                          accountDetail!.status == "1"
                              ? 'Pending'
                              : accountDetail!.status == "2"
                                  ? 'Approved'
                                  : accountDetail!.status == "3"
                                      ? 'Rejected'
                                      : '',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: accountDetail!.status == "1"
                                  ? Colors.grey.withOpacity(0.5)
                                  : accountDetail!.status == "2"
                                      ? Colors.green
                                      : accountDetail!.status == "3"
                                          ? Colors.red
                                          : Colors.grey,
                              fontSize: ConstanceData.SIZE_TITLE14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
          ),
        ],
      ),
    );
  }
}

class ADDBankAccount extends StatefulWidget {
  final VoidCallback? callback;

  const ADDBankAccount({Key? key, this.callback}) : super(key: key);

  @override
  _ADDBankAccountState createState() => _ADDBankAccountState();
}

class _ADDBankAccountState extends State<ADDBankAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;
  File? _image;
  var pancardDetail = PancardDetail();
  var date = DateTime.now();

  var acountNameController = new TextEditingController();
  var acountNoController = new TextEditingController();
  var ifscCodeController = new TextEditingController();
  var branchNameController = new TextEditingController();
  var addressController = new TextEditingController();

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
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: Column(
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
                                    'Add Bank Account',
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
                              )
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
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: expandData(),
                              ),
                            ),
                            Container(
                              height: 60,
                              padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
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
                                    onTap: () async {},
                                    child: Center(
                                      child: Text(
                                        'Update',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: AllCoustomTheme.getThemeData().backgroundColor,
                                          fontSize: ConstanceData.SIZE_TITLE16,
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
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expandData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Bank passbook/cheque photo',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE12,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getThemeData().primaryColor,
                borderRadius: new BorderRadius.circular(4.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                ],
              ),
              child: InkWell(
                onTap: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Upload account proof',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getThemeData().backgroundColor,
                          fontSize: ConstanceData.SIZE_TITLE16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new Container(
              child: new TextField(
                controller: acountNoController,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                ),
                autofocus: false,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: 'Bank Account No',
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (value) {
                  pancardDetail.accountNo = value;
                },
                // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new Container(
              child: new TextField(
                controller: acountNameController,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                ),
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Account Name',
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (value) {
                  pancardDetail.accountName = value;
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new Container(
              child: new TextField(
                controller: branchNameController,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                ),
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'Bank Name',
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                onChanged: (value) {
                  pancardDetail.branchName = value;
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new Container(
              child: new TextField(
                controller: ifscCodeController,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                ),
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'IFSC code',
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new Container(
              child: new TextField(
                controller: addressController,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE16,
                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                ),
                autofocus: false,
                decoration: new InputDecoration(
                  labelText: 'address',
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value, {bool isGreen = false}) {
    var snackBar = SnackBar(
      backgroundColor: isGreen ? Colors.green : Colors.red,
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
