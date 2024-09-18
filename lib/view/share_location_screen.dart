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
  ShareLocationStates _state = ShareLocationStates.mencariAlat;
  final _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(true);
  final TextEditingController _wifiNameController = TextEditingController();
  final TextEditingController _wifiPasswordController = TextEditingController();

  final FocusNode _wifiNameFocus = FocusNode();
  final FocusNode _wifiPasswordFocus = FocusNode();

  late MapController mapController = MapController.withUserPosition(
    trackUserLocation: const UserTrackingOption(
      enableTracking: false,
      unFollowUser: true,
    ),
  );

  void setPageState(ShareLocationStates state) {
    setState(() {
      _state = state;
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
    shareLocationViewModel.checkBluetooth(context);
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
                              Text(
                                'Pilih Alat Lecsens',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                              Padding(padding: EdgeInsets.only(left: 40, right: 40),
                                child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: shareLocationViewModel.btDevices.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    color: const Color(0xffD9E8FF),
                                    child: ListTile(
                                      title: Text(
                                        '${shareLocationViewModel.btDevices[index].name}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      trailing: const Icon(Icons.arrow_circle_right_outlined),
                                      onTap: () {
                                        value.setSelectedDevice(value.btDevices[index], context);
                                        setPageState(ShareLocationStates.mengambilDataLokasi);
                                      },
                                    ),
                                  );
                                },
                              ),
                              )
                            ])
                      );
                    case ShareLocationStates.mengambilDataLokasi:
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 500,
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
                            const SizedBox(height: 10),
                            Text(
                              'Konfirmasi koordinat pengambilan data',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(padding: EdgeInsets.only(left: 40, right: 40),
                              child: Text(
                                'Koordinat: ${shareLocationViewModel.currentLocation?.latitude}, ${shareLocationViewModel.currentLocation?.longitude}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  setPageState(ShareLocationStates.kirimDataLokasi);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff0078C1),
                                  minimumSize: const Size(150, 50),
                                  disabledBackgroundColor: Colors.grey,
                                ),
                                child: const Text(
                                  'Konfirmasi',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    case ShareLocationStates.kirimDataLokasi:
                      return Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            Padding(
                              padding: EdgeInsets.only(left: 40, right: 40),
                              child: Text(
                                'Konfirgurasi Wifi',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
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
                                        hintText: 'Nama Wifi',
                                      ),
                                      controller: _wifiNameController,
                                      focusNode: _wifiNameFocus,
                                      onFieldSubmitted: (value) {
                                        Utils.changeNodeFocus(context,
                                          current: _wifiNameFocus, next: _wifiPasswordFocus);
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Harap isi dengan nama wifi yang valid';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                                    child: ValueListenableBuilder(
                                      valueListenable: _obsecureNotifier,
                                      builder: ((context, value, child) {
                                        return TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Password Wifi',
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _obsecureNotifier.value ? Icons.visibility : Icons.visibility_off,
                                                color: Colors.grey,
                                              ),
                                              onPressed: () {
                                                _obsecureNotifier.value = !_obsecureNotifier.value;
                                              },
                                            ),
                                          ),
                                          controller: _wifiPasswordController,
                                          focusNode: _wifiPasswordFocus,
                                          obscureText: _obsecureNotifier.value,
                                          obscuringCharacter: "*",
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Harap isi dengan password wifi yang valid';
                                            }
                                            return null;
                                          },
                                        );
                                      }))
                                  ),
                                  const SizedBox(height: 30),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_wifiNameController.text.isEmpty || _wifiPasswordController.text.isEmpty) {
                                        Utils.showSnackBar(context, 'Harap isi semua field');
                                        return;
                                      } else {
                                        shareLocationViewModel.sendLocationData(context, _wifiNameController.text, _wifiPasswordController.text);
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