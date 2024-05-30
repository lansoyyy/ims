import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> addSubject(studentid, subject, desc, rem, unit, sem) async {
  final docUser = FirebaseFirestore.instance.collection('Subjects').doc();

  final json = {
    'studentid': studentid,
    'subject': subject,
    'desc': desc,
    'rem': rem,
    'unit': unit,
    'sem': sem,
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'id': docUser.id,
    'dateTime': DateTime.now(),
  };

  await docUser.set(json);
  return docUser.id;
}
