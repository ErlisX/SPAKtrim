import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

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
              'images/corruption.png',
              height: 200,
            ),
            const SizedBox(height: 60),
            Text(
              'Ky është kontributi yt\n si qytetar për luftën\n  kundër abuzimeve',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 22, ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/intropage2');
              },
              child: Text('Vazhdo'),
            ),
            const SizedBox(height: 40),
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
