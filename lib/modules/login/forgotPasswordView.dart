import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';

class ForgotPasswordView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(12),
            child: Center(
              child: Text(
                'Forgot password?',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: ConstanceData.SIZE_TITLE14,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
