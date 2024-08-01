import 'package:flutter/material.dart';
import '../res/widgets/login_form.dart';
import 'package:lecsens/res/widgets/copyright_footer.dart';

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
      bottomNavigationBar: const CopyrightFooter()
    );
  }
}
