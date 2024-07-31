import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  static const routeName = '/splash_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/lecsens_logo.png'),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Detektor cemaran pada air yang portable, mudah digunakan, cepat, dan akurat',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '© 2022 Tim Riset. All rights reserved v22.1',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
