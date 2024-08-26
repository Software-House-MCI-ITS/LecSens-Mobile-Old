import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/view/detail_screen.dart';
import 'package:lecsens/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';
import 'date_picker.dart' as dp;
import 'package:date_picker_timeline/date_picker_timeline.dart' as dt;
import 'package:lecsens/res/widgets/chart_card.dart';

class OverviewSection extends StatefulWidget {
  final HomeViewModel homeViewModel;
  OverviewSection({super.key, required this.homeViewModel});

  @override
  _OverviewSectionState createState() => _OverviewSectionState();
}

class _OverviewSectionState extends State<OverviewSection> {
  DateTime _selectedDate = DateTime.now();
  bool _infoVisible = false;

  void _onDateChange(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3),
                  child: SizedBox(
                    height: 50,
                    child: dp.DatePicker(
                      restorationId: 'date_picker',
                      selectedDate: _selectedDate,
                      onDateChange: (date) {
                        _onDateChange(date);
                        value.setVoltametryDataByDateList(date.toString());
                      },
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: dt.DatePicker(
                    DateTime.now().subtract(const Duration(days: 3)),
                    width: 60,
                    height: 80,
                    initialSelectedDate: _selectedDate,
                    selectionColor: Colors.blue,
                    selectedTextColor: Colors.white,
                    locale: 'en',
                    onDateChange: (date) {
                      _onDateChange(date);
                      value.setVoltametryDataByDateList(date.toString());
                    },
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
                                  value.latestVoltametryDataByDate != null ? 
                                  (value.latestVoltametryDataByDate!.ppm < 90 ? 'Normal' : 'Bahaya')
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
                              value.latestVoltametryDataByDate != null ? value.latestVoltametryDataByDate!.ppm.toString() : '-',
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
                ChartCard(title: 'Harian', voltametryDataList: value.voltametryDataByDateList),
                // ChartCard(title: 'Mingguan', homeviewmodel: widget.homeviewmodel)
              ],
            ),
          );
        },
      ),
    );
  }
}