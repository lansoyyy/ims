import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/services/add_appointment.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/button_widget.dart';
import 'package:ims/widgets/text_widget.dart';
import 'package:ims/widgets/toast_widget.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  String nameSearched = '';

  String selectedTime = '9:00 AM';
  List times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 AM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];

  dynamic mydata = {};
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    mydata = data.data();
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
                            hintText: 'Search Coaches',
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
              TextWidget(
                text: 'List of Coaches',
                fontSize: 18,
                fontFamily: 'Bold',
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Users')
                    .where('type', isEqualTo: 'Coach')
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
                        ),
                      ),
                    );
                  }

                  final data = snapshot.requireData;
                  final now = DateTime.now();

                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) {
                        // Parse the date and time data from Firestore
                        DateTime day = DateTime.parse(data.docs[index]['day']);
                        TimeOfDay timeFrom = TimeOfDay(
                          hour: int.parse(
                              data.docs[index]['timefrom'].split(':')[0]),
                          minute: int.parse(data.docs[index]['timefrom']
                              .split(':')[1]
                              .split(' ')[0]),
                        );
                        TimeOfDay timeTo = TimeOfDay(
                          hour: int.parse(
                              data.docs[index]['timeto'].split(':')[0]),
                          minute: int.parse(data.docs[index]['timeto']
                              .split(':')[1]
                              .split(' ')[0]),
                        );

                        // Convert TimeOfDay to DateTime for comparison
                        final fromDateTime = DateTime(day.year, day.month,
                            day.day, timeFrom.hour, timeFrom.minute);
                        final toDateTime = DateTime(day.year, day.month,
                            day.day, timeTo.hour, timeTo.minute);

                        // Check if the current date and time is within the range
                        if (now.isAfter(fromDateTime) &&
                            now.isBefore(toDateTime)) {
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
                                          text: data.docs[index]['name'],
                                          fontSize: 14,
                                          fontFamily: 'Bold',
                                        ),
                                        TextWidget(
                                          text: data.docs[index]['coachtype'],
                                          fontSize: 11,
                                          color: Colors.black,
                                        ),
                                        const Icon(
                                          Icons.email_outlined,
                                          size: 15,
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
                                      color: primary,
                                      width: 75,
                                      height: 30,
                                      fontSize: 8,
                                      label: 'Make Appointment',
                                      onPressed: () {
                                        showAppointment(data.docs[index]);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  showAppointment(data) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Container(
            height: 600,
            color: primary,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_circle,
                        size: 65,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: data['name'],
                            fontSize: 14,
                            fontFamily: 'Bold',
                            color: Colors.white,
                          ),
                          TextWidget(
                            text: data['coachtype'],
                            fontSize: 11,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextWidget(
                            text: data['field'],
                            fontSize: 11,
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.email_outlined,
                                size: 15,
                                color: Colors.white,
                              ),
                              TextWidget(
                                text: data['number'],
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 250,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          20,
                        ),
                        topRight: Radius.circular(
                          20,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'About Coach',
                              fontSize: 14,
                              fontFamily: 'Bold',
                              color: primary,
                            ),
                            TextWidget(
                              align: TextAlign.start,
                              maxLines: 3,
                              text: data['about'],
                              fontSize: 11,
                              fontFamily: 'Regular',
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Select Date',
                              fontSize: 14,
                              fontFamily: 'Bold',
                              color: primary,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () async {
                                    final DateTime? picked =
                                        await showDatePicker(
                                      context: context,
                                      initialDate:
                                          _selectedDate ?? DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (picked != null &&
                                        picked != _selectedDate) {
                                      setState(() {
                                        _selectedDate = picked;
                                      });
                                    }
                                  },
                                  child: const Text(
                                    'Select date',
                                    style: TextStyle(
                                      fontFamily: 'Bold',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20.0),
                                Text(
                                  _selectedDate == null
                                      ? 'No date selected'
                                      : 'Selected date: ${DateFormat('MMMM dd, yyyy').format(_selectedDate!)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Bold',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextWidget(
                              text: 'Select Time',
                              fontSize: 14,
                              fontFamily: 'Bold',
                              color: primary,
                            ),
                            Wrap(
                              spacing: 8.0, // gap between adjacent chips
                              children: times.map((time) {
                                return ChoiceChip(
                                  label: Text(time),
                                  selected: selectedTime == time,
                                  onSelected: (bool selected) {
                                    setState(() {
                                      selectedTime =
                                          selected ? time : selectedTime;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: ButtonWidget(
                                radius: 100,
                                color: primary,
                                label: 'Make Appointment',
                                onPressed: () {
                                  addAppointment(
                                      _selectedDate!.day,
                                      _selectedDate!.month,
                                      _selectedDate!.year,
                                      mydata['name'],
                                      mydata['uid'],
                                      data['name'],
                                      data.id,
                                      selectedTime,
                                      mydata['course'],
                                      mydata['yearlevel']);
                                  showSuccessDialog();
                                  // Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
  }

  DateTime? _selectedDate;

  showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: Colors.green,
                  size: 125,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: 'Congratulations on your appointment success!',
                  fontSize: 12,
                  fontFamily: 'Medium',
                ),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: ButtonWidget(
                    radius: 100,
                    color: primary,
                    label: 'Okay',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);

                      showToast('Appointment saved!');
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
