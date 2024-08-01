import 'package:flutter/material.dart';

class PengaturanSection extends StatelessWidget {
  const PengaturanSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool check_val = false;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: null,
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // backgroundColor: Colors.transparent,
              // overlayColor: Colors.transparent,
            ),
            child: Text(
              'Keluar',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
          TextButton(
            onPressed: null,
            style: TextButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              // backgroundColor: Colors.transparent,
              // overlayColor: Colors.transparent,
            ),
            child: Text(
              'Hubungi Kami',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
