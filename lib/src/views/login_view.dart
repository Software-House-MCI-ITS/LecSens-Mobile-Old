import 'package:flutter/material.dart';
import '../components/login_form.dart';

/// Displays detailed information about a SampleItem.
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Image.asset('assets/images/lecsens_logo.png'),
            const SizedBox(height: 30),
            LoginForm(),
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
