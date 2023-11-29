import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:nextgen/data/repository/full_time_repo.dart';
import 'package:nextgen/data/repository/home_repo.dart';
import 'package:nextgen/data/repository/work_repo.dart';
import 'package:nextgen/model/sync_data_list.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef SyncDataCallback = void Function(String syncDataSuccess);

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  late String syncDataSuccess = '';
  late SharedPreferences prefs;
  String todayAds = "";
  String totalAds = "";
  String balance = "";
  String ads_cost = "";
  String ads_time = "";
  String reward_ads = "";
  RxInt quantity = 0.obs; // Initial quantity
  RxString orderAvailable = ''.obs;
  RxString copiedText = ''.obs;
  RxInt today_order = 0.obs;
  RxInt total_order = 0.obs;
  RxString productEanCnt = ''.obs;
  RxBool isCoped = false.obs;
  RxBool isCheck = false.obs;
  // RxString work_day = ''.obs;
  int timer = 1;
  RxBool isLoading = false.obs;
  // String balance = "";
  // RxString ads_cost = "0.00".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // productEan.value = generateRandomNineDigitNumber().toString();
    // print("productEan: $productEan");
    // handleAsyncInit();
  }

  void productEanCorrent(String productEan) {
    productEanCnt.value = productEan;
    update();
    print("productEanCnt: $productEanCnt");
  }

  // void handleAsyncInit() async {
  //   work_day.value = (await storeLocal.read(key: Constant.WORK_DAYS))!;
  //   print("work_day: $work_day");
  // }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.ID);
  }

  void increaseQuantity() {
    isLoading.value = true;
    Timer(Duration(seconds: timer), () {
      quantity++; // Increment the quantity
      isLoading.value = false;
    });
    update();
  }

  void todayOrders() async {
    today_order++; // Increment the today_order
    await storeLocal.containsKey(key: Constant.TODAY_ORDERS);
    await storeLocal.write(
        key: Constant.TODAY_ORDERS, value: today_order.value.toString());
    update();
  }

  void totalOrders() async {
    total_order++; // Increment the today_order
    await storeLocal.containsKey(key: Constant.TOTAL_ORDERS);
    await storeLocal.write(
        key: Constant.TOTAL_ORDERS, value: total_order.value.toString());
    update();
  }

  void decreaseQuantity() {
    isLoading.value = true;
    Timer(Duration(seconds: timer), () {
      if (quantity > 0) {
        quantity--; // Decrement the quantity if it's greater than 0
        isLoading.value = false;
        update();
      }
    });
  }

  void checkAvailability(context, String productEan) async {
    isCheck.value = true;
    Timer(const Duration(seconds: 3), () async {
    debugPrint("productEan: $productEan");
    debugPrint("productEanCnt: $productEanCnt");
    if (productEanCnt == productEan) {
      orderAvailable.value =
          (await storeLocal.read(key: Constant.ORDERAVAILABLE))!;
      debugPrint("productEan: $productEan");
      update();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            orderAvailable == "1" ? "Available" : "Not Available",
            style: const TextStyle(
                fontFamily: 'MontserratBold',
                color: Colors.white,
                fontSize: Dimensions.FONT_SIZE_DEFAULT),
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: kPurpleColor,
          behavior: SnackBarBehavior.floating, // Add this line
          margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Check your correct product EAN number and then paste it here."),
        duration: Duration(seconds: 2),
        backgroundColor: kPurpleColor,
        behavior: SnackBarBehavior.floating, // Add this line
        margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      ));
    }
    isCheck.value = false;
    update();
    });
  }

  void copyText(context, String productEan) {
    // Clipboard.setData(ClipboardData(text: productEan));
    debugPrint("productEan: $productEan");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Copied Product EAN"),
      duration: Duration(seconds: 2),
      backgroundColor: kPurpleColor,
      behavior: SnackBarBehavior.floating, // Add this line
      margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
    ));
  }

  void pasteText(context,String productEan) async {
    isCoped.value = true;
    Timer(const Duration(seconds: 3), () async {
      copiedText.value = productEan;
      debugPrint("productEan: $productEan");
      // ClipboardData? data = await Clipboard.getData('text/plain');
      // if (data != null && data.text != null) {
      //   copiedText.value = data.text!;
      //   update();
      // }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Pasted Product EAN"),
        duration: Duration(seconds: 2),
        backgroundColor: kPurpleColor,
        behavior: SnackBarBehavior.floating, // Add this line
        margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      ));
      isCoped.value = false;
      update();
    });
  }

  int generateRandomSixDigitNumber() {
    // Generate a random number between 100000 and 999999
    Random random = Random();
    return 100000 + random.nextInt(900000);
  }

  int generateQtySoldNumber() {
    // Define the range for the nine-digit number
    const int lowerBound = 30;
    const int upperBound = 60;

    // Generate a random number within the specified range
    Random random = Random();
    return lowerBound + random.nextInt(upperBound - lowerBound + 1);
  }

  int generateRandomNineDigitNumber() {
    // Define the range for the nine-digit number
    const int lowerBound = 8901212330301;
    const int upperBound = 8905378181991;

    // Generate a random number within the specified range
    Random random = Random();
    return lowerBound + random.nextInt(upperBound - lowerBound + 1);
  }

  Future<void> syncData(
    userId,
    orders,
    SyncDataCallback callback, // Add the callback parameter
  ) async {
    prefs = await SharedPreferences.getInstance();
    try {
      final value = await homeRepo.syncData(userId, orders);
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
        colorText: kPrimaryColor,
        backgroundColor: kWhiteColor,
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

// import 'package:nextgen/data/api/api_client.dart';
// import 'package:nextgen/data/repository/home_repo.dart';
// import 'package:nextgen/data/repository/shorts_video_repo.dart';
// import 'package:nextgen/model/settings_data.dart';
// import 'package:nextgen/model/slider_data.dart';
// import 'package:nextgen/model/video_list.dart';
// import 'package:nextgen/util/Constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';
//
// class SliderItem {
//   final String imageUrl;
//
//   SliderItem(this.imageUrl);
// }
//
// class HomeController extends GetxController implements GetxService {
//   final HomeRepo homeRepo;
//   HomeController({required this.homeRepo});
//   final RxList sliderImageURL = [].obs;
//   final RxList sliderName = [].obs;
//   final RxList sliderItems = [].obs;
//   final RxInt currentIndex = 0.obs;
//   late SharedPreferences prefs;
//   final RxString a1JobDetailsURS = ''.obs;
//   final RxString a1JobVideoURS = ''.obs;
//   final RxString a1PurchaseURS = ''.obs;
//   final RxString a2JobDetailsURS = ''.obs;
//   final RxString a2JobVideoURS = ''.obs;
//   final RxString a2PurchaseURS = ''.obs;
//   final RxString watchAdStatus = ''.obs;
//   final RxString rewardAdsDetails = ''.obs;
//   final RxString referBonus = ''.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // allSettingsData();
//     // shortsVideoData();
//     // getUserId();
//   }
//
//   // @override
//   // void onInit() async {
//   //   super.onInit();
//   //   prefs = await SharedPreferences.getInstance();
//   //   slideList(prefs.getString(Constant.ID));
//   //   // allSettingsData();
//   //   // String? userId = await getUserId();
//   //   // slideList(userId);
//   // }
//
//   Future<String?> getUserId() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(Constant.ID);
//   }
//
//   Future<void> allSettingsData() async {
//     try {
//       final value = await homeRepo.allSettingsList();
//       var responseData = value.body;
//       SettingData settingData = SettingData.fromJson(responseData);
//       debugPrint("===> settingData: $settingData");
//       debugPrint("===> settingData message: ${settingData.message}");
//
//       for (var settingsData in settingData.data!) {
//         print(
//             'User ID: ${settingsData.id},\na1jobVideo: ${settingsData.a1JobVideo},\na1jobDetails: ${settingsData.a1JobDetails},\na1PurchaseLink: ${settingsData.a1PurchaseLink},\na2jobVideo: ${settingsData.a2JobVideo},\na2jobDetails: ${settingsData.a2JobDetails},\na2PurchaseLink: ${settingsData.a2PurchaseLink},\nwatchAdStatus: ${settingsData.watchAdStatus}');
//         a1JobDetailsURS.value = settingsData.a1JobDetails ?? '';
//         a1JobVideoURS.value = settingsData.a1JobVideo ?? '';
//         a1PurchaseURS.value = settingsData.a1PurchaseLink ?? '';
//         a2JobDetailsURS.value = settingsData.a2JobDetails ?? '';
//         a2JobVideoURS.value = settingsData.a2JobVideo ?? '';
//         a2PurchaseURS.value = settingsData.a2PurchaseLink ?? '';
//         watchAdStatus.value = settingsData.watchAdStatus ?? '';
//         rewardAdsDetails.value = settingsData.rewardAdsDetails ?? '';
//         referBonus.value = settingsData.referBonus ?? '';
//       }
//     } catch (e) {
//       debugPrint("shortsVideoData errors: $e");
//     }
//   }
//
//   Future<void> slideList(userId) async {
//     try {
//       final value = await homeRepo.sliderList(userId);
//       var responseData = value.body;
//       SliderDataItem sliderData = SliderDataItem.fromJson(responseData);
//       debugPrint("===> sliderData: $sliderData");
//       debugPrint("===> sliderData message: ${sliderData.message}");
//
//       // Clear the existing data before adding new data
//       sliderImageURL.clear();
//       sliderName.clear();
//
//       for (var slideData in sliderData.data!) {
//         print('User ID: ${slideData.id},  image: ${slideData.image}');
//         sliderImageURL.add(slideData.image ?? '');
//         sliderName.add(slideData.name ?? '');
//       }
//     } catch (e) {
//       debugPrint("shortsVideoData errors: $e");
//     }
//   }
// }
