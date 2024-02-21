import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '/my_clicked_animation.dart';
import '/my_message.dart';
import '/my_opacity_animation.dart';
import '/my_transition_widget.dart';

import 'package:http/http.dart' as http;
import '/home_page.dart';

import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool is_check_email = false;
  bool is_check_phone = false;
  bool is_check_password = false;
  void login_user_with_email() async {
    String url = "http://swaaaa.ir:7777/person/login_user_youtube_test_email";
    var body = json.encode(
        {"email": email_controller.text, "password": password_controller.text});

    var res = await http.post(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
      body: body,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      setState(() {
        is_check_email = true;
        is_check_password = true;
      });
    } else if (res.statusCode == 401) {
      setState(() {
        is_check_email = true;
        is_check_password = false;
      });
    } else if (res.statusCode == 404) {
      setState(() {
        is_check_email = false;
      });
    }
  }

  void login_user_with_phone() async {
    String url = "http://swaaaa.ir:7777/person/login_user_youtube_test_phone";
    var body = json.encode(
        {"phone": phone_controller.text, "password": password_controller.text});

    var res = await http.post(
      Uri.parse(url),
      headers: {"Content-type": "application/json"},
      body: body,
    );

    if (res.statusCode == 200 || res.statusCode == 201) {
      setState(() {
        is_check_phone = true;
        is_check_password = true;
      });
    } else if (res.statusCode == 401) {
      setState(() {
        is_check_phone = true;
        is_check_password = false;
      });
    } else if (res.statusCode == 404) {
      setState(() {
        is_check_phone = false;
      });
    }
  }

  int is_exit = 0;
  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Future.delayed(
          const Duration(milliseconds: 500),
          () {
            is_exit = 0;
          },
        );
        is_exit++;
        if (is_exit == 2) {
          exit(1);
        } else {
          MyMessage.mysnackbarMessage(
              context, "Please double click to exit", 2);
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyOpacityAnimation(
                      duration: 400,
                      child: const Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ),
                    ),
                    const SizedBox(height: 10),
                    MyOpacityAnimation(
                      duration: 600,
                      child: const Text(
                        "We happy to see you . To use you account . you should login first .",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 14.0, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                login_type(),
                login_form(),
                login_button(() {
                  is_email ? login_user_with_email() : login_user_with_phone();
                  if (is_email) {
                    if (is_check_email == false && is_check_password == true) {
                      MyMessage.mysnackbarMessage(
                          context, "This email is not available", 2);
                    } else if (is_check_email == false &&
                        is_check_password == false) {
                      MyMessage.mysnackbarMessage(
                          context, "email and password are wrong", 2);
                    } else if (is_check_email == true &&
                        is_check_password == false) {
                      MyMessage.mysnackbarMessage(
                          context, "password is wrong", 2);
                    } else if (is_check_email == true &&
                        is_check_password == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    }
                  } else {
                    if (is_check_phone == false && is_check_password == true) {
                      MyMessage.mysnackbarMessage(
                          context, "This phone is not available", 2);
                    } else if (is_check_phone == false &&
                        is_check_password == false) {
                      MyMessage.mysnackbarMessage(
                          context, "phone and password are wrong", 2);
                    } else if (is_check_phone == true &&
                        is_check_password == false) {
                      MyMessage.mysnackbarMessage(
                          context, "password is wrong", 2);
                    } else if (is_check_phone == true &&
                        is_check_password == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    }
                  }
                }),
                SizedBox(height: myHeight * 0.02),
                MyOpacityAnimation(
                  duration: 2200,
                  child: Row(
                    children: const [
                      Flexible(flex: 1, child: Divider()),
                      Flexible(
                          flex: 2,
                          child: Text(" Sign in with Google or Facebook ")),
                      Flexible(flex: 1, child: Divider()),
                    ],
                  ),
                ),
                more_signin(),
                MyOpacityAnimation(
                  duration: 2400,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account ?",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
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

  bool is_email = true;
  bool is_phone = false;

  Widget login_type() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return MyOpacityAnimation(
      duration: 1000,
      child: Container(
        height: myHeight * 0.08,
        width: myWidth,
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  is_email = true;
                  is_phone = false;
                });
              },
              child: Container(
                height: myHeight * 0.06,
                width: myWidth * 0.4,
                decoration: BoxDecoration(
                  color: is_email ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child: MyClickedAnimation(
                        is_select: is_email, title: "Email")),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  is_email = false;
                  is_phone = true;
                });
              },
              child: Container(
                height: myHeight * 0.06,
                width: myWidth * 0.4,
                decoration: BoxDecoration(
                  color: is_phone ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child: MyClickedAnimation(
                        is_select: is_phone, title: "Phone number")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget login_form() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          is_email
              ? my_text_form(
                  "Email",
                  Icons.email,
                  email_controller,
                  TextInputType.emailAddress,
                  false,
                  1200,
                  email_controller.text == ""
                      ? IconlyBroken.more_square
                      : is_check_email == true
                          ? IconlyBroken.tick_square
                          : IconlyBroken.close_square,
                  email_controller.text == ""
                      ? Colors.amber.withOpacity(0.5)
                      : is_check_email == true
                          ? Colors.green.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5),
                )
              : my_text_form(
                  "Phone number",
                  Icons.phone,
                  phone_controller,
                  TextInputType.phone,
                  false,
                  1200,
                  phone_controller.text == ""
                      ? IconlyBroken.more_square
                      : is_check_phone == true
                          ? IconlyBroken.tick_square
                          : IconlyBroken.close_square,
                  phone_controller.text == ""
                      ? Colors.amber.withOpacity(0.5)
                      : is_check_phone == true
                          ? Colors.green.withOpacity(0.5)
                          : Colors.red.withOpacity(0.5),
                ),
          my_text_form(
            "Password",
            Icons.password,
            password_controller,
            TextInputType.number,
            true,
            1400,
            password_controller.text == ""
                ? IconlyBroken.more_square
                : is_check_password == true
                    ? IconlyBroken.tick_square
                    : IconlyBroken.close_square,
            password_controller.text == ""
                ? Colors.amber.withOpacity(0.5)
                : is_check_password == true
                    ? Colors.green.withOpacity(0.5)
                    : Colors.red.withOpacity(0.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              MyOpacityAnimation(
                duration: 1600,
                child: const Text(
                  "Forgot password ?",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextEditingController email_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();

  Widget my_text_form(
    String hint,
    IconData icon,
    TextEditingController controller,
    TextInputType keyboard,
    bool obscureText,
    int anim_duration,
    IconData check_icon,
    Color check_icon_color,
  ) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: MyOpacityAnimation(
        duration: anim_duration,
        child: Container(
          height: myHeight * 0.08,
          width: myWidth,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboard,
              obscureText: obscureText,
              onChanged: (value) {
                is_email ? login_user_with_email() : login_user_with_phone();
              },
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: hint,
                labelText: hint,
                hintStyle: const TextStyle(fontSize: 12.0),
                prefixIcon: Icon(icon),
                suffixIcon: Icon(
                  check_icon,
                  color: check_icon_color,
                ),
                // suffixIconColor: check_icon_color,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget login_button(VoidCallback ontap) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: MyOpacityAnimation(
        duration: 1800,
        child: Container(
          height: myHeight * 0.07,
          width: myWidth,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget more_signin() {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTransitionWidget(
            axis: Axis.horizontal,
            duration: 1800,
            offset: -80,
            child: more_signin_object("Google", "assets/google.png", () {})),
        MyTransitionWidget(
            axis: Axis.horizontal,
            duration: 1800,
            offset: 80,
            child:
                more_signin_object("Facebook", "assets/facebook.png", () {})),
      ],
    );
  }

  Widget more_signin_object(String title, String image, VoidCallback ontap) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: myHeight * 0.08,
        width: myWidth * 0.43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.0,
              color: Colors.grey.withOpacity(0.5),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 20.0),
            SizedBox(width: myWidth * 0.03),
            Text(title),
          ],
        ),
      ),
    );
  }
}
