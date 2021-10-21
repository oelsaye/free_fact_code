import 'package:flutter/material.dart';
import 'package:free_fact/services/auth.dart';
import 'package:free_fact/authenticate/authenticate.dart';
import 'package:free_fact/shared/constants.dart';
import 'package:free_fact/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String dropdownValue = 'Month';
  String actualvalue = 'Month';

  String dropdownValue2 = 'Year';
  String actualvalue2 = 'Year';

  bool checkDropdown1 = false;
  bool checkDropdown2 = false;


  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        elevation: 0.0,
        title: Text('Sign in to Free Fact'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget> [
              SizedBox(height: 20.0,),
              //Creates a text field with a validator to get a valid email input
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email',),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              //Creates a text field with a validator, as well as obscured/hidden text to get a valid password input
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password',),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),

              SizedBox(height: 30.0,),

              Container(
                color: Colors.white,
                width: 200,
                //Creates a row of dropdown menus for the user to input their general date of birth
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.brown,),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.brown),
                      underline: Container(
                        height: 2,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          actualvalue = dropdownValue;
                          if (dropdownValue == 'Month')
                          {
                            checkDropdown1 = false;
                          }
                          else
                          {
                            checkDropdown1 = true;
                          }
                        });
                      },
                      items: <String>['Month', 'January', 'February', 'March',
                        'April', 'May', 'June', 'July',
                        'August', 'September', 'October', 'November', 'December'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),

                    SizedBox(width: 30.0,),

                    DropdownButton<String>(
                      dropdownColor: Colors.white,
                      value: dropdownValue2,
                      icon: const Icon(Icons.arrow_drop_down_circle, color: Colors.brown,),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.brown),
                      underline: Container(
                        height: 2,
                      ),

                      onChanged: (String? newValue2) {
                        setState(() {
                          dropdownValue2 = newValue2!;
                          actualvalue2 = dropdownValue2;
                          if (dropdownValue2 == 'Year')
                          {
                            checkDropdown2 = false;
                          }
                          else
                          {
                            checkDropdown2 = true;
                          }
                        });
                      },
                      items: <String>['Year', '1995', '1996', '1997',
                        '1998', '1999', '2000', '2001',
                        '2002', '2003', '2004', '2005'
                      ].map<DropdownMenuItem<String>>((String value2) {
                        return DropdownMenuItem<String>(
                          value: value2,
                          child: Text(value2),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () async {
                  //Checks if all sections of the date of birth have been selected
                  if (checkDropdown1 == true && checkDropdown2 == true)
                    {
                      //Checks if all text validators are true
                      if (_formKey.currentState!.validate())
                      {
                        //Try to login
                        setState(() => loading = true);
                        dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                        if (result == null)
                        {
                          //If the user inputted invalidated info, return an error
                          setState(()
                          {
                            error = 'Incorrect email or password';
                            loading = false;
                          });
                        }
                      }
                    }
                  else
                    {
                      setState(()
                      {
                        error = 'Incorrect date of birth';
                        loading = false;
                      });
                    }
                },
                color: Colors.pink[400],
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),

              SizedBox(height: 20.0,),

              Text("Don't have an account?"),
              SizedBox(height: 10.0,),

              RaisedButton.icon(
                icon: Icon(Icons.person),
                label: Text('Register'),
                onPressed: () {
                  widget.toggleView();
                },
              ),

              SizedBox(height: 30.0,),

              //Text("OR", style: TextStyle(color: Colors.black, fontSize: 20)),
              SizedBox(height: 30.0,),

              const Image(
                height: 120,
                image: NetworkImage('assets/logo.png'),
              ),

              /*
              Text("Browse as a Guest"),

              SizedBox(height: 10.0,),

              RaisedButton(
                onPressed: () async {

                  setState(() => loading = true);
                  dynamic result = await _auth.signInAnon();

                  if (result == null)
                  {
                    setState(()
                    {
                      error = 'Incorrect email or password';
                      loading = false;
                    });
                  }
                },
                color: Colors.blueGrey,
                child: const Text(
                  'Guest',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),


              ),*/
            ],
          ),
        )
      ),
    );
  }
}
