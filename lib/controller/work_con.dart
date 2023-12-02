import 'dart:math';

import 'package:flutter/services.dart';
import 'package:nextgen/data/repository/full_time_repo.dart';
import 'package:nextgen/data/repository/work_repo.dart';
import 'package:nextgen/model/sync_data_list.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SyncDataCallback = void Function(String syncDataSuccess);

class WorkCont extends GetxController implements GetxService {
  final WorkRepo workRepo;
  WorkCont({required this.workRepo});
  late String syncDataSuccess = '';
  late SharedPreferences prefs;
  String todayAds = "";
  String totalAds = "";
  String balance = "";
  String ads_cost = "";
  String ads_time = "";
  String reward_ads = "";
  RxInt quantity = 25.obs; // Initial quantity
  RxString orderAvailable = ''.obs;
  RxString copiedText = ''.obs;
  // String balance = "";
  // RxString ads_cost = "0.00".obs;


  void increaseQuantity() {
      quantity++; // Increment the quantity
    update();
  }

  void decreaseQuantity() {
    if (quantity > 0) {
        quantity--; // Decrement the quantity if it's greater than 0
      update();
    }
  }

  void checkAvailability() async {
    orderAvailable.value = (await storeLocal.read(key: Constant.ORDERAVAILABLE))!;
    update();
  }

  void copyText(context, copyString) {
    Clipboard.setData(ClipboardData(text: copyString));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Copied Product EAN"),
    ));
  }

  void pasteText(context) async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null && data.text != null) {
        copiedText.value = data.text!;
        update();
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Pasted Product EAN"),
    ));
  }
  
  int generateRandomSixDigitNumber() {
    // Generate a random number between 100000 and 999999
    Random random = Random();
    return 100000 + random.nextInt(900000);
  }

  int generateRandomNineDigitNumber() {
    // Generate a random number between 100000 and 999999
    Random random = Random();
    return 100000000 + random.nextInt(900000000);
  }

  Future<void> syncData(
      userId,
      orders,
      SyncDataCallback callback, // Add the callback parameter
      ) async {
    prefs = await SharedPreferences.getInstance();
    try {
      final value = await workRepo.syncData(
          userId, orders);
      var responseData = value.body;
      SyncDataList syncDataList = SyncDataList.fromJson(responseData);
      debugPrint("===> SyncDataList: $syncDataList");
      debugPrint("===> SyncDataList message: ${syncDataList.message}");
      debugPrint("===> SyncDataList success: ${syncDataList.success}");

      syncDataSuccess = syncDataList.success.toString();

      if (syncDataList.data != null && syncDataList.data!.isNotEmpty) {
        todayAds = syncDataList.data![0].todayAds!;
        totalAds = syncDataList.data![0].totalAds!;
        balance = syncDataList.data![0].balance!;
        ads_cost = syncDataList.data![0].adsCost!;
        ads_time = syncDataList.data![0].adsTime!;
        reward_ads = syncDataList.data![0].rewardAds!;
        // balance = syncDataList.data![0].balance!;
        // ads_cost.value = syncDataList.data![0].adsCost!;
        prefs.remove(Constant.TODAY_ADS);
        prefs.remove(Constant.TOTAL_ADS);
        prefs.remove(Constant.BALANCE);
        prefs.remove(Constant.ADS_COST);
        prefs.remove(Constant.ADS_TIME);
        prefs.remove(Constant.REWARD_ADS);

        prefs.setString(Constant.TODAY_ADS, todayAds);
        prefs.setString(Constant.TOTAL_ADS, totalAds);
        prefs.setString(Constant.BALANCE, balance);
        prefs.setString(Constant.ADS_COST, ads_cost);
        prefs.setString(Constant.ADS_TIME, ads_time);
        prefs.setString(Constant.REWARD_ADS, reward_ads);
      }

      // prefs.setString(Constant.MOBILE, user.mobile);

      Get.snackbar(
        syncDataList.success.toString(),
        syncDataList.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: kPrimaryColor,backgroundColor: kWhiteColor,
      );

      // Execute the callback after the function is completed
      callback(syncDataList.success.toString());
    } catch (e) {
      debugPrint("syncData errors: $e");
      // Handle errors
      callback('error');
    }
  }
}
