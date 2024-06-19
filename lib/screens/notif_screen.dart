import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utlis/colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_widget.dart';

class NotifScreen extends StatelessWidget {
  const NotifScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<DocumentSnapshot> userData = FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
    return Scaffold(
      backgroundColor: secondary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              StreamBuilder<DocumentSnapshot>(
                  stream: userData,
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Loading'));
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    dynamic data = snapshot.data;

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Student',
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            TextWidget(
                              text: data['name'],
                              fontSize: 18,
                              fontFamily: 'Bold',
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                      ],
                    );
                  }),
              SizedBox(
                height: 500,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Appointments')
                        .where('uid',
                            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          ),
                        );
                      }

                      final data = snapshot.requireData;

                      return Expanded(
                        child: ListView.builder(
                          itemCount: data.docs.length,
                          itemBuilder: (context, index) {
                            // Check if the current date and time is within the range

                            return Card(
                              child: Container(
                                width: 300,
                                height: 75,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.account_circle,
                                        size: 65,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            text: data.docs[index]['concern'],
                                            fontSize: 14,
                                            fontFamily: 'Bold',
                                          ),
                                          TextWidget(
                                            text:
                                                '${data.docs[index]['month']}/${data.docs[index]['day']}/${data.docs[index]['year']}',
                                            fontSize: 11,
                                            color: Colors.black,
                                          ),
                                          TextWidget(
                                            text: data.docs[index]['time'],
                                            fontSize: 11,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                      const Expanded(
                                        child: SizedBox(
                                          width: 10,
                                        ),
                                      ),
                                      ButtonWidget(
                                        radius: 100,
                                        color: data.docs[index]['status'] ==
                                                'Rejected'
                                            ? Colors.red
                                            : data.docs[index]['status'] ==
                                                    'Pending'
                                                ? Colors.blue
                                                : Colors.green,
                                        width: 75,
                                        height: 30,
                                        fontSize: 8,
                                        label: data.docs[index]['status'],
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
