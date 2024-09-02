import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/res/widgets/copyright_footer.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:lecsens/viewModel/share_location_view_model.dart';
import 'package:provider/provider.dart';

enum ShareLocationStates {
  mencariAlat,
  mengambilDataLokasi,
  kirimDataLokasi,
}

class ShareLocationScreen extends StatefulWidget {
  const ShareLocationScreen({super.key});

  @override
  _ShareLocationScreenState createState() => _ShareLocationScreenState();
}

class _ShareLocationScreenState extends State<ShareLocationScreen> {
  ShareLocationViewModel shareLocationViewModel = ShareLocationViewModel();
  String _selectedDevice = '';
  ShareLocationStates _state = ShareLocationStates.mengambilDataLokasi;
  final _formKey = GlobalKey<FormState>();

  late MapController mapController = MapController.withUserPosition(
    trackUserLocation: const UserTrackingOption(
      enableTracking: false,
      unFollowUser: true,
    ),
  );

  void _selectDevice(String device) {
    setState(() {
      _selectedDevice = device;
      _state = ShareLocationStates.mengambilDataLokasi;
    });
  }

  void _getInitialLocation() async {
    GeoPoint? currentLocation = await mapController.myLocation();
    if (currentLocation != null) {
      shareLocationViewModel.updateCurrentLocation(currentLocation);
      await mapController.addMarker(
        currentLocation,
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
    }
  }

  Future<void> _pickLocation(GeoPoint pickedLocation) async {
    try {
      print("Picking location: ${pickedLocation.latitude}, ${pickedLocation.longitude}");
      await mapController.removeMarker(shareLocationViewModel.currentLocation!);
      await mapController.addMarker(
        pickedLocation,
        markerIcon: MarkerIcon(
          icon: Icon(
            Icons.location_pin,
            color: Colors.red,
            size: 48,
          ),
        ),
      );
      shareLocationViewModel.updateCurrentLocation(pickedLocation);
      mapController.moveTo(pickedLocation);
      Utils.showSnackBar(context, 'Picked ${shareLocationViewModel.currentLocation.longitude}');
    } catch (e) {
      print("Error in picking location: $e");
      Utils.showSnackBar(context, 'Failed to pick location');
    }
  }

  @override
  void initState() {
    super.initState();
    mapController.listenerMapSingleTapping.addListener(() {
      if (mapController.listenerMapSingleTapping.value != null) {
        _pickLocation(mapController.listenerMapSingleTapping.value!);
      }
    });
    // shareLocationViewModel.checkBluetooth(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: null,
      child: ChangeNotifierProvider<ShareLocationViewModel>(
        create: (context) => shareLocationViewModel,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tetapkan Lokasi Alat Lecsens'),
          ),
          body: Consumer<ShareLocationViewModel>(
            builder: (context, value, child) {
              return Builder(
                builder: (context) {
                  switch (_state) {
                    case ShareLocationStates.mencariAlat:
                      return Center(
                        child: 
                          Column(
                            children: [
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  value.scanDevices();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff0078C1),
                                  minimumSize: const Size(150, 50),
                                  disabledBackgroundColor: Colors.grey,
                                ),
                                child: const Text(
                                  'Rescan Lecsens',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 20),
                              value.isScanningDevices ? const CircularProgressIndicator() : const SizedBox(),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: value.btDevices.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Card(
                                    color: const Color(0xffD9E8FF),
                                    child: ListTile(
                                      title: Text(
                                        value.btDevices[index].name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: const Icon(Icons.arrow_circle_right_outlined),
                                      onTap: () {
                                        _selectDevice(value.btDevices[index].id);
                                      },
                                    ),
                                  );
                                },
                              )
                            ])
                      );
                    case ShareLocationStates.mengambilDataLokasi:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 650,
                              width: double.infinity,
                              child: OSMFlutter(
                                controller: mapController,
                                osmOption: OSMOption(
                                  userTrackingOption: UserTrackingOption(
                                    enableTracking: true,
                                    unFollowUser: false,
                                  ),
                                  zoomOption: const ZoomOption(
                                    initZoom: 20,
                                    minZoomLevel: 3,
                                    maxZoomLevel: 19,
                                    stepZoom: 1.0,
                                  ),
                                  userLocationMarker: UserLocationMaker(
                                    personMarker: MarkerIcon(
                                      icon: Icon(
                                        Icons.location_pin,
                                        color: Colors.red,
                                        size: 48,
                                      ),
                                    ),
                                    directionArrowMarker: MarkerIcon(
                                      icon: Icon(
                                        Icons.double_arrow,
                                        size: 48,
                                      ),
                                    ),
                                  ),
                                  roadConfiguration: RoadOption(
                                    roadColor: Colors.yellowAccent,
                                  ),
                                  isPicker: true,
                                  showDefaultInfoWindow: true,
                                  enableRotationByGesture: false,
                                ),
                                 onMapIsReady: (isReady) async {
                                  if (isReady) {
                                    _getInitialLocation();
                                    await mapController.addMarker(
                                      shareLocationViewModel.currentLocation!,
                                      markerIcon: MarkerIcon(
                                        icon: Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 48,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    case ShareLocationStates.kirimDataLokasi:
                      return Center(
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.lightBlue,
                              margin: const EdgeInsets.only(top: 20),
                              child: Column(
                                children: [
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
                              ),
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
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
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
                        ),
                      );
                  }
                },
              );
            },
          ),
          bottomNavigationBar: const CopyrightFooter(),
        ),
      )
      
      
      
      
    );
  }
}