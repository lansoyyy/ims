import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> addForm(studentid) async {
  final docUser = FirebaseFirestore.instance.collection('Forms').doc();

  final json = {
    'studentid': studentid,
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
  return docUser.id;
}
