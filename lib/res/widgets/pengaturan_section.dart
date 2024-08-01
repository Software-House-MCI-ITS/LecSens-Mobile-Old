import 'package:flutter/material.dart';
import 'package:lecsens/utils/utils.dart';

class PengaturanSection extends StatelessWidget {
  const PengaturanSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
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
                // Handle onTap
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
                // Handle onTap
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
