import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tempalteflutter/constance/routes.dart';
import 'package:tempalteflutter/modules/login/otpValidationScreen.dart';
import 'package:tempalteflutter/modules/register/registerScreen.dart';
import 'package:tempalteflutter/modules/register/registerView.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../utils/dialogs.dart';

class Mycontroller {
  handleGoogleLogin(context) async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gauth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gauth.accessToken, idToken: gauth.idToken);

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RegisterScreen(),
            )));
  }

  loginwithphonenumber(String phonenumebr,context) async {
   await FirebaseAuth.instance.verifyPhoneNumber(
   verificationCompleted: (PhoneAuthCredential credential) async {

    await FirebaseAuth.instance.signInWithCredential(credential);
  },
    // timeout: const Duration(seconds: 60),
    verificationFailed: (FirebaseAuthException e) {
    if (e.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
    },
  phoneNumber: phonenumebr,
  codeSent: (String verificationId, int? resendToken) async {
Navigator.push(context, MaterialPageRoute(builder: (context) => OtpValidationScreen(
  verificationId: verificationId,
),));
  print('verification id:: $verificationId');
  }, 
  codeAutoRetrievalTimeout: (String verificationId) { 
print(('code auto retrive'));
  }, 
);
  }

  logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil(
              Routes.LOGIN, (Route<dynamic> route) => false);
      print("succeed but routes error "); 
    } on Exception {
      Dialogs.showDialogWithOneButton(
        context,
        "Error",
        "please! try again.",
        onButtonPress: () {
          return null;
        },
      );
    }
  }

 
 Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
   

      await FirebaseAuth.instance.verifyPhoneNumber(
        codeAutoRetrievalTimeout: (verificationId) {
          
        },
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          ScaffoldMessengerState().showSnackBar(SnackBar(content: Text(e.toString())));
        },
        codeSent: (String verificationId, int? resendToken) async {
          Navigator.push(context,MaterialPageRoute(builder: (context) => OtpValidationScreen(verificationId: verificationId),));
         

             
        },
       
      );
    }
  }


