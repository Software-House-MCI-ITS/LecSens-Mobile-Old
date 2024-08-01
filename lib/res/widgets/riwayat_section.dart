import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LecsensData {
  final String title;
  final int id;
  final String date;
  final int status;

  LecsensData({
    required this.title,
    required this.id,
    required this.date,
    required this.status,
  });
}

class RiwayatSection extends StatelessWidget {
  RiwayatSection({super.key});
  List lecsensData = <LecsensData>[
    LecsensData(
      title: 'Kalimas',
      id: 1,
      date: '2021-10-10',
      status: 137,
    ),
    LecsensData(
      title: 'Kenjeran',
      id: 2,
      date: '2021-10-11',
      status: 130,
    ),
    LecsensData(
      title: 'Kalimas',
      id: 3,
      date: '2021-10-12',
      status: 135,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Riwayat',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Spacer(), // This will push the TextFormField to the right
                SizedBox(
                  width: 150, // Specify the width for the TextFormField
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Cari disini ...',
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter input';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // listview
            ListView.builder(
              shrinkWrap: true,
              itemCount: lecsensData.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(lecsensData[index].title),
                    subtitle: Text('ID : ${lecsensData[index].id} | ${lecsensData[index].date}'),
                    trailing: Text('${lecsensData[index].status}Ppm'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
