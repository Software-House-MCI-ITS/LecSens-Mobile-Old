import 'package:flutter/material.dart';
import 'package:lecsens/models/voltametry_data_model.dart';
import 'package:lecsens/res/chart_data.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VoltametryCard extends StatefulWidget {
  VoltametryData voltametryData;
  VoltametryCard({super.key, required this.voltametryData});

  @override
  _VoltametryCardState createState() => _VoltametryCardState();
}

class _VoltametryCardState extends State<VoltametryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: const Color.fromARGB(255, 181, 222, 255),
      elevation: 5,
      child: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Voltametry',
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
              SfCartesianChart(
                series: <CartesianSeries>[
                  LineSeries<ChartData, double>(
                    dataSource: Utils.getConvertedVoltametryData(widget.voltametryData),
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                  )
                ],
              )
            ],
          );
        },
      )
    );
  }
}
