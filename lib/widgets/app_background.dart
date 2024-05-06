import 'package:flutter/material.dart';

class AppBackGround extends StatelessWidget {
  final Widget child;
  final bool isSplash;

  const AppBackGround({
    super.key,
    required this.child,
    this.isSplash = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbf5f2),
      body: SafeArea(
        bottom: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/background.png',
                  ),
                ),
              ),
              child: child,
            ),
            if (isSplash)
              Image.asset(
                'assets/images/splash_background.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.contain,
              ),
          ],
        ),
      ),
    );
  }
}