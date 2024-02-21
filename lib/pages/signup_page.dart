import 'package:flutter/material.dart';
import 'package:ninebot_app/pages/login_page.dart';
import '../components/my_opacity_animation.dart';
import '../components/my_transition_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double myHeight = MediaQuery.of(context).size.height;
    final double myWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyOpacityAnimation(
                    duration: const Duration(milliseconds: 400),
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyOpacityAnimation(
                    duration: const Duration(milliseconds: 600),
                    child: const Text(
                      "Welcome to IO Team team. Please complete your registration.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              signupForm(),
              signupButton(() {}),
              MyOpacityAnimation(
                duration: const Duration(milliseconds: 2200),
                child: Row(
                  children: const [
                    Flexible(flex: 1, child: Divider()),
                    Flexible(
                      flex: 2,
                      child: Text(" Signup with Google or Facebook"),
                    ),
                    Flexible(flex: 1, child: Divider()),
                  ],
                ),
              ),
              moreSignup(),
              MyOpacityAnimation(
                duration: const Duration(milliseconds: 2400),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Do you have an account? ",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signupForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          myTextForm(
            "Full name",
            Icons.person,
            fullNameController,
            TextInputType.name,
            false,
            800,
          ),
          myTextForm(
            "Email",
            Icons.email,
            emailController,
            TextInputType.emailAddress,
            false,
            1000,
          ),
          myTextForm(
            "Phone number",
            Icons.phone,
            phoneController,
            TextInputType.phone,
            false,
            1200,
          ),
          myTextForm(
            "Address",
            Icons.location_city,
            addressController,
            TextInputType.streetAddress,
            false,
            1400,
          ),
          myTextForm(
            "Password",
            Icons.lock,
            passwordController,
            TextInputType.text,
            true,
            1600,
          ),
        ],
      ),
    );
  }

  Widget myTextForm(
    String hint,
    IconData icon,
    TextEditingController controller,
    TextInputType keyboard,
    bool obscureText,
    int animDuration,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: MyOpacityAnimation(
        duration: Duration(milliseconds: animDuration),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: TextFormField(
              controller: controller,
              keyboardType: keyboard,
              obscureText: obscureText,
              decoration: InputDecoration(
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                hintText: hint,
                labelText: hint,
                hintStyle: const TextStyle(fontSize: 12.0),
                prefixIcon: Icon(icon),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signupButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: MyOpacityAnimation(
        duration: const Duration(milliseconds: 1800),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(
            child: Text(
              "Sign up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget moreSignup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyTransitionWidget(
          axis: Axis.horizontal,
          duration: const Duration(milliseconds: 1800),
          offset: -80,
          child: moreSignupObject("Google", "assets/google.png", () {}),
        ),
        MyTransitionWidget(
          axis: Axis.horizontal,
          duration: const Duration(milliseconds: 1800),
          offset: 80,
          child: moreSignupObject("Facebook", "assets/facebook.png", () {}),
        ),
      ],
    );
  }

  Widget moreSignupObject(String title, String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 20.0),
            SizedBox(width: 10),
            Text(title),
          ],
        ),
      ),
    );
  }
}
