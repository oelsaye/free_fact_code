import 'package:flutter/material.dart';
import 'package:free_fact/authenticate/sign_in.dart';
import 'package:free_fact/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }


  @override
  Widget build(BuildContext context) {
    //Toggles between the sign in page and the register page
    if (showSignIn == true)
      {
        return SignIn(toggleView: toggleView);
      }
    else
      {
        return Register(toggleView: toggleView);
      }
  }
}
