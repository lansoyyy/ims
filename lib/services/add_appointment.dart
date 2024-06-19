import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> addAppointment(day, month, year, studentname, studentid,
    coachname, coachid, time, section, level, concern) async {
  final docUser = FirebaseFirestore.instance.collection('Appointments').doc();

  final json = {
    'section': section,
    'level': level,
    'studentname': studentname,
    'studentid': studentid,
    'coachname': coachname,
    'coachid': coachid,
    'time': time,
    'uid': FirebaseAuth.instance.currentUser!.uid,
    'id': docUser.id,
    'day': day,
    'month': month,
    'year': year,
    'dateTime': DateTime.now(),
    'status': 'Pending',
    'concern': concern,
  };

  await docUser.set(json);
  return docUser.id;
}
