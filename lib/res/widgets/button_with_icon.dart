import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  const ButtonWithIcon({super.key, required this.text});

  AssetImage _getImageAsset(String text) {
    switch (text) {
      case 'Arsen':
        return const AssetImage('lib/res/images/arsen.png');
      case 'Kadmium':
        return const AssetImage('lib/res/images/kadmium.png');
      case 'Merkuri':
        return const AssetImage('lib/res/images/merkuri.png');
      case 'Timbal':
        return const AssetImage('lib/res/images/timbal.png');
      default:
        return const AssetImage('lib/res/images/microplastics.png');
    }
  }

  double _getWidth() {
    switch (text) {
      case 'Mikroplastik':
        return 250;
      default:
        return 70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.riwayat, arguments: text);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffD9E8FF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Image(
                  image: _getImageAsset(text),
                  width: _getWidth(),
                  height: 70,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
