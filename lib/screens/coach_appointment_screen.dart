import 'package:cell_calendar/cell_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/screens/student_screen.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/button_widget.dart';
import 'package:ims/widgets/text_widget.dart';

class CoachAppointmentScreen extends StatefulWidget {
  const CoachAppointmentScreen({super.key});

  @override
  State<CoachAppointmentScreen> createState() => _CoachAppointmentScreenState();
}

class _CoachAppointmentScreenState extends State<CoachAppointmentScreen> {
  final searchController = TextEditingController();
  String nameSearched = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'Name here',
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                        TextWidget(
                          text: 'CURRICULUM COACH',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                height: 500,
                width: double.infinity,
                child: CellCalendar(
                  onCellTapped: (p0) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Appointments')
                                        .where('coachid',
                                            isEqualTo: FirebaseAuth
                                                .instance.currentUser!.uid)
                                        .where('day', isEqualTo: p0.day)
                                        .where('month', isEqualTo: p0.month)
                                        .where('year', isEqualTo: p0.year)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        print(snapshot.error);
                                        return const Center(
                                            child: Text('Error'));
                                      }
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Padding(
                                          padding: EdgeInsets.only(top: 50),
                                          child: Center(
                                              child: CircularProgressIndicator(
                                            color: Colors.black,
                                          )),
                                        );
                                      }

                                      final data = snapshot.requireData;
                                      return SizedBox(
                                        height: 300,
                                        width: double.infinity,
                                        child: ListView.separated(
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: const Icon(
                                                  Icons.account_circle_outlined,
                                                ),
                                                title: TextWidget(
                                                  text: data.docs[index]
                                                      ['studentname'],
                                                  fontSize: 14,
                                                  fontFamily: 'Bold',
                                                ),
                                                trailing: TextWidget(
                                                  text: data.docs[index]
                                                      ['time'],
                                                  fontSize: 12,
                                                  fontFamily: 'Medium',
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return const Divider();
                                            },
                                            itemCount: data.docs.length),
                                      );
                                    }),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: TextWidget(
                                      text: 'Close',
                                      fontSize: 18,
                                      fontFamily: 'Bold',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
