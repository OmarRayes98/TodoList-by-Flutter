import 'package:flutter/cupertino.dart'; // استيراد كوبرتينو بدلاً من ماتيريال في التنقل
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:todo_list/screens/tabs_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/logo.png",
          width: size.width * 0.5,
        )
        .animate(
          onComplete: (controller) {
            // الانتقال بأسلوب كوبرتينو (Slide من اليمين لليسار)
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => const TabsScreens()),
            );
          },
        )
        .fadeIn(duration: const Duration(milliseconds: 1000))
        // .fadeOut(
        //   delay: const Duration(seconds: 2),
        //   duration: const Duration(milliseconds: 500),
        // ),
      ),
    );
  }
}