import 'package:flutter/material.dart';

class CopyrightFooter extends StatelessWidget {
  const CopyrightFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          '© 2022 Tim Riset. All rights reserved v22.1',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}