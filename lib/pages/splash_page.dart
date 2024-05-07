import 'package:flutter/material.dart';
import 'package:gp/pages/home/home_page.dart';
import 'package:gp/widgets/app_background.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5400)).then((_) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   return AppBackGround(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(),
        Image.asset('assets/images/app_name.png'),
        Opacity(
          opacity: 0.2,
          child: Image.asset('assets/images/splash_animation.gif'),
        ),
        const SizedBox(height: 100),
      ],
    ),
  ),
);}
}
