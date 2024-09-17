import 'package:flutter/material.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/viewModel/home_view_model.dart';
import 'package:lecsens/utils/utils.dart';

class PengaturanSection extends StatefulWidget {
  final HomeViewModel homeviewmodel;
  const PengaturanSection({super.key, required this.homeviewmodel});

  @override
  PengaturanSectionState createState() {
    return PengaturanSectionState();
  }
}

class PengaturanSectionState extends State<PengaturanSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengaturan',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 16),  // Add spacing between title and cards
          Card(
            color: Color(0xffD9E8FF),
            child: ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.logout),
              onTap: () {
                widget.homeviewmodel.logout(context);
              },
            ),
          ),
          const SizedBox(height: 8), 
          Card(
            color: Color(0xffD9E8FF),
            child: ListTile(
              title: const Text('Refresh data secara manual'),
              leading: const Icon(Icons.refresh),
              onTap: () {
                widget.homeviewmodel.manualSync(context);
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: const Color(0xffD9E8FF),
            child: ListTile(
              title: const Text('Hubungi kami melalui Whatsapp'),
              leading: const Icon(Icons.call),
              onTap: () {
                Utils.launchUrl(context, 'https://wa.me/6285156961624');
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: const Color(0xffD9E8FF),
            child: ListTile(
              title: const Text('Hubungi kami melalui Email'),
              leading: const Icon(Icons.email),
              onTap: () {
                Utils.mailClientLaunch(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
