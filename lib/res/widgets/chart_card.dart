import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class ChartCard extends StatefulWidget {
  const ChartCard({
    super.key,
    required this.title,
  });

  final String title;

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  bool _infoVisible = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      color: const Color.fromARGB(255, 181, 222, 255),
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
                    padding: EdgeInsets.only(left: 15),
                    minimumSize: Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                  ),
                  child: Row(
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
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 25),
              child: Text(
                'Menampilkan data ${widget.title} yaitu 5 data pengambilan terakhir dengan waktu tertentu.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          Visibility(
            visible: !_infoVisible,
            child: SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),

            series: <LineSeries<SalesData, String>>[
              LineSeries<SalesData, String>(
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
              ),
            ],
          ),
          )
        ],
      ),
    );
  }
}
