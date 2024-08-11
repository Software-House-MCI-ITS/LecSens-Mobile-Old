import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/utils/utils.dart';

// Define a custom Form widget.
class EmailVerificationForm extends StatefulWidget {
  const EmailVerificationForm({super.key});

  @override
  EmailVerificationFormState createState() {
    return EmailVerificationFormState();
  }
}

class EmailVerificationFormState extends State<EmailVerificationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isEmailVerificationCooldown = false;
  int _sendVerificationEmailCooldown = 60;
  Timer? _timer;

  void _startCooldownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_sendVerificationEmailCooldown <= 0) {
        _timer?.cancel();
        setState(() {
          _isEmailVerificationCooldown = false;
        });
      } else {
        _isEmailVerificationCooldown = true;
        setState(() {
          _sendVerificationEmailCooldown--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
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
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _isEmailVerificationCooldown ? 
              null
              :
              _startCooldownTimer();
              if (_formKey.currentState!.validate()) {
                Utils.showSnackBar(context, 'Email verifikasi berhasil dikirim');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isEmailVerificationCooldown ? const Color(0xff808080) : const Color(0xff0078C1),
              minimumSize: const Size(300, 50)
            ),
            child: 
            _isEmailVerificationCooldown ?
            Text(
              '$_sendVerificationEmailCooldown',
              style: TextStyle(color: Colors.white),
            )
            :
            const Text(
              'Kirim Ulang Email Verifikasi',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Kembali ke halaman ',
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
                  text: 'Mengalami masalah verifikasi email ? ',
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
