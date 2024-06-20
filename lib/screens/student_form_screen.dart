import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/services/add_form.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/text_widget.dart';
import 'package:ims/widgets/toast_widget.dart';

import '../widgets/button_widget.dart';

class StudentFormScreen extends StatelessWidget {
  const StudentFormScreen({super.key});

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
            ],
          ),
        ),
      )),
    );
  }
}
