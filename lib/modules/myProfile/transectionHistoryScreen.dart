// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/models/transactionResponse.dart';
import 'package:tempalteflutter/validator/validator.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:url_launcher/url_launcher.dart';

class TransectionHistoryScreen extends StatefulWidget {
  @override
  _TransectionHistoryScreenState createState() => _TransectionHistoryScreenState();
}

class _TransectionHistoryScreenState extends State<TransectionHistoryScreen> {
  var transactionList = <Transaction>[];
  bool isProsses = false;
  var transactionModiFiedDataList = <TransactionModiFiedDataList>[];
  bool isPopupOpen = false;
  var toDate = DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(DateTime.now()));
  var fromDate = DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(DateTime.now().subtract(Duration(days: 30))));
  var nowDate = DateFormat('dd/MM/yyyy').parse(DateFormat('dd/MM/yyyy').format(DateTime.now()));
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    setState(() {
      isProsses = true;
    });

    var responseData = await ApiProvider().getTransaction();

    setState(() {
      transactionList = responseData.transaction!;
    });

    transactionList.forEach((data) {
      if (isMach(DateFormat('dd/MM/yyyy').parse(data.time!.split(',')[0]).millisecondsSinceEpoch.toString())) {
        transactionModiFiedDataList.forEach((tdate) {
          if (tdate.date == DateFormat('dd/MM/yyyy').parse(data.time!.split(',')[0]).millisecondsSinceEpoch.toString()) {
            tdate.transaction!.add(data);
          }
        });
      } else {
        var newList = TransactionModiFiedDataList();
        newList.date = DateFormat('dd/MM/yyyy').parse(data.time!.split(',')[0]).millisecondsSinceEpoch.toString();
        newList.transaction = [data];
        transactionModiFiedDataList.add(newList);
      }
    });

    transactionModiFiedDataList.sort((a, b) => int.tryParse(b.date!)!.compareTo(int.tryParse(a.date!)!));

    setState(() {
      isProsses = false;
    });
  }

  bool isMach(String time) {
    bool isMach = false;
    transactionModiFiedDataList.forEach((tData) {
      if (tData.date == time) {
        isMach = true;
        return;
      }
    });
    return isMach;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isPopupOpen) {
          setState(() {
            isPopupOpen = false;
          });
          return false;
        } else {
          return true;
        }
      },
      child: Container(
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
                                          'History',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: ConstanceData.SIZE_TITLE20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isPopupOpen = true;
                                          });
                                        },
                                        child: Container(
                                          width: AppBar().preferredSize.height,
                                          height: AppBar().preferredSize.height,
                                          child: Icon(
                                            Icons.receipt,
                                            color: Colors.white,
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
                        Expanded(
                          child: ModalProgressHUD(
                            inAsyncCall: isProsses,
                            color: Colors.transparent,
                            progressIndicator: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                            child: listData(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            isPopupOpen
                ? Container(
                    child: Scaffold(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      body: Container(
                        child: SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Container(
                                  decoration: new BoxDecoration(
                                    color: AllCoustomTheme.getThemeData().backgroundColor,
                                    borderRadius: new BorderRadius.circular(4.0),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(top: 16, bottom: 8, right: 16),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              child: Text(
                                                'Selecte Date',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  isPopupOpen = false;
                                                });
                                              },
                                              child: Container(
                                                width: 30,
                                                height: 30,
                                                child: Icon(Icons.close),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: InkWell(
                                          onTap: () {
                                            showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return _buildBottomPicker(
                                                  CupertinoDatePicker(
                                                    mode: CupertinoDatePickerMode.date,
                                                    initialDateTime: fromDate,
                                                    onDateTimeChanged: (DateTime newDateTime) {
                                                      setState(() => fromDate = newDateTime);
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 16, right: 16),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 12),
                                                        child: Text(
                                                          'From',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontSize: ConstanceData.SIZE_TITLE12,
                                                            color: HexColor('#8C8C8C'),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: Text(
                                                          DateFormat.yMMMMd().format(fromDate),
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontSize: ConstanceData.SIZE_TITLE16,
                                                            color: nowDate.difference(fromDate).inDays >= 0 &&
                                                                    fromDate.difference(toDate).inDays <= 0 &&
                                                                    toDate != fromDate
                                                                ? AllCoustomTheme.getBlackAndWhiteThemeColors()
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 12),
                                                        child: Container(
                                                          height: 1.2,
                                                          color: HexColor('#8C8C8C'),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        child: InkWell(
                                          onTap: () {
                                            showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return _buildBottomPicker(
                                                  CupertinoDatePicker(
                                                    mode: CupertinoDatePickerMode.date,
                                                    initialDateTime: toDate,
                                                    onDateTimeChanged: (DateTime newDateTime) {
                                                      setState(() => toDate = newDateTime);
                                                    },
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 16, right: 16),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 12),
                                                        child: Text(
                                                          'To',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontSize: ConstanceData.SIZE_TITLE12,
                                                            color: HexColor('#8C8C8C'),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 4),
                                                        child: Text(
                                                          DateFormat.yMMMMd().format(toDate),
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            fontSize: ConstanceData.SIZE_TITLE16,
                                                            color: nowDate.difference(toDate).inDays >= 0 &&
                                                                    toDate.difference(fromDate).inDays >= 0 &&
                                                                    toDate != fromDate
                                                                ? AllCoustomTheme.getBlackAndWhiteThemeColors()
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 12),
                                                        child: Container(
                                                          height: 1.2,
                                                          color: HexColor('#8C8C8C'),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        child: Container(
                                          height: 70,
                                          padding: EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 10),
                                          child: Opacity(
                                            opacity: fromDate.compareTo(toDate) > 0 || toDate == fromDate ? 0.2 : 1.0,
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
                                                    if (fromDate.compareTo(toDate) > 0 || toDate == fromDate) {
                                                    } else {
                                                      setState(() {
                                                        isPopupOpen = false;
                                                      });
                                                    }
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      'GET Invoice'.toUpperCase(),
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
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  void getBanckStatementPDF() async {
    setState(() {
      isProsses = true;
    });
    var url = 'https:\/\/starsportsfantasy.com\/Fantasy\/statement\/bankstatement937205614.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    setState(() {
      isProsses = false;
    });
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

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: GestureDetector(
          onTap: () {},
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }

  Widget listData() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: transactionModiFiedDataList.length,
      itemBuilder: (context, index) {
        return StickyHeaderBuilder(
          builder: (BuildContext context, double stuckAmount) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Container(
                    color: Theme.of(context).backgroundColor.withOpacity(0.1),
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                        '${DateFormat('dd MMM, yyyy').format(DateTime.fromMillisecondsSinceEpoch(int.tryParse(transactionModiFiedDataList[index].date!)!))}',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors()),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          content: Column(
            children: <Widget>[
              Divider(
                height: 1,
              ),
              new Container(
                padding: EdgeInsets.all(16),
                child: getSubList(
                  transactionModiFiedDataList[index],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getSubList(TransactionModiFiedDataList data) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          data.transaction![index].isExpanded = !isExpanded;
        });
      },
      children: data.transaction!.map<ExpansionPanel>((Transaction listData) {
        return ExpansionPanel(
          canTapOnHeader: true,
          isExpanded: listData.isExpanded!,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              height: 44,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16),
                      child: Text(
                        listData.type == 'RECEIVE' ? '+ ₹ ${listData.amount}' : '- ₹ ${listData.amount}',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      '${listData.remark}',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE14,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          body: Container(
            child: Column(
              children: <Widget>[
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.only(right: 16, left: 16, bottom: 16, top: 16),
                  child: Column(
                    children: <Widget>[
                      listData.statusRequest != ''
                          ? Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: listData.statusRequest == '1' ? Colors.green : Colors.grey.withOpacity(0.5),
                                            border: Border.all(
                                              color: AllCoustomTheme.getThemeData().backgroundColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.done,
                                            color: AllCoustomTheme.getThemeData().backgroundColor,
                                            size: 12,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 2,
                                            color: listData.statusProcess == '1' ? Colors.green : Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: listData.statusProcess == '1' ? Colors.green : Colors.grey.withOpacity(0.5),
                                            border: Border.all(
                                              color: AllCoustomTheme.getThemeData().backgroundColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.done,
                                            color: AllCoustomTheme.getThemeData().backgroundColor,
                                            size: 12,
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 2,
                                            color: listData.statusCredit == '1' ? Colors.green : Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: listData.statusCredit == '1' ? Colors.green : Colors.grey.withOpacity(0.5),
                                            border: Border.all(
                                              color: AllCoustomTheme.getThemeData().backgroundColor,
                                              width: 2,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.done,
                                            color: AllCoustomTheme.getThemeData().backgroundColor,
                                            size: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            width: 120,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Withdrawal\nRequested',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: ConstanceData.SIZE_TITLE14,
                                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'Withdrawal\nProcessed',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE14,
                                              color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            width: 120,
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              'Amount\nCredited',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: ConstanceData.SIZE_TITLE14,
                                                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          : SizedBox(),
                      listData.statusRequest != ''
                          ? Divider(
                              height: 1,
                            )
                          : SizedBox(),
                      Container(
                        padding: EdgeInsets.only(right: 16, left: 16, top: listData.statusRequest != '' ? 16 : 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 120,
                              child: Text(
                                'Transaction Id',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                listData.transactionId!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 120,
                              child: Text(
                                'Transaction Date',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                DateFormat('dd MMM, HH:mm:ss a').format(DateFormat('dd/MM/yyyy,HH:mm:ss a').parse(listData.time!)),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 120,
                              child: Text(
                                'TeamName',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                listData.teamName!,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
