import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lecsens/res/widgets/button_with_icon.dart';
import 'package:lecsens/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';
import 'date_picker.dart' as dp;
import 'package:date_picker_timeline/date_picker_timeline.dart' as dt;
import 'chart_card.dart';
import 'package:lecsens/res/widgets/voltametry_card.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/res/widgets/info_section.dart';

class InfoSection extends StatefulWidget {
  final HomeViewModel homeviewmodel;
  const InfoSection({super.key, required this.homeviewmodel});

  @override
  _InfoSectionState createState() => _InfoSectionState();
}

class _InfoSectionState extends State<InfoSection> {
  // DateTime _selectedDate = DateTime.now();
  bool _infoVisible = false;

  // void _onDateChange(DateTime newDate) {
  //   setState(() {
  //     _selectedDate = newDate;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 3),
                  //   child: SizedBox(
                  //     height: 50,
                  //     child: dp.DatePicker(
                  //       restorationId: 'date_picker',
                  //       selectedDate: _selectedDate,
                  //       onDateChange: _onDateChange,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   height: 100,
                  //   padding: const EdgeInsets.only(left: 14, right: 14),
                  //   child: dt.DatePicker(
                  //     DateTime.now(),
                  //     width: 60,
                  //     height: 80,
                  //     initialSelectedDate: _selectedDate,
                  //     selectionColor: Colors.blue,
                  //     selectedTextColor: Colors.white,
                  //     locale: 'en',
                  //     onDateChange: (date) {
                  //       _onDateChange(date);
                  //     },
                  //   ),
                  // ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 20),
                      child: Text(
                      'Hasil Terakhir',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.all(16),
                    color: const Color(0xffD9E8FF),
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _infoVisible = !_infoVisible;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(left: 15),
                                  minimumSize: const Size(50, 30),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: Colors.transparent,
                                  overlayColor: Colors.transparent,
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.info, color: Colors.black),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    value.latestVoltametryData != null ? 
                                    (value.latestVoltametryData!.ppm < 90 ? 'Normal' : 'Bahaya')
                                    : 
                                    '-',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _infoVisible,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 16, right: 16, bottom: 25),
                            child: Text(
                              'Menampilkan hasil terakhir dalam cemaran dalam sehari.\n\nKetarangan :\nAman  = Kurang dari x Ppm\nBahaya  = Lebih dari X Ppm\n\nBatas aman mungkin berbeda setiap wilayah/negara, acuan yang di tampilkan hanya sebagai batas yang umum digunakan.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !_infoVisible,
                          child: Column(
                            children: [
                              Text(
                                value.latestVoltametryData != null ? value.latestVoltametryData!.ppm.toString() : '-',
                                style: const TextStyle(
                                  color: Color(0xff0078C1),
                                  fontSize: 70.0,
                                  height: 0.9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'ppm',
                                style: TextStyle(
                                  color: Color(0xff0078C1),
                                  fontSize: 25.0,
                                  height: 0.9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20, bottom: 30),
                                child: Container(
                                  height: 4,
                                  width: 200,
                                  decoration: const BoxDecoration(
                                    color: Color(0xff0078C1),
                                  ),
                                ),
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16, top: 20),
                      child: Text(
                      'Lihat Riwayat',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // VoltametryCard(title: 'Voltametri', homeviewmodel: widget.homeviewmodel),
                  // ChartCard(title: 'Harian', homeviewmodel: widget.homeviewmodel),
                  // ChartCard(title: 'Mingguan', homeviewmodel: widget.homeviewmodel)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWithIcon(text: 'Mikroplastik')
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWithIcon(text: 'Timbal'),
                      ButtonWithIcon(text: 'Merkuri'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWithIcon(text: 'Kadmium'),
                      ButtonWithIcon(text: 'Arsen'),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
