// header_widget.dart
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;

  Header({
    this.title = 'Hello, Ahsana',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            'lib/res/images/lecsens_logo.png',
            height: 30.0,
          ),
        ],
      ),
    );
  }
}
