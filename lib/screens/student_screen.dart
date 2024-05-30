import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/screens/form_screen.dart';
import 'package:ims/services/add_subject.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/text_widget.dart';
import 'package:ims/widgets/textfield_widget.dart';

class StudentScreen extends StatefulWidget {
  dynamic id;

  StudentScreen({
    super.key,
    required this.id,
  });

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final subject = TextEditingController();
  final desc = TextEditingController();
  final unit = TextEditingController();
  final rem = TextEditingController();
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
                          text: widget.id['name'],
                          fontSize: 18,
                          fontFamily: 'Bold',
                        ),
                        TextWidget(
                          text: 'Student',
                          fontSize: 11,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Align(
                alignment: Alignment.topLeft,
                child: TextWidget(
                  text: 'Student Module',
                  fontSize: 14,
                  fontFamily: 'Bold',
                ),
              ),
              TextWidget(
                text: widget.id['yearlevel'],
                fontSize: 14,
                fontFamily: 'Bold',
                color: primary,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Icon(
                      Icons.school_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextWidget(
                      text: 'First Sem.',
                      fontSize: 12,
                      fontFamily: 'Bold',
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showAddSubjectDialog(1);
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Subjects')
                      .where('studentid', isEqualTo: widget.id.id)
                      .where('sem', isEqualTo: 1)
                      .orderBy('dateTime', descending: true)
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
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 35,
                          color: primary,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                TextWidget(
                                  text: 'Subject',
                                  fontSize: 12,
                                  fontFamily: 'Bold',
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: TextWidget(
                                    text: 'Description',
                                    fontSize: 12,
                                    fontFamily: 'Bold',
                                    color: Colors.white,
                                  ),
                                ),
                                TextWidget(
                                  text: 'Unit',
                                  fontSize: 12,
                                  fontFamily: 'Bold',
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                TextWidget(
                                  text: 'Rem',
                                  fontSize: 12,
                                  fontFamily: 'Bold',
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        for (int i = 0; i < data.docs.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Delete Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this subject?',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Subjects')
                                                    .doc(data.docs[i].id)
                                                    .delete();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: data.docs[i]['subject'],
                                    fontSize: 11,
                                    fontFamily: 'Medium',
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextWidget(
                                      text: data.docs[i]['desc'],
                                      fontSize: 11,
                                      fontFamily: 'Medium',
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextWidget(
                                    text: data.docs[i]['unit'],
                                    fontSize: 11,
                                    fontFamily: 'Medium',
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextWidget(
                                    text: data.docs[i]['rem'],
                                    fontSize: 11,
                                    fontFamily: 'Medium',
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
              const Divider(),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    const Icon(
                      Icons.school_outlined,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TextWidget(
                      text: 'Second Sem.',
                      fontSize: 12,
                      fontFamily: 'Bold',
                    ),
                    const Expanded(
                      child: SizedBox(
                        width: 10,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showAddSubjectDialog(2);
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Subjects')
                      .where('studentid', isEqualTo: widget.id.id)
                      .where('sem', isEqualTo: 2)
                      .orderBy('dateTime', descending: true)
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
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 35,
                          color: primary,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                TextWidget(
                                  text: 'Subject',
                                  fontSize: 12,
                                  fontFamily: 'Bold',
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: TextWidget(
                                    text: 'Description',
                                    fontSize: 12,
                                    fontFamily: 'Bold',
                                    color: Colors.white,
                                  ),
                                ),
                                TextWidget(
                                  text: 'Unit',
                                  fontSize: 12,
                                  fontFamily: 'Bold',
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                TextWidget(
                                  text: 'Rem',
                                  fontSize: 12,
                                  fontFamily: 'Bold',
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                        for (int i = 0; i < data.docs.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: const Text(
                                            'Delete Confirmation',
                                            style: TextStyle(
                                                fontFamily: 'QBold',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          content: const Text(
                                            'Are you sure you want to delete this subject?',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            MaterialButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            MaterialButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection('Subjects')
                                                    .doc(data.docs[i].id)
                                                    .delete();
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Continue',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              },
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: data.docs[i]['subject'],
                                    fontSize: 11,
                                    fontFamily: 'Medium',
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 250,
                                    child: TextWidget(
                                      text: data.docs[i]['desc'],
                                      fontSize: 11,
                                      fontFamily: 'Medium',
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextWidget(
                                    text: data.docs[i]['unit'],
                                    fontSize: 11,
                                    fontFamily: 'Medium',
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextWidget(
                                    text: data.docs[i]['rem'],
                                    fontSize: 11,
                                    fontFamily: 'Medium',
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  }),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FormScreen()));
                },
                child: TextWidget(
                  text: 'Create Academic Advising Form ',
                  fontSize: 14,
                  fontFamily: 'Bold',
                  color: primary,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      )),
    );
  }

  showAddSubjectDialog(int sem) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFieldWidget(controller: subject, label: 'Subject'),
                TextFieldWidget(controller: desc, label: 'Description'),
                TextFieldWidget(controller: unit, label: 'Unit'),
                TextFieldWidget(controller: rem, label: 'Rem'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              child: TextWidget(
                text: 'Cancel',
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: (() async {
                addSubject(widget.id.id, subject.text, desc.text, rem.text,
                    unit.text, sem);
                Navigator.pop(context);
              }),
              child: TextWidget(
                text: 'Continue',
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        );
      },
    );
  }
}
