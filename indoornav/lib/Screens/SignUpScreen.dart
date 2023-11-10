import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indoornav/Screens/HomeScreen.dart';
import 'package:indoornav/Screens/SignInScreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static const String id = 'Signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _startSecondAnimation = false;

  void _SignIn() {
    Navigator.pushNamed(context, SignInScreen.id);
  }

  void _SignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  String mainText = 'harmony';
  String firstWordInSecondAnimation = 'Learn';
  String secondWordInSecondAnimation = 'Recall';
  String thirdWordInSecondAnimation = 'Gamify';

/*
 * Parameters: 
  - int delay: The delay before the animation starts, in milliseconds.
  - int duration: The duration of the animation, in milliseconds.
  - TextInputType keyboardType: Specifies the type of keyboard to show, such as numeric or text.
  - String labelText: The text that describes the input field.
  - String hintText: The text that suggests what sort of input the field accepts.
  - IconData iconName: The icon to display in the input field.

@Returns: 
  - FadeInUp: Returns a widget that animates the position of a widget relative to its normal position. The widget will move up and fade in.

@Requires Clause:
  - The delay and duration parameters must be integers greater than or equal to zero.
  - The keyboardType parameter must be a valid TextInputType.
  - The labelText and hintText parameters must be valid strings, not null.
  - The iconName parameter must be a valid IconData.

@Ensures Clause:
  - Returns a FadeInUp widget with the specified delay and duration.
  - The child of the FadeInUp widget is a TextField with the specified keyboardType, labelText, hintText and iconName.
  - The TextField will have a specific style, cursor color, decoration, and prefix icon as defined in the method.
  - The TextField's border changes when it's focused or enabled.
  - The TextField's label and hint have specific styles as defined in the method.
 */
  FadeInUp fadeAnimation(int delay, int duration, TextInputType keyboardType,
      String labelText, String hintText, IconData iconName) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      duration: Duration(milliseconds: duration),
      child: TextField(
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          labelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            iconName,
            color: Colors.black,
            size: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          floatingLabelStyle: const TextStyle(
            color: Colors.black,
            fontSize: 14,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1.5),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                const SizedBox(height: 30),
                fadeAnimation(
                    800,
                    100,
                    TextInputType.emailAddress,
                    'First Name',
                    'at most 10 characters',
                    FontAwesomeIcons.user),
                const SizedBox(
                  height: 20,
                ),
                fadeAnimation(900, 250, TextInputType.emailAddress, 'Last Name',
                    'at most 10 characters', FontAwesomeIcons.user),
                const SizedBox(
                  height: 20,
                ),
                fadeAnimation(1000, 500, TextInputType.emailAddress, 'Email',
                    'Email', FontAwesomeIcons.envelope),
                const SizedBox(
                  height: 20,
                ),
                fadeAnimation(1100, 750, TextInputType.visiblePassword,
                    'Password', 'Password', FontAwesomeIcons.key),
                const SizedBox(
                  height: 30,
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 1300),
                  delay: const Duration(milliseconds: 800),
                  child: MaterialButton(
                    onPressed: () {
                      _SignUp();
                    },
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.black,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 1500),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _SignIn();
                        },
                        ////////////////////////////////////////// Route To Register Page- chnage content in pushReplacement to register page  ///////////////////////////////////////

                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
