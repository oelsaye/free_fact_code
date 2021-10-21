import 'package:free_fact/user_models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_fact/user_models/type.dart';
import 'package:free_fact/user_models/user.dart';

class DatabaseService {

  final String uid;
  DatabaseService({required this.uid});

  //collection reference
  final CollectionReference typeCollection = FirebaseFirestore.instance.collection('type');

  Future updateUserData(Map<String, dynamic> data) async {
    return await typeCollection.doc(uid).set(data);
  }

  //Type list from snapshot
  List<Type> _typeListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return Type(
        data: {
          'fact': (doc.data() as dynamic)['fact'] ?? '',
          'colorNumber': (doc.data() as dynamic)['colorNumber'] ?? '',
          'typeName': (doc.data() as dynamic)['typeName'] ?? '',
          'pictures': (doc.data() as dynamic)['pictures'] ?? '',
          'typeFact': (doc.data() as dynamic)['typeFact'] ?? '',
          'color': (doc.data() as dynamic)['color'] ?? '',
        }
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      data: {
        'uid': uid,
        'fact': snapshot['fact'],
        'typeName': snapshot['typeName'],
        'colorNumber': snapshot['colorNumber'],
        'pictures': snapshot['pictures'],
        'typeFact': snapshot['typeFact'],
        'color': snapshot['color'],
      }
    );
  }

  //get type stream
  Stream<List<Type>> get type {
    return typeCollection.snapshots()
    .map(_typeListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData {
    return typeCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}