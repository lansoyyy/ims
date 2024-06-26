import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ims/screens/coach_screen.dart';
import 'package:ims/screens/home_screen.dart';
import 'package:ims/screens/main_screen.dart';
import 'package:ims/utlis/colors.dart';
import 'package:ims/widgets/button_widget.dart';
import 'package:ims/widgets/text_widget.dart';
import 'package:ims/widgets/textfield_widget.dart';
import 'package:ims/widgets/toast_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Ellipse 2.png',
                    height: 75,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset(
                    'assets/images/Ellipse 3.png',
                    height: 75,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: 'UNIVERSITY OF NUEVA CACERES',
                fontFamily: 'Bold',
                fontSize: 16,
              ),
              TextWidget(
                text: 'future-ready',
                fontFamily: 'Bold',
                fontSize: 12,
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      50,
                    ),
                    topRight: Radius.circular(
                      50,
                    ),
                    bottomLeft: Radius.circular(
                      10,
                    ),
                    bottomRight: Radius.circular(
                      10,
                    ),
                  ),
                ),
                child: Container(
                  height: 450,
                  width: 350,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        20,
                      ),
                      topRight: Radius.circular(
                        20,
                      ),
                      bottomLeft: Radius.circular(
                        10,
                      ),
                      bottomRight: Radius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Image.asset(
                          'assets/images/Rectangle 145.png',
                          height: 300,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 200,
                          width: 350,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: 'IMS',
                                          fontFamily: 'Bold',
                                          fontSize: 24,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text: 'ACADEMIC ADVISNG',
                                              fontFamily: 'Bold',
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                            TextWidget(
                                              text: 'CONSULTATION',
                                              fontFamily: 'Bold',
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: TextWidget(
                                      text: 'Use your university account',
                                      fontFamily: 'Medium',
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextFieldWidget(
                                    controller: username,
                                    label: 'Email',
                                  ),
                                  TextFieldWidget(
                                    showEye: true,
                                    isObscure: true,
                                    controller: password,
                                    label: 'Password',
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ButtonWidget(
                                    color: primary,
                                    label: 'Sign In',
                                    onPressed: () {
                                      login(context);
                                    },
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login(context) async {
    try {
      final user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username.text, password: password.text);

      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.user!.uid)
          .get();

      if (doc['type'] == 'Student') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MainScreen()));
        showToast('Logged in succesfully!');
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const CoachScreen()));
        showToast('Logged in succesfully!');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast("No user found with that email.");
      } else if (e.code == 'wrong-password') {
        showToast("Wrong password provided for that user.");
      } else if (e.code == 'invalid-email') {
        showToast("Invalid email provided.");
      } else if (e.code == 'user-disabled') {
        showToast("User account has been disabled.");
      } else {
        showToast("An error occurred: ${e.message}");
      }
    } on Exception catch (e) {
      showToast("An error occurred: $e");
    }
  }
}
