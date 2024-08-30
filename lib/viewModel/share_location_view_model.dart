import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:uuid/uuid.dart';


class ShareLocationViewModel with ChangeNotifier {
  List<BluetoothDevice> _btDevices = [];
  String _locationData = '-7.289527, 112.796771';

  bool _isScanningDevices = false;

  get isScanningDevices => _isScanningDevices;
  get btDevices => _btDevices;

  void setScanningDevices(bool value) {
    _isScanningDevices = value;
    notifyListeners();
  }

  void setLocationData(String value) {
    _locationData = value;
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

  Future<void> scanDevices() async {
    setScanningDevices(true);
    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
    
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (!_btDevices.contains(r.device)) {
          _btDevices.add(r.device);
          notifyListeners();
        }
      }
    });
    
    await FlutterBluePlus.isScanning.where((val) => val == false).first;
    setScanningDevices(false);
  }

  Future<void> connectDevice(BluetoothDevice device) async {
    await device.connect();
  }

  Future<void> disconnectDevice(BluetoothDevice device) async {
    await device.disconnect();
  }

  Future<void> sendLocationData(BluetoothDevice device, BuildContext context) async {
    List<BluetoothService> services = await device.discoverServices();
    
    try {
      services.forEach((service) {
        if (service.uuid.toString() == '0000ffe0-0000-1000-8000-00805f9b34fb') {
          service.characteristics.forEach((characteristic) async {
            if (characteristic.uuid.toString() == '0000ffe1-0000-1000-8000-00805f9b34fb') {
              await characteristic.write(utf8.encode(_locationData));
              Utils.showSnackBar(context, 'Location data sent successfully');
            }
          });
        }
      }
    );
    } catch (e) {
      Utils.showSnackBar(context, 'Failed to send location data');
    }
    disconnectDevice(device);
  }
}
