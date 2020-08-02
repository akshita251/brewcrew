import 'package:brew/models/brew.dart';
import 'package:brew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection
        .document(uid)
        .setData({'sugars': sugars, 'name': name, 'strength': strength});
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data['name'] ?? '',
          sugars: doc.data['sugars'] ?? '0',
          strength: doc.data['strength'] ?? 100);
    }).toList();
  }

  Stream<List<Brew>> get brew {
    return brewCollection
        .snapshots()
        .map((event) => _brewListFromSnapshot(event));
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        sugars: snapshot.data['sugars'],
        name: snapshot.data['name'],
        strength: snapshot.data['strength']);
  }

  Stream<UserData> get userData {
    return brewCollection
        .document(uid)
        .snapshots()
        .map((snapshot) => _userDataFromSnapshot(snapshot));
  }
}
