// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/validator/validator.dart';

class CreateContestScreen extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const CreateContestScreen({Key? key, this.titel, this.country1Name, this.country1Flag, this.country2Name, this.country2Flag, this.time, this.price})
      : super(key: key);
  @override
  _CreateContestScreenState createState() => _CreateContestScreenState();
}

class _CreateContestScreenState extends State<CreateContestScreen> {
  bool isProsses = false;
  var pAmout = '';
  var cSize = '';
  var totalWinningamount = 0;
  var contestSize = 0;
  var contestName = '';
  var entryfee = '';
  var finalEntryfee = 0.0;
  Timer? timer;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var amountController = new TextEditingController();
  var sizeController = new TextEditingController();
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
              key: _scaffoldKey,
              backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
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
                                      'Make your own Contest',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: AllCoustomTheme.getThemeData().backgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: AllCoustomTheme.getThemeData().backgroundColor,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 36,
                                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(widget.country1Flag!),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          widget.country1Name!,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          'vs',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: Text(
                                          widget.country2Name!,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            color: AllCoustomTheme.getThemeData().primaryColor,
                                            fontSize: ConstanceData.SIZE_TITLE12,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(widget.country2Flag!),
                                      ),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Container(
                                        child: Text(
                                          widget.time!,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: HexColor(
                                              '#AAAFBC',
                                            ),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: contestsData(),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: double.infinity,
                      child: Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                        child: Opacity(
                          opacity: finalEntryfee == 0.0 || isProsses ? 0.2 : 1.0,
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
                                  if (finalEntryfee != 0.0 && isProsses == false) {
                                    if (contestName != '') {
                                    } else {
                                      showInSnackBar('Please Enter Contest name.');
                                    }
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    finalEntryfee != 0.0 ? 'Choose winning Breakup'.toUpperCase() : 'CREATE CONTEST',
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget contestsData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new TextField(
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
              onChanged: (txt) {
                contestName = txt;
              },
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: new InputDecoration(
                labelText: 'Contest Name',
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new TextField(
              controller: amountController,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'winning amount (Rs).',
                counterStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 0,
                  color: Colors.transparent,
                ),
              ),
              maxLength: 5,
              onChanged: (txt) {
                final isDigitsOnly = int.tryParse(txt) ?? 0;
                if (isDigitsOnly == null) {
                  showInSnackBar('Input needs to be digits only');
                } else {
                  if (isDigitsOnly > 10000) {
                    totalWinningamount = 0;
                    if (pAmout != amountController.text) {
                      pAmout = amountController.text;
                      showInSnackBar('Incorrect winning amount entered.\nPlease choose a winning amount between 0 and 10,000.');
                    }
                  } else {
                    totalWinningamount = isDigitsOnly;
                    setCalculation();
                  }
                }
              },
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 4),
            child: Row(
              children: <Widget>[
                Text(
                  'Min 0',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontFamily: 'Poppins', color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE12),
                ),
              ],
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new TextField(
              controller: sizeController,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Contest size.',
                counterStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 0,
                  color: Colors.transparent,
                ),
              ),
              maxLength: 3,
              onChanged: (txt) {
                final isDigitsOnly = int.tryParse(txt) ?? 0;
                if (isDigitsOnly == null) {
                  showInSnackBar('Input needs to be digits only');
                } else {
                  if ((isDigitsOnly > 500 || isDigitsOnly < 2) && isDigitsOnly != 0) {
                    contestSize = 0;
                    if (cSize != sizeController.text) {
                      cSize = sizeController.text;
                      showInSnackBar('Incorrect contest size entered.\nPlease choose a contest size between 2 and 500.');
                    }
                  } else {
                    contestSize = isDigitsOnly;
                    setCalculation();
                  }
                }
              },
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 4),
            child: Row(
              children: <Widget>[
                Text(
                  'Min 2',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontFamily: 'Poppins', color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE12),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Divider(
              height: 1,
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Entry Per Team',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                fontWeight: FontWeight.bold,
                                fontSize: ConstanceData.SIZE_TITLE16),
                          ),
                        ]),
                      ),
                    ),
                    isProsses
                        ? Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.0,
                              ),
                            ),
                          )
                        : RichText(
                            text: TextSpan(
                              children: [
                                entryfee != ''
                                    ? TextSpan(
                                        text: ':  ',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ConstanceData.SIZE_TITLE16),
                                      )
                                    : TextSpan(
                                        text: '',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ConstanceData.SIZE_TITLE16),
                                      ),
                                entryfee != ''
                                    ? TextSpan(
                                        text: '₹ $entryfee',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: ConstanceData.SIZE_TITLE16),
                                      )
                                    : TextSpan(
                                        text: '',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                            fontWeight: FontWeight.bold,
                                            fontSize: ConstanceData.SIZE_TITLE16),
                                      ),
                              ],
                            ),
                          ),
                  ],
                ),
                Container(
                  child: Text(
                    'Entry is calculated based on total prize \n amount & contest size.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins', color: AllCoustomTheme.getTextThemeColors(), fontSize: ConstanceData.SIZE_TITLE16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  setCalculation() {
    timer!.cancel();
    setState(() {
      isProsses = true;
    });
    timer = new Timer(new Duration(seconds: 3), () {
      setValidCalculation();
      setState(() {
        isProsses = false;
      });
    });
  }

  void setValidCalculation() {
    if (totalWinningamount > 0 && totalWinningamount <= 10000 && contestSize > 1 && contestSize <= 500) {
      var totalAmount = (totalWinningamount / 100) * 20;
      totalAmount += totalWinningamount;
      var entryfees = totalAmount / contestSize;
      print(totalAmount);
      print(entryfees);
      if (entryfees < 5) {
        setState(() {
          entryfee = '';
          finalEntryfee = 0.0;
        });
        showInSnackBar('Entry Fee cannot be less than Rs.5');
      } else {
        setState(() {
          finalEntryfee = double.parse('${entryfees.toStringAsFixed(2)}');
          entryfee = '${entryfees.toStringAsFixed(2)}';
        });
      }
    } else {
      setState(() {
        entryfee = '';
        finalEntryfee = 0.0;
      });
    }
  }

  void showInSnackBar(String value, {bool isGreeen = false}) {
    var snackBar = SnackBar(
      backgroundColor: isGreeen ? Colors.green : Colors.red,
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
