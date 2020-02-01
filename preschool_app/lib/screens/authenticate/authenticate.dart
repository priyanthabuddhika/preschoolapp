import 'package:flutter/material.dart';
import 'package:preschool_app/screens/authenticate/register.dart';
import 'package:preschool_app/screens/authenticate/signin.dart';

// This class is a wrapper class to switch between sign in and sign up

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
   // this value is used to switch between sign in and sign up screens
   bool showSignIn = true;

  // this function is used to switch between sign in and sign up screens
  void toggleView(){
   setState(() {
     showSignIn = !showSignIn;
   }); 
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView); // create Sign In screen
    }
    else{
      return Register(toggleView: toggleView); // Create Register Screen
    }
  }
}