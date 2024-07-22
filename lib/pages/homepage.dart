import 'package:flutter/material.dart';
import 'package:spak/pages/report.dart';
import 'info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int index = 0;

  final screens = [
    ReportPage(),
    InfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
                    'images/logo.png', 
                    height: 70
                    ),
                ),
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.blue.shade100,
              labelTextStyle: WidgetStatePropertyAll(
                  TextStyle(fontSize: 18, fontWeight: FontWeight.w500))),
          child: NavigationBar(
            backgroundColor: Color.fromARGB(255, 214, 213, 213),
            selectedIndex: index,
            onDestinationSelected: (index) {
              setState(
                () {
                  this.index = index;
                },
              );
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home, color: Color.fromARGB(255, 66, 66, 66), size: 25,),
                label: 'Kryesore',
              ),
              NavigationDestination(
                icon: Icon(Icons.info, color: Color.fromARGB(255, 66, 66, 66), size: 25,),
                label: 'Informacion',
              ),
            ],
          ),
        ),
      ),
    );
  }
}