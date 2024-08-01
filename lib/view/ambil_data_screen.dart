import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/res/widgets/copyright_footer.dart';
import 'package:lecsens/utils/utils.dart';

enum AmbilDataStates {
  mencariAlat,
  mengambilData,
  validasiData,
}

class AmbilDataScreen extends StatefulWidget {
  const AmbilDataScreen({super.key});

  @override
  _AmbilDataScreenState createState() => _AmbilDataScreenState();
}

class _AmbilDataScreenState extends State<AmbilDataScreen> {
  String _selectedDevice = '';
  AmbilDataStates _state = AmbilDataStates.mencariAlat;
  final _formKey = GlobalKey<FormState>();

  void _selectDevice(String device) {
    setState(() {
      _selectedDevice = device;
      _state = AmbilDataStates.mengambilData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambil Data'),
      ),
      body: Builder(
        builder: (context) {
          switch (_state) {
            case AmbilDataStates.mencariAlat:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('lib/res/images/alat.png'),
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Mencari alat ...',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          Card(
                            color: Color(0xffD9E8FF),
                            child: ListTile(
                              title: const Text(
                                'LC-001',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_circle_right_outlined),
                              onTap: () {
                                _selectDevice('LC-001');
                              },
                            ),
                          ),
                          Card(
                            color: Color(0xffD9E8FF),
                            child: ListTile(
                              title: const Text(
                                'LC-002',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_circle_right_outlined),
                              onTap: () {
                                _selectDevice('LC-002');
                              },
                            ),
                          ),
                          Card(
                            color: const Color(0xffD9E8FF),
                            child: ListTile(
                              title: const Text(
                                'LC-003',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_circle_right_outlined),
                              onTap: () {
                                _selectDevice('LC-003');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            case AmbilDataStates.mengambilData:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('lib/res/images/alat.png'),
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Mengambil data dari $_selectedDevice ...',
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Utils.showSnackBar(context, 'Data berhasil diambil');
                        setState(() {
                          _state = AmbilDataStates.validasiData;
                        });
                      },
                      child: const Text('Ambil Data'),
                    ),
                  ],
                )
              );
            case AmbilDataStates.validasiData:
              return Center(
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.lightBlue,
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(children: [
                        const SizedBox(height: 20),
                        Text(
                          '130',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ppm',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                      )
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Text(
                      'Mohon validasi data berikut sebelum mengunggah data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Lokasi',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Harap isi dengan email yang valid';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Utils.uploadData(context, '130 ppm');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff0078C1),
                              minimumSize: const Size(300, 50),
                              disabledBackgroundColor: Colors.grey,
                            ),
                            child: const Text(
                              'Unggah Data',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              );
          }
        },
      ),
      bottomNavigationBar: const CopyrightFooter(),
    );
  }
}
