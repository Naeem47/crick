import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tempalteflutter/modules/home/tabScreen.dart';
import 'package:tempalteflutter/modules/login/loginScreen.dart';

class Authpage extends StatelessWidget {
  const Authpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream:FirebaseAuth.instance.authStateChanges() ,builder:(context, snapshot) {
        if(snapshot.hasData){
          return  TabScreen();
        }else{
         return  LoginScreen();
        }
      } , ),
    );
  }
}