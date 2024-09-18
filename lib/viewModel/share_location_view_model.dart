import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:uuid/uuid.dart';


class ShareLocationViewModel with ChangeNotifier {
  List<BluetoothDevice> _btDevices = [];
  GeoPoint? _currentLocation;
  BluetoothDevice? _selectedDevice;

  bool _isScanningDevices = false;

  get isScanningDevices => _isScanningDevices;
  get btDevices => _btDevices;
  get currentLocation => _currentLocation;
  get selectedDevice => _selectedDevice;

  void setScanningDevices(bool value) {
    _isScanningDevices = value;
    notifyListeners();
  }

  void updateCurrentLocation(GeoPoint location) {
    _currentLocation = location;
    notifyListeners();
  }

  void setSelectedDevice(BluetoothDevice device, BuildContext context) {
    _selectedDevice = device;
    
    try {
      _selectedDevice?.connect();
    } catch (e) {
      Utils.showSnackBar(context, 'Failed to connect to device');
    }

    notifyListeners();
  }

  void checkBluetooth(BuildContext context) async {
    if (await FlutterBluePlus.isSupported == false) {
      Utils.showSnackBar(context, 'Bluetooth is not supported');
      return;
    }

    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
      scanDevices();
    }
  }

  void scanDevices() async {
    setScanningDevices(true);
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));

    FlutterBluePlus.scanResults.listen((results) {
      List<BluetoothDevice> newDevices = [];
      for (ScanResult r in results) {
        if (!_btDevices.contains(r.device) && r.device.name != null && r.device.name.isNotEmpty) {
          newDevices.add(r.device);
        }
      }

      if (newDevices.isNotEmpty) {
        _btDevices = [..._btDevices, ...newDevices];
        notifyListeners();
      }
    });

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
    setScanningDevices(false);
  }

  Future<void> sendLocationData(BuildContext context, String wifiName, String wifiPass) async {
    Utils.showSnackBar(context, 'Mengirim data lokasi');
    
    try {
      await _selectedDevice!.connect();

      List<BluetoothService> services = await _selectedDevice!.discoverServices();

      for (var service in services) {
        for (var characteristic in service.characteristics) {
          print('uuid characteristic: ${characteristic.uuid}');
          if (characteristic.properties.write) {
            String data = '${wifiName};${wifiPass};token;${_currentLocation!.latitude};${_currentLocation!.longitude}';
            print('data: $data');
            List<int> list = utf8.encode(data);
            Uint8List bytes = Uint8List.fromList(list);

            characteristic.write(bytes);
          }
        }
      }

      for (var service in services) {
        for (var characteristic in service.characteristics) {
          print('uuid characteristic: ${characteristic.uuid}');
          if (characteristic.properties.notify) {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              print('Notification received: ${utf8.decode(value)}');
            });
          }
        }
      }
    } catch (e) {
      Utils.showSnackBar(context, 'Failed to send location data');
    }
  }
}
