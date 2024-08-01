import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lecsens/utils/utils.dart';

// Define a custom Form widget.
class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  SignupFormState createState() {
    return SignupFormState();
  }
}

class SignupFormState extends State<SignupForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harap isi dengan username';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nama Lengkap',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harap isi dengan nama lengkap';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: TextFormField(
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harap isi dengan email yang valid';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Role',
              ),
              onChanged: (String? value) {
                null;
              },
              items: <String>['Pengguna', 'Admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harap pilih role';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harap isi dengan password';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 5, 50, 30),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Konfirmasi Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              obscureText: _obscureText,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harap isi dengan password yang sama dengan password di atas';
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
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
