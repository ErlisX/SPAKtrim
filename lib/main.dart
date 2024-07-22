import 'package:flutter/material.dart';
import 'package:spak/pages/homepage.dart';
import 'package:spak/pages/report.dart';
import 'package:spak/pages/report_form.dart';
import 'package:spak/pages/intro.dart';
import 'package:spak/pages/intro2.dart';
import 'package:spak/pages/info.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: WidgetStatePropertyAll(true)
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => IntroPage(),
        '/intropage2': (context) => IntroPage2(),
        '/homepage': (context) => HomePage(),
        '/infopage': (context) => InfoPage(),
        '/reportpage': (context) => ReportPage(),
        '/reportformpage': (context) => ReportFormPage(),
      },
    );
  }
}

