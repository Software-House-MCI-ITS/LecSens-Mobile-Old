import 'package:flutter/material.dart';
import '../res/widgets/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Image.asset('lib/res/images/lecsens_logo.png'),
            const SizedBox(height: 30),
            LoginForm(),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
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
