import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:protfolio_app/screens/splash_page/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isFirst = prefs.getBool('firstAdd') ?? false;
  runApp(MyApp(
    isFirst: isFirst,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirst});
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true),
          title: 'Bio',
          home: SplashScren(
            isfirst: isFirst,
          )),
      designSize: const Size(390, 844),
    );
  }
}
