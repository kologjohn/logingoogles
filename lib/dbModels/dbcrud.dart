import 'package:cloud_firestore/cloud_firestore.dart';

class Dbinsert {
  final db = FirebaseFirestore.instance;
  addNewUser(String name, String email, String phone,String password) async {
    try {
      final user = <String, dynamic>{
        "name": name,
        "email": email,
        "hometown":phone,
        "password":password
      };

      await db.collection("users").add(user).then((DocumentReference doc) =>
          // ignore: avoid_print
          print('DocumentSnapshot added with ID: ${doc.id}'));
    // ignore: empty_catches
    } catch (e) {
      print(e);
    }
  }

}
