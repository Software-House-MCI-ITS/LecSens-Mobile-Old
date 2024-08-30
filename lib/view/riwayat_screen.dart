import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/viewModel/riwayat_view_model.dart';
import 'package:provider/provider.dart';

class RiwayatScreen extends StatefulWidget {
  final String text;
  const RiwayatScreen({super.key, required this.text});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  RiwayatViewModel riwayatViewModel = RiwayatViewModel();

  @override
  void initState() {
    super.initState();
    riwayatViewModel.setVoltametryDataListApi(context, widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Screen'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ChangeNotifierProvider<RiwayatViewModel>(
          create: (context) => riwayatViewModel,
          child: Consumer<RiwayatViewModel>(
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      'Riwayat Pengujian ${widget.text}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari disini ...',
                      ),
                    ),
                  ),
                  if (value.fetchingData)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.dataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            value.dataList[index].alamat,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(Utils().getFormattedDate(value.dataList[index].createdAt, 19)),
                          trailing: Text(
                            '${value.dataList[index].ppm} Ppm',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.detail, arguments: value.dataList[index]);
                          },
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        )
      ),
    );
  }
}
