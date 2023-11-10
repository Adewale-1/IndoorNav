import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:indoornav/Screens/HomeScreen.dart';
import 'package:indoornav/Screens/SignUpScreen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  static const String id = 'Signin';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  int activeIndex = 0;



  @override
  void initState() {
    super.initState();

    startTimer();
  }

/*
 * This method allows the transitioning between images every second.
 * 
 * @Requires: 

- An integer variable named 'activeIndex' must already be declared and initialized.
- A function named 'setState' must be defined which takes a function as an argument to update the state of the 'activeIndex'.
- Timer and Duration classes should be available in the scope of this function. 

 @Ensures:

- A periodic timer with a duration of 6 seconds is started.
- On each tick of the timer, the 'activeIndex' is incremented by 1.
- If 'activeIndex' equals 3, it is reset back to 0.
- The 'setState' function is called on each tick of the timer to update the state of 'activeIndex'.
 */
  void startTimer() {
    Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        activeIndex = activeIndex + 1;

        if (activeIndex == 3) {
          activeIndex = 0;
        }
      });
    });
  }

  void _SignUp() {
    Navigator.pushNamed(context, SignUpScreen.id);
  }

  void _SignIn() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const HomeScreen(),
    //   ),
    // );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  void _ForgotPassword() {
    Navigator.of(context).pushReplacement('/' as Route<Object?>);
    print('Forgot Password Pressed!!!');
  }

/* 
 * This method creates a FadeInUp widget using the "animate_do.dart" library with a TextField as its child. The TextField 
 * has a specific style, cursor color,decoration, and prefix icon. The TextField's border changes when it's focused or enabled. 
 * The TextField's label and hint have specific styles. The method returns the FadeInUp widget.
 * 
 * Parameters: 
  - int delay: The delay before the animation starts, in milliseconds.
  - int duration: The duration of the animation, in milliseconds.
  - TextInputType keyboardType: Specifies the type of keyboard to show, such as numeric or text.
  - String labelText: The text that describes the input field.
  - String hintText: The text that suggests what sort of input the field accepts.
  - IconData iconName: The icon to display in the input field.

@Returns: 
  - FadeInUp: Returns a widget that animates the position of a widget relative to its normal position.
    The widget will move up and fade in.

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
                  height: 300,
                ),

                const SizedBox(height: 40),
                fadeAnimation(800, 170, TextInputType.emailAddress, 'Email',
                    'Username', FontAwesomeIcons.user), // FadeInUp
                const SizedBox(
                  height: 20,
                ),
                fadeAnimation(900, 270, TextInputType.visiblePassword,
                    'Password', 'Password', FontAwesomeIcons.key), // FadeInUp
                FadeInUp(
                  duration: const Duration(milliseconds: 1300),
                  delay: const Duration(milliseconds: 800),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          ////////////////////////////////////////// Route To Forgot Password Page- change content in pushReplacement to forgotpassword page  ///////////////////////////////////////
                          _ForgotPassword();
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                FadeInUp(
                  duration: const Duration(milliseconds: 1300),
                  delay: const Duration(milliseconds: 800),
                  child: MaterialButton(
                    onPressed: () {
                      _SignIn();
                    },
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.black,
                    child: const Text(
                      "Sign In",
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
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _SignUp();
                        },
                        child: const Text(
                          "Sign Up",
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
