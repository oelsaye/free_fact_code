import 'package:flutter/material.dart';
import 'package:free_fact/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_fact/services/database.dart';
import 'package:provider/provider.dart';
import 'package:free_fact/user_models/type.dart';
import 'package:free_fact/home/tile_setter.dart';
import 'package:free_fact/api_stuff/api.dart';
import 'package:free_fact/user_models/user.dart';
import 'package:free_fact/shared/loading.dart';


class Home extends StatefulWidget {
  Home({required this.toggleView});
  final Function toggleView;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? currentfact = 'joe';

  int? counter = 0;

  int randomColor = 2;

  Color getColor() {
    Color color;

    if(randomColor.isEven) {
      color = Colors.pinkAccent;
    } else {
      color = Colors.lightBlueAccent;
    }
    return color;
  }

  String getText() {
    String theText;
    if(randomColor.isEven) {
      theText = 'Special Fact';
    } else {
      theText = 'Basic Fact';
    }
    return theText;
  }

  Future<void> getFact() async {
    API startup = API();
    await startup.getAge();
    fact = startup.fact!;
  }

  String fact = "There was once one person in the world";

  bool checker = true;

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

    final user = Provider.of<Users>(context);
    getFact();

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData)
          {
            UserData? userData = snapshot.data;
            return StreamProvider<List<Type>?>.value(
              value: DatabaseService(uid: '').type,
              initialData: [],
              child: Scaffold(
                backgroundColor: Colors.lightBlueAccent,
                appBar: AppBar(
                  title: Text('Free Fact'),
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
                      icon: Icon(Icons.settings, color: Colors.white,),
                      label: Text('Settings', style: TextStyle(color: Colors.white),),
                    ),
                    FlatButton.icon(
                      onPressed: () async {
                        widget.toggleView();
                        getFact();
                      },
                      icon: Icon(Icons.storage_rounded, color: Colors.white),
                      label: Text('Storage', style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
                body: Container(
                  child: Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          Card(
                            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 25.0,
                                backgroundColor: getColor(),
                              ),
                              title: Text(fact),
                              subtitle: Text(getText()),
                            ),
                          ),

                          SizedBox(height: 10.0,),

                          RaisedButton(
                              color: Colors.pink[400],
                              child: Text(
                                'New Fact',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                API startup = API();
                                await startup.getAge();
                                fact = startup.fact!;
                                setState(() {randomColor = randomColor + 1;});
                              }
                          ),
                        ],
                      )
                  ),
                ),
              ),
            );
          }
          else {
            return Loading();
          }
        }
    );

  }
}
