import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/privacy.png',
              height: 200,
            ),
            const SizedBox(height: 60),
            Text(
              'Të gjitha raportimet janë\n plotësisht anonime',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homepage');
              },
              child: Text('Fillo Tani'),    
            ),
            const SizedBox(height: 50),
            Image.asset(
              'images/logo.png',
              height: 70,
            ),
          ],
        )),
      ),
    );
  }
}
