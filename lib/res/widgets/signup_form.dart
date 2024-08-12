import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/viewModel/auth_view_model.dart';
import 'package:provider/provider.dart';

// Define a custom Form widget.
class SignupForm extends StatefulWidget {
  final AuthViewModel authviewmodel;
  const SignupForm({super.key, required this.authviewmodel});

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  final ValueNotifier<bool> _obscureNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obscureConfirmationNotifier = ValueNotifier<bool>(true);
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  final FocusNode _addressFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _fullnameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _passwordConfirmationFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextFormField(
              controller: _usernameController,
              focusNode: _usernameFocus,
              onFieldSubmitted: (value) {
                Utils.changeNodeFocus(context,
                  current: _usernameFocus, next: _fullnameFocus);
              },
              decoration: const InputDecoration(
                label: Text('Username'),
                hintText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: _fullnameController,
              focusNode: _fullnameFocus,
              onFieldSubmitted: (value) {
                Utils.changeNodeFocus(context,
                  current: _fullnameFocus, next: _addressFocus);
              },
              decoration: const InputDecoration(
                label: Text('Nama Lengkap'),
                hintText: 'Nama Lengkap',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              controller: _addressController,
              focusNode: _addressFocus,
              onFieldSubmitted: (value) {
                Utils.changeNodeFocus(context,
                  current: _addressFocus, next: _emailFocus);
              },
              decoration: const InputDecoration(
                label: Text('Alamat'),
                hintText: 'Alamat',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
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
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: ValueListenableBuilder(
              valueListenable: _obscureNotifier,
              builder: ((context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: _obscureNotifier.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNotifier.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _obscureNotifier.value = !_obscureNotifier.value;
                      },
                    ),
                  ),
                );
              }),
            )
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 30),
            child: ValueListenableBuilder(
              valueListenable: _obscureConfirmationNotifier,
              builder: ((context, value, child) {
                return TextFormField(
                  controller: _passwordConfirmationController,
                  focusNode: _passwordConfirmationFocus,
                  obscureText: _obscureConfirmationNotifier.value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: 'Konfirmasi Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmationNotifier.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _obscureConfirmationNotifier.value = !_obscureConfirmationNotifier.value;
                      },
                    ),
                  ),
                );
              }),
            )
          ),
          ElevatedButton(
            onPressed: () {
              if (_emailController.text.isEmpty ||
              _addressController.text.isEmpty ||
              _fullnameController.text.isEmpty ||
              _passwordController.text.isEmpty ||
              _passwordConfirmationController.text.isEmpty) {
                Utils.showSnackBar(context, 'Harap isi semua field');
              } else if (_passwordController.text != _passwordConfirmationController.text) {
                Utils.showSnackBar(context, 'Password tidak sama');
              } else {
                final Map<String, dynamic> data = {
                  'user_name': _usernameController.text.toString(),
                  'full_name': _fullnameController.text.toString(),
                  'alamat' : _addressController.text.toString(),
                  'email': _emailController.text.toString(),
                  'password': _passwordController.text.toString(),
                };
                widget.authviewmodel.signUp(data, context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0078C1),
              minimumSize: const Size(300, 50)
            ),
            child: const Text(
              'Signup',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Sudah punya akun? ',
                  style: TextStyle(color: Colors.grey),
                ),
                TextSpan(
                  text: 'Login',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushNamed(context, RouteNames.login); 
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
