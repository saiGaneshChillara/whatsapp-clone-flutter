import 'package:flutter/material.dart';
import 'package:myapp/colors.dart';
import 'package:myapp/screens/mobile_layout_screen.dart';
import 'package:myapp/screens/web_layout_screen.dart';
import 'package:myapp/utils/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Whatsap UI",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const ResponsiveLayout(
        mobileScreenLayout: MobileLayoutScreen(),
        webScrenLayout: WebLayoutScreen(),
      ),
    );
  }
}
