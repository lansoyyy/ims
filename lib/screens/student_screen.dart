import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/text_widget.dart';

class StudentScreen extends StatelessWidget {
  const StudentScreen({super.key});

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
                          text: 'Name here',
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
                text: 'Third Year',
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
                      onPressed: () {},
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
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'Subject',
                        fontSize: 11,
                        fontFamily: 'Medium',
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextWidget(
                          text: 'Description',
                          fontSize: 11,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                      ),
                      TextWidget(
                        text: 'Unit',
                        fontSize: 11,
                        fontFamily: 'Medium',
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextWidget(
                        text: 'Rem',
                        fontSize: 11,
                        fontFamily: 'Medium',
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
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
                      onPressed: () {},
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
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      TextWidget(
                        text: 'Subject',
                        fontSize: 11,
                        fontFamily: 'Medium',
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 250,
                        child: TextWidget(
                          text: 'Description',
                          fontSize: 11,
                          fontFamily: 'Medium',
                          color: Colors.black,
                        ),
                      ),
                      TextWidget(
                        text: 'Unit',
                        fontSize: 11,
                        fontFamily: 'Medium',
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextWidget(
                        text: 'Rem',
                        fontSize: 11,
                        fontFamily: 'Medium',
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {},
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
}
