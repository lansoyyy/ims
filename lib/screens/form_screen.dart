import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/services/add_form.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/text_widget.dart';
import 'package:ims/widgets/toast_widget.dart';

import '../widgets/button_widget.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
              Center(
                child: TextWidget(
                  text: 'Academic Advising Form',
                  fontSize: 18,
                  fontFamily: 'Bold',
                ),
              ),
              const Divider(),
              Image.asset(
                'assets/images/Capture.PNG',
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 500,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .where('type', isEqualTo: 'Student')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                print(snapshot.error);
                                return const Center(child: Text('Error'));
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          addForm(data.docs[index].id);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          showToast(
                                              'Academic Advising Form successfully sent!');
                                        },
                                        child: Card(
                                          child: Container(
                                            width: 300,
                                            height: 75,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      TextWidget(
                                                        text: data.docs[index]
                                                            ['name'],
                                                        fontSize: 14,
                                                        fontFamily: 'Bold',
                                                      ),
                                                    ],
                                                  ),
                                                  const Expanded(
                                                    child: SizedBox(
                                                      width: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                      );
                    },
                  );
                },
                child: TextWidget(
                  text: 'Send Academic Advising Form',
                  fontSize: 18,
                  color: Colors.blue,
                  fontFamily: 'Bold',
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
