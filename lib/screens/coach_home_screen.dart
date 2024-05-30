import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/screens/student_screen.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/button_widget.dart';
import 'package:ims/widgets/text_widget.dart';
import 'package:intl/intl.dart';

class CoachHomeScreen extends StatefulWidget {
  const CoachHomeScreen({super.key});

  @override
  State<CoachHomeScreen> createState() => _CoachHomeScreenState();
}

class _CoachHomeScreenState extends State<CoachHomeScreen> {
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  child: Container(
                    height: 50,
                    width: 350,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Regular',
                            fontSize: 14),
                        onChanged: (value) {
                          setState(() {
                            nameSearched = value;
                          });
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                            labelStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            hintText: 'Search Students',
                            hintStyle: const TextStyle(
                                fontFamily: 'Bold', color: Colors.black),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                            )),
                        controller: searchController,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'List of Students',
                    fontSize: 18,
                    fontFamily: 'Bold',
                  ),
                  // ButtonWidget(
                  //   radius: 100,
                  //   color: primary,
                  //   width: 75,
                  //   height: 30,
                  //   fontSize: 8,
                  //   label: 'Add Student',
                  //   onPressed: () {},
                  // ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Name',
                    fontSize: 18,
                    fontFamily: 'Bold',
                  ),
                  TextWidget(
                    text: 'Year',
                    fontSize: 18,
                    fontFamily: 'Bold',
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .where('type', isEqualTo: 'Student')
                      .where('name',
                          isGreaterThanOrEqualTo:
                              toBeginningOfSentenceCase(nameSearched))
                      .where('name',
                          isLessThan:
                              '${toBeginningOfSentenceCase(nameSearched)}z')
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
                        )),
                      );
                    }

                    final data = snapshot.requireData;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.docs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StudentScreen(
                                        id: data.docs[index],
                                      )));
                            },
                            child: Card(
                              child: Container(
                                width: 300,
                                height: 80,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.account_circle,
                                            size: 50,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          TextWidget(
                                            text: data.docs[index]['name'],
                                            fontSize: 14,
                                            fontFamily: 'Bold',
                                          ),
                                          const Expanded(
                                            child: SizedBox(
                                              width: 10,
                                            ),
                                          ),
                                          TextWidget(
                                            text:
                                                '${data.docs[index]['yearlevel']}, ${data.docs[index]['course']}',
                                            fontSize: 14,
                                            fontFamily: 'Bold',
                                          ),
                                        ],
                                      ),
                                      TextWidget(
                                        text: 'Tap to view details',
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
