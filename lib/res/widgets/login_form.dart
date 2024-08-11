import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/viewModel/auth_view_model.dart';

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  final AuthViewModel authviewmodel;
  const LoginForm({super.key, required this.authviewmodel});

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(false);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Padding(padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextFormField(
              controller: _emailController,
              focusNode: _emailFocus,
              keyboardType: TextInputType.emailAddress,
              onFieldSubmitted: (value) {
                Utils.changeNodeFocus(context,
                  current: _emailFocus, next: _passwordFocus);
              },
              decoration: const InputDecoration(
                label: Text('Email'),
                hintText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 30),
            child: ValueListenableBuilder(
              valueListenable: _obsecureNotifier,
              builder: ((context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: _obsecureNotifier.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obsecureNotifier.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _obsecureNotifier.value = !_obsecureNotifier.value;
                      },
                    ),
                  ),
                );
              }),
            )
          ),
          ElevatedButton(
            onPressed: () {
              if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                Utils.showSnackBar(context, 'Email dan Password tidak boleh kosong');
              } else {
                final Map<String, dynamic> data = {
                  'email': _emailController.text.toString(),
                  'password': _passwordController.text.toString(),
                };
                widget.authviewmodel.login(data, context);
                debugPrint("hit API");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0078C1),
              minimumSize: const Size(300, 50)
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Belum punya akun? ',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: 'Signup',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, RouteNames.signup); 
                    },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Mengalami masalah saat login ? ',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: 'Hubungi kami',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      Utils.launchUrl(context, 'https://www.google.com');
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
