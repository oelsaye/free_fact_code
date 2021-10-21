import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_fact/user_models/user.dart';
import 'package:free_fact/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  //create user object based on firebase user
  Users? _userFromFirebaseUser(User? user)
  {
    return user != null ? Users(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Users?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign up with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      //create new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData({
        'typeName': 'Basic Fact',
        'fact': 'Insert Fact',
        'colorNumber': 1,
        'pictures': [
        ],
        'typeFact': [
        ],
        'color': [
        ],
      });

      return _userFromFirebaseUser(user);


    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

}