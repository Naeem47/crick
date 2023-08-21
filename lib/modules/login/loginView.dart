// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/validator/validator.dart';

class LoginView extends StatefulWidget {
  final void Function(String? emailtxt, String? password)? loginCallBack;

  const LoginView({Key? key, this.loginCallBack}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  DateTime date = DateTime.now();
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  var emailFocusNode = FocusNode();
  var passwordFocusNode = FocusNode();
  var _obscureConfirmText = true;
  final _formKey = GlobalKey<FormState>();

  var emailtxt = '';
  var password = '';

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordController.dispose();
    emailController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email can not be empty';
    } else {
      if (!Validators().emailValidator(value)) {
        return 'Email is not valid';
      } else {
        return null;
      }
    }
  }

  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password can not be empty';
    } else {
      if (!Validators().passwordValidator(value)) {
        return 'Password length should be greater than 6 chars.';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 8, bottom: 4, right: 16),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 19),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              decoration: new BoxDecoration(
                color: AllCoustomTheme.getThemeData().backgroundColor,
                borderRadius: new BorderRadius.circular(12.0),
                border: new Border.all(
                  width: 1.0,
                  color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(color: AllCoustomTheme.getTextThemeColors().withOpacity(0.5), offset: Offset(0, 1), blurRadius: 3.0),
                ],
              ),
              child: Form(
                key: _formKey,
                child: new Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      new Container(
                        child: new TextFormField(
                          controller: emailController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                          autofocus: false,
                          focusNode: emailFocusNode,
                          keyboardType: TextInputType.emailAddress,
                          decoration: new InputDecoration(
                              labelText: 'Email',
                              icon: Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Icon(Icons.person),
                              )),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(passwordFocusNode);
                          },
                          validator: _validateEmail,
                          onSaved: (value) {
                            emailtxt = value!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      new Container(
                        child: new TextFormField(
                          controller: passwordController,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          ),
                          autofocus: false,
                          focusNode: passwordFocusNode,
                          keyboardType: TextInputType.text,
                          obscureText: _obscureConfirmText,
                          decoration: new InputDecoration(
                            labelStyle: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                            labelText: 'Password',
                            icon: Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: GestureDetector(
                              dragStartBehavior: DragStartBehavior.down,
                              onTap: () {
                                setState(() {
                                  _obscureConfirmText = !_obscureConfirmText;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 14),
                                child: Icon(
                                  _obscureConfirmText ? Icons.visibility_off : Icons.visibility,
                                  semanticLabel: _obscureConfirmText ? 'show password' : 'hide password',
                                ),
                              ),
                            ),
                          ),
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            _submit();
                          },
                          validator: _validatePassword,
                          onSaved: (value) {
                            password = value!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              color: AllCoustomTheme.getThemeData().primaryColor,
              borderRadius: new BorderRadius.circular(50.0),
              boxShadow: <BoxShadow>[
                BoxShadow(color: AllCoustomTheme.getBlackAndWhiteThemeColors().withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: new BorderRadius.circular(50.0),
                onTap: () {
                  _submit();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 10, left: 75, right: 75, bottom: 10),
                  child: Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: AllCoustomTheme.getThemeData().backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState!.validate() == false) {
      return;
    }
    _formKey.currentState!.save();
    widget.loginCallBack!(emailtxt, password);
  }
}
