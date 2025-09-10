import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/colors.dart';
import 'package:myapp/features/landing/screens/landing_screen.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/router.dart';
import 'package:myapp/screens/mobile_layout_screen.dart';
import 'package:myapp/screens/web_layout_screen.dart';
import 'package:myapp/utils/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
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
        appBarTheme: const AppBarTheme(
          backgroundColor: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const LandingScreen(),
    );
  }
}

// ResponsiveLayout(
//         mobileScreenLayout: MobileLayoutScreen(),
//         webScrenLayout: WebLayoutScreen(),
//       ),
