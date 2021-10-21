import 'package:flutter/material.dart';
import 'package:free_fact/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_fact/services/database.dart';
import 'package:provider/provider.dart';
import 'package:free_fact/home/type_checker.dart';
import 'package:free_fact/user_models/type.dart';
import 'package:free_fact/home/tile_setter.dart';
import 'package:free_fact/api_stuff/api.dart';
import 'package:free_fact/home/authenticate_home.dart';

class Storage extends StatefulWidget {
  Storage({required this.toggleView});
  final Function toggleView;

  @override
  State<Storage> createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  int? counter = 0;

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    //Create function for the settings
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: TileSetter(),
        );
      });
    }
    return StreamProvider<List<Type>?>.value(
      value: DatabaseService(uid: '').type,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text('Storage'),
          backgroundColor: Colors.pink[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
                print("Signed Out");
              },
              icon: Icon(Icons.person, color: Colors.white),
              label: Text('Logout', style: TextStyle(color: Colors.white),),
            ),
            FlatButton.icon(
              onPressed: () {
                _showSettingsPanel();
              },
              icon: Icon(Icons.settings, color: Colors.white),
              label: Text('Settings', style: TextStyle(color: Colors.white),),
            ),
            FlatButton.icon(
              onPressed: () async {
                widget.toggleView();
              },
              icon: Icon(Icons.search, color: Colors.white),
              label: Text('Browse', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
        body: Container(
            child: TypeChecker()
        ),
      ),
    );
  }
}
