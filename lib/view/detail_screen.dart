import 'package:flutter/material.dart';
import 'package:lecsens/res/widgets/chart_card.dart';
import 'package:lecsens/res/widgets/copyright_footer.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Detail Data',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),
            Form(
              child: Column(
                children: <Widget>[
                  Padding(padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: ' Lokasi : Kalimas',
                      decoration: InputDecoration(
                        hintText: 'Lokasi',
                      ),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: 'Alat : LC-001',
                      decoration: InputDecoration(
                        hintText: 'Lokasi',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CopyrightFooter(),
    );
  }
}