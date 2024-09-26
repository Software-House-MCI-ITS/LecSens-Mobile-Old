import 'package:flutter/material.dart';
import 'package:lecsens/models/lecsens_data_model.dart';
import 'package:lecsens/res/widgets/chart_card.dart';
import 'package:lecsens/res/widgets/copyright_footer.dart';
import 'package:lecsens/res/widgets/voltametry_card.dart';
import 'package:lecsens/utils/utils.dart';

class DetailScreen extends StatelessWidget {
  LecsensData voltametryData;
  DetailScreen({super.key, required this.voltametryData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Data'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: VoltametryCard(voltametryData: voltametryData),
              ),
              const SizedBox(height: 30),
              Form(
                child: Column(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.fromLTRB(27, 0, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'Lokasi : ${voltametryData.alamat}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'Waktu : ${Utils().getFormattedDate(voltametryData.createdAt, 19)}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'Alat : ${voltametryData.alatID}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'Ppm : ${voltametryData.ppm}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'EPC : ${voltametryData.epc}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'IPC : ${voltametryData.ipc}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'IPA : ${voltametryData.ipa}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 0),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'EPA : ${voltametryData.epa}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.fromLTRB(27, 10, 27, 10),
                      child: TextFormField(
                        readOnly: true,
                        initialValue: 'Jenis polutan : ${voltametryData.label}',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CopyrightFooter(),
    );
  }
}