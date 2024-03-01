import 'dart:math';

import 'package:nextgen/util/Constant.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html show window;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'package:platform_device_id_platform_interface/platform_device_id_platform_interface.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:html' as html;
import 'package:universal_html/html.dart' as uhtml;

import 'dart:io';
final googleSignIn = GoogleSignIn();

class Utils extends GetxController {
  // final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late SharedPreferences prefs;

  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  // Future<String> deviceInfo() async {
  //   late String deviceId;
  //   Random random = Random();
  //   int min = 10000000; // Smallest eight-digit number
  //   int max = 99999999; // Largest eight-digit number
  //
  //   deviceId = (min + random.nextInt(max - min)).toString();
  //
  //   debugPrint("deviceId deviceInfodeviceInfo: $deviceId");
  //
  //   await storeLocal.write(key: Constant.MY_DEVICE_ID, value: deviceId);
  //
  //   update();
  //
  //   return deviceId;
  // }

  Future<String> deviceInfo() async {
    String deviceIdentifier = "unknown";

    uhtml.Navigator navigator = html.window.navigator;
    String userAgent = navigator.userAgent;
    String vendor = navigator.vendor;
    int hardwareConcurrency = navigator.hardwareConcurrency ?? 0;

    deviceIdentifier = '$vendor$userAgent$hardwareConcurrency';
    debugPrint("deviceIdentifier: $deviceIdentifier");
    await storeLocal.write(key: Constant.MY_DEVICE_ID, value: deviceIdentifier);

    return deviceIdentifier;
  }


  // Future<String> deviceInfo() async {
  //   late String deviceId;
  //
  //   if (kIsWeb) {
  //     final userData = {
  //       'userAgent': 'Web user agent data',
  //       'language': 'Web language data',
  //       'platform': 'Web platform data',
  //     };
  //     final encodedData = json.encode(userData);
  //     final uniqueId = _generateMD5Hash(encodedData);
  //     deviceId = uniqueId;
  //     // deviceId = generateWebUniqueId();
  //   } else {
  //     AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
  //     deviceId = androidInfo.androidId;
  //   }
  // debugPrint("deviceId: $deviceId");
  //
  //   // final prefs = await SharedPreferences.getInstance();
  //   // prefs.setString(Constant.MY_DEVICE_ID, deviceId);
  //   await storeLocal.write(key: Constant.MY_DEVICE_ID, value: deviceId);
  //   return deviceId;
  // }

  String generateWebUniqueId() {
    final uuid = Uuid();
    return uuid.v4(); // Generate a random UUID for web
  }

  // String generateWebUniqueId() {
  //   final userData = {
  //     'userAgent': html.window.navigator.userAgent,
  //     'language': html.window.navigator.language,
  //     'platform': html.window.navigator.platform,
  //   };
  //   final encodedData = json.encode(userData);
  //   final uniqueId = _generateMD5Hash(encodedData);
  //   return uniqueId;
  // }

  String _generateMD5Hash(String input) {
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    return digest.toString();
  }

  void logout() async {
    SystemNavigator.pop();
  }
}

// class PlatformDeviceIdWebPlugin extends PlatformDeviceIdPlatform {
//   late SharedPreferences prefs;
//   static void registerWith(Registrar registrar) {
//     PlatformDeviceIdPlatform.instance = PlatformDeviceIdWebPlugin();
//   }
//
//   /// Returns a [String?] containing the ua of the web.
//   @override
//   Future<String?> getDeviceId() async {
//     String? version = html.window.navigator.userAgent;
//     debugPrint("version: $version");
//     final prefs = await SharedPreferences.getInstance();
//     await storeLocal.write(key: Constant.MY_DEVICE_ID, value: version);
//     return version;
//   }
// }
