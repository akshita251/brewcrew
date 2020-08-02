import 'package:brew/screens/authenticate/signIn.dart';
import 'package:brew/screens/authenticate/signUp.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Container(
        child: SignIn(toggleView: toggleView),
      );
    } else {
      return Container(
        child: SignUp(toggleView: toggleView),
      );
    }
  }
}
