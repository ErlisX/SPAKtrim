import 'package:flutter/material.dart';
import 'package:spak/pages/report_form.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            """Kliko mbi Raporto për të denoncuar
në menyre anonime çdo lloj rasti 
abuzimi apo korrupsioni në institucione.""",
            style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReportFormPage(),
                ),
              );
            },
            icon: const Icon(Icons.report, size: 50, color: Colors.red),
            label: const Text('Raporto', style: TextStyle(fontSize: 34, color: Colors.red)),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 25),
            ),
          ),
        ],
      ),
    );
  }
}
