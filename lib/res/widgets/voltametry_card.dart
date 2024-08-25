import 'package:flutter/material.dart';
import 'package:lecsens/res/chart_data.dart';
import 'package:lecsens/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoltametryCard extends StatefulWidget {
  final HomeViewModel homeviewmodel;
  const VoltametryCard({super.key, required this.title, required this.homeviewmodel});

  final String title;

  @override
  _VoltametryCardState createState() => _VoltametryCardState();
}

class _VoltametryCardState extends State<VoltametryCard> {
  bool _infoVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: const Color.fromARGB(255, 181, 222, 255),
      elevation: 5,
      child: ChangeNotifierProvider<HomeViewModel>(
        create: (context) => widget.homeviewmodel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            return Column(
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
                            widget.title,  // Use the title property here
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 25),
                    child: Text(
                      'Menampilkan data ${widget.title} yaitu 5 data pengambilan terakhir dengan waktu tertentu.',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_infoVisible,
                  child: SfCartesianChart(
                    series: <CartesianSeries>[
                      LineSeries<ChartData, double>(
                        dataSource: value.chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                      )
                    ],
                  )
                )
              ],
            );
          },
        )
      )
    );
  }
}
