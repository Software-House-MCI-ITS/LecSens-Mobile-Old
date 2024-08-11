import 'package:flutter/material.dart';
import '../res/widgets/email_verification_form.dart';
import 'package:lecsens/res/widgets/copyright_footer.dart';

class VerifikasiEmailScreen extends StatefulWidget {
  const VerifikasiEmailScreen({super.key});

  @override
  State<VerifikasiEmailScreen> createState() => _VerifikasiEmailScreenState();
}

class _VerifikasiEmailScreenState extends State<VerifikasiEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verifikasi Email', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            Image.asset('lib/res/images/lecsens_logo.png'),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.fromLTRB(50, 10, 50, 10),
              child: Text(
                'Email belum terverifikasi. Silahkan cek email inbox Anda. Tidak mendapatkan email verifikasi ? Silakan isi form berikut.',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            EmailVerificationForm(),
          ],
        ),
      ),
      bottomNavigationBar: const CopyrightFooter()
    );
  }
}
