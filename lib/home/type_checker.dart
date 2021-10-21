import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:free_fact/user_models/type.dart';
import 'package:free_fact/home/type_tiler.dart';
import 'package:free_fact/user_models/user.dart';
import 'package:free_fact/services/database.dart';
import 'package:free_fact/shared/loading.dart';

class TypeChecker extends StatefulWidget {
  TypeChecker({Key? key}) : super(key: key);

  @override
  _TypeCheckerState createState() => _TypeCheckerState();
}

class _TypeCheckerState extends State<TypeChecker> {

  String? fact;
  bool checker = true;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {
            UserData? userData = snapshot.data;
            return ListView.builder(
              itemCount: userData?.data['pictures'].length,
              itemBuilder: (context, index) {

                //Creates a tile with all the selected info by the user
                return TypeTiler(types: userData?.data['pictures'][index], type: userData?.data['typeFact'][index], colour: userData?.data['color'][index]);
              },
            );
          }
          else {
            return Loading();
          }
        }
    );

  }
}
