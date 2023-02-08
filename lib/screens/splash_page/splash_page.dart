import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protfolio_app/screens/add_bio_page/add_bio.dart';
import 'package:protfolio_app/screens/home_page/home_page.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({super.key, required this.isfirst});
  final bool isfirst;
  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    widget.isfirst ? const HomePage() : const AddBio())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'asset/logo.jpg',
          height: 200.h,
          width: 200.w,
        ),
      ),
    );
  }
}
