import 'package:flutter/material.dart';
import 'package:free_fact/home/home.dart';
import 'package:free_fact/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:free_fact/user_models/user.dart';
import 'package:free_fact/home/authenticate_home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users?>(context);

    //return either Home or Authenticate widget
    if (user == null){
      return Authenticate();
    }
    else
      {
        return AuthenticateHome();
      }
  }
}
