import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/button_widget.dart';
import 'package:ims/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              Row(
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
                        text: 'Name here',
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
              TextWidget(
                text: '5 coaches availabe now',
                fontSize: 11,
                color: Colors.black,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Name here',
                                    fontSize: 14,
                                    fontFamily: 'Bold',
                                  ),
                                  TextWidget(
                                    text: 'Academic coach',
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
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
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
