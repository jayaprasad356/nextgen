import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:nextgen/data/model/sync_data_nextget.dart';
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

typedef SyncDataNextgenCallback = void Function(String syncDataNextgenSuccess);

class HomeController extends GetxController implements GetxService {
  final HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  late String syncDataNextgenSuccess = '';
  late SharedPreferences prefs;
  String syncTodayOrders = "";
  String syncTotalOrders = "";
  RxString syncOrderAvailable = "".obs;
  String balance = "";
  String ads_cost = "";
  String ads_time = "";
  String reward_ads = "";
  RxInt quantity = 0.obs; // Initial quantity
  RxString orderAvailable = ''.obs;
  RxString copiedText = ''.obs;
  RxInt today_order_con = 0.obs;
  RxString productEanCnt = ''.obs;
  RxBool isCoped = false.obs;
  RxBool isCheck = false.obs;
  RxString workDays = ''.obs;
  RxString totalOrder = ''.obs;
  RxString todayOrder = ''.obs;
  RxString averageOrders = ''.obs;
  RxString orderEarnings = ''.obs;
  int timer = 1;
  RxBool isLoading = false.obs;
  RxBool enablePlaceOrder = false.obs;
  // late int minQty;
  // late int maxQty;
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
  //   minQty = int.parse((await storeLocal.read(key: Constant.MIN_QTY))!);
  //   maxQty = int.parse((await storeLocal.read(key: Constant.MAX_QTY))!);
  //   print("handleAsyncInit minQty: ${minQty},maxQty: ${maxQty}");
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
    today_order_con++; // Increment the today_order
    await storeLocal.containsKey(key: Constant.TODAY_ORDERS_CON);
    await storeLocal.write(
        key: Constant.TODAY_ORDERS_CON,
        value: today_order_con.value.toString());
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

  void pasteText(context, String productEan) async {
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

  int generateQtySoldNumber(int minQty,int maxQty) {
    // Define the range for the nine-digit number
    // const int lowerBound = 30;
    // const int upperBound = 60;
    debugPrint("minQty.value: $minQty,maxQty.value: $maxQty");

    // Generate a random number within the specified range
    Random random = Random();
    return minQty + random.nextInt(maxQty - minQty + 1);
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
  totalQtySold,
    SyncDataNextgenCallback callback, // Add the callback parameter
  ) async {
    prefs = await SharedPreferences.getInstance();
    try {

      final value = await homeRepo.syncData(userId, orders,totalQtySold);
      var responseData = value.body;
      SyncDataNextgen syncDataNextgen = SyncDataNextgen.fromJson(responseData);
      debugPrint("===> syncDataNextgen: $syncDataNextgen");
      debugPrint("===> syncDataNextgen message: ${syncDataNextgen.message}");
      debugPrint("===> syncDataNextgen success: ${syncDataNextgen.success}");

      // syncDataNextgenSuccess = syncDataNextgen.success.toString();

      if (syncDataNextgen.data != null && syncDataNextgen.data!.isNotEmpty) {
        // syncTotalOrders = syncDataNextgen.data![0].totalOrders!;
        // syncTodayOrders = syncDataNextgen.data![0].totalOrders!;
        syncOrderAvailable.value = syncDataNextgen.data![0].orderAvailable!;
        workDays.value = syncDataNextgen.data![0].workedDays!;
        todayOrder.value = syncDataNextgen.data![0].todayOrders!;
        totalOrder.value = syncDataNextgen.data![0].totalOrders!;
        averageOrders.value = syncDataNextgen.data![0].averageOrders!;
        orderEarnings.value = syncDataNextgen.data![0].ordersEarnings!;
        debugPrint(
            "===> syncDataNextgen data: $syncOrderAvailable\n${workDays.value}\n${todayOrder.value}\n${totalOrder.value}\n${averageOrders.value}\n${orderEarnings.value}");

        await storeLocal.delete(key: Constant.ORDERAVAILABLE);
        await storeLocal.delete(key: Constant.WORK_DAYS);
        await storeLocal.delete(key: Constant.TODAY_ORDER);
        await storeLocal.delete(key: Constant.TOTAL_ORDER);
        await storeLocal.delete(key: Constant.AVERAGE_ORDER);
        await storeLocal.delete(key: Constant.ORDERS_EARNINGS);
        update();

        await storeLocal.write(
            key: Constant.ORDERAVAILABLE, value: syncOrderAvailable.value);
        await storeLocal.write(key: Constant.WORK_DAYS, value: workDays.value);
        await storeLocal.write(
            key: Constant.TOTAL_ORDER, value: totalOrder.value);
        await storeLocal.write(
            key: Constant.TODAY_ORDER, value: todayOrder.value);
        await storeLocal.write(
            key: Constant.AVERAGE_ORDER, value: averageOrders.value);
        await storeLocal.write(
            key: Constant.ORDERS_EARNINGS, value: orderEarnings.value);
        update();
      }
      //
      // prefs.setString(Constant.MOBILE, user.mobile);

      Get.snackbar(
        syncDataNextgen.success.toString(),
        syncDataNextgen.message.toString(),
        duration: const Duration(seconds: 3),
        colorText: kPrimaryColor,
        backgroundColor: kWhiteColor,
      );

      // Execute the callback after the function is completed
      callback(syncDataNextgen.success.toString());
    } catch (e) {
      debugPrint("syncDataNextgen errors: $e");
      // Handle errors
      callback('syncDataNextgen error');
    }
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Loading...'),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context).pop();
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
