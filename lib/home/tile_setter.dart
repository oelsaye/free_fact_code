import 'package:free_fact/api_stuff/api.dart';
import 'package:free_fact/user_models/user.dart';
import 'package:free_fact/services/database.dart';
import 'package:free_fact/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:free_fact/shared/constants.dart';
import 'package:provider/provider.dart';

class TileSetter extends StatefulWidget {
  const TileSetter({Key? key}) : super(key: key);

  @override
  _TileSetterState createState() => _TileSetterState();
}

class _TileSetterState extends State<TileSetter> {


  final _formKey = GlobalKey<FormState>();
  final List<String> factType = ['Basic Fact', 'Special Fact'];

  String? fact;

  //form values
  String? _currentFact;
  String? _currentFactType;
  int? _currentColor;
  Map <String, dynamic>? _currentPictures;
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

            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Create your own fact!',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  //Text field for the user to input their own fact
                  TextFormField(
                    initialValue: 'Insert Fact',
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentFact = val),
                  ),
                  SizedBox(height: 20.0,),
                  //dropdown menu to take in a type of fact, either Special or Basic
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentFactType ?? userData?.data['typeName'],
                    items: factType.map((factTypes) {
                      return DropdownMenuItem(
                        value: factTypes,
                        child: Text(factTypes),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentFactType = val.toString()),
                  ),
                  SizedBox(height: 20.0,),
                  //Creates a row of colours for users to choose
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 50,
                          color: Colors.pinkAccent,
                          splashColor: Colors.pinkAccent,
                          onPressed: () {
                            _currentColor = 1;
                          },
                          icon: Icon(Icons.circle, color: Colors.pinkAccent)
                      ),
                      SizedBox(width: 20.0,),
                      IconButton(
                          iconSize: 50,
                          color: Colors.lightBlueAccent,
                          splashColor: Colors.lightBlueAccent,
                          onPressed: () {
                            _currentColor = 2;
                          },
                          icon: Icon(Icons.circle, color: Colors.lightBlueAccent)
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  //Button which updates and uses the selections
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      API startup = API();
                      await startup.getAge();
                      fact = startup.fact;
                      if (_formKey.currentState!.validate()) {

                        //Creates a firebase map to refresh and update all firebase variables
                        Map<String, dynamic> newData = {
                          'typeName': _currentFactType ?? userData!.data['typeName'],
                          'fact': _currentFact ?? userData!.data['fact'],
                          'colorNumber': _currentColor ?? userData!.data['colorNumber'],
                          'pictures': _currentPictures ?? userData!.data['pictures'],
                          'typeFact': _currentPictures ?? userData!.data['typeFact'],
                          'color': _currentPictures ?? userData!.data['color'],
                        };

                        if (_currentFact != null && _currentColor != null && _currentFactType != null)
                        {
                          newData['pictures'].add(_currentFact);
                          newData['color'].add(_currentColor);
                          newData['typeFact'].add(_currentFactType);
                        }

                        await DatabaseService(uid: user.uid).updateUserData(newData);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
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
