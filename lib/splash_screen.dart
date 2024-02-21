import 'package:flutter/material.dart';
import 'components/my_opacity_animation.dart';

import 'pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyOpacityAnimation(
            duration: 2000,
            child: const Text(
              "IO Team",
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}
