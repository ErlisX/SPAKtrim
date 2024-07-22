import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Çfarë është Spaktrim?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                """SPAKtrim është një aplikacion që lejon çdo individ të raportojë/denoncojë çdo abuzim, shfrytëzim apo korrupsion që ndodh në institucionet shqiptare.""",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Secili raportim/denoncim është plotësisht anonim.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                  'Çdo rast abuzimi me fonde publike, shfrytëzimi të qytetarëve apo korrupsioni në institucione duhet denoncuar.'),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                  'Aplikacioni ka nevojë për një lidhje interneti për të pranuar raportimet.',
                  style: TextStyle(fontStyle: FontStyle.italic),),
            ),
          ],
        ),
      ),
    );
  }
}
