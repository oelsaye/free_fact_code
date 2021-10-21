import 'package:flutter/material.dart';
import 'package:free_fact/home/home.dart';
import 'package:free_fact/home/storage.dart';

class AuthenticateHome extends StatefulWidget {
  const AuthenticateHome({Key? key}) : super(key: key);

  @override
  _AuthenticateHomeState createState() => _AuthenticateHomeState();
}

class _AuthenticateHomeState extends State<AuthenticateHome> {

  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }


  @override
  Widget build(BuildContext context) {
    //Switches between the home page and the storage page
    if (showSignIn == true)
    {
      return Home(toggleView: toggleView);
    }
    else
    {
      return Storage(toggleView: toggleView);
    }
  }
}
