import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

import 'package:flutter/services.dart';
class DeviceInfo {
  late String deviceName;
  Future<String> getDeviceName() async {


    return deviceName;
  }
}