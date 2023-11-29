import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:nextgen/Helper/apiCall.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/controller/full_time_page_con.dart';
import 'package:nextgen/controller/home_con.dart';
import 'package:nextgen/controller/home_con.dart';
import 'package:nextgen/model/slider_data.dart';
import 'package:nextgen/model/user.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/image_const.dart';
import 'package:nextgen/util/index.dart';
import 'package:nextgen/view/widget/default_back.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import 'package:slide_action/slide_action.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final AuthCon authCon = Get.find<AuthCon>();
  late SharedPreferences prefs;
  double starttime = 0; // Set the progress value between 0.0 and 1.0 here
  String today_ads_remain = "0";
  String level = '0', status = '';
  String history_days = '0';
  String ads_image = 'https://admin.colorjobs.site/dist/img/logo.jpeg';
  String ads_link = '';
  int time_start = 0;
  double seconds = 0.0;
  String time_left = '0';
  String max_coin = "0";
  String refer_amount = "0";
  String generate_coin = "0";
  bool _isLoading = true;
  String balance = "0";
  String ads_cost = "0";
  bool timerStarted = false;
  bool isTrial = true, isPremium = false;
  Random random = Random();
  late String contact_us;
  final TextEditingController _serialController = TextEditingController();
  String serilarandom = "",
      basic_wallet = "",
      // premium_wallet = "",
      target_refers = "",
      today_ads = "0",
      total_ads = "0",
      reward_ads = "0",
      ads_time = "0";
  double progressbar = 0.0;
  late String image = "", referText = "", offer_image = "", refer_bonus = "";
  int orderCount = 0;
  int rewardAds = 0;
  double progressPercentage = 0.0;
  double progressPercentageTwo = 0.0;
  late bool isButtonDisabled;
  late bool isClaimButtonDisabled;
  late String generatedOtp;
  late String syncType;
  int syncUniqueId = 1;
  double multiplyCostValue = 0;
  double maximumValue = 120.0;
  double currentValue = 60.0;
  double progressPercentage1 = 0.00;
  late String isWeb;
  String orderAvailable = '1';
  String productEan = '';
  String qtySold = '';
  bool enablePlaceOrder = false;
  bool isPlaceOrder = false;
  bool isConfirm = false;

  @override
  void initState() {
    super.initState();
    resetValue();
    handleAsyncInit();
    progressPercentage1 = currentValue / maximumValue;

    isButtonDisabled = true;
    isClaimButtonDisabled = true;

    loadTimerCount();
    debugPrint("orderAvailable: $orderAvailable");
    debugPrint("orderCount: $orderCount");

    // progressPercentageTwo = double.parse(reward_ads);
    // debugPrint("progressPercentageTwo : $progressPercentageTwo");
  }

  void handleAsyncInit() async {
    productEan = homeController.generateRandomNineDigitNumber().toString();
    qtySold = homeController.generateQtySoldNumber().toString();
    homeController.productEanCorrent(productEan);
    // homeController.handleAsyncInit();
    setState(() async {
      var todayOrder = await storeLocal.read(key: Constant.TODAY_ORDERS);
      var totalOrders = await storeLocal.read(key: Constant.TOTAL_ORDERS);
      homeController.today_order.value = int.parse(todayOrder!);
      homeController.total_order.value = int.parse(totalOrders!);
      isWeb = (await storeLocal.read(key: Constant.IS_WEB))!;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productEan = homeController.generateRandomNineDigitNumber().toString();
  }

  @override
  void setState(VoidCallback fn) async {
    // TODO: implement setState
    super.setState(fn);

    // balance;
    // total_ads;
    // today_ads;
    // multiplyCostValue = multiplyCost(orderCount, ads_cost)!;
    if (orderCount < 100) {
      isButtonDisabled = true; // Disable the button
    } else if (orderCount >= 100) {
      isButtonDisabled = false; // Enable the button
    } else if (orderCount > 100) {
      progressPercentage = 0.0;
      isButtonDisabled = false; // Enable the button
      orderCount = 0;
    }
    rewardAds = int.parse(reward_ads);
    debugPrint("rewardAds : $rewardAds");
    progressPercentageTwo = double.parse(reward_ads) / maximumValue;
    debugPrint("progressPercentageTwo : $progressPercentageTwo");

    if (rewardAds < 100) {
      isClaimButtonDisabled = true; // Disable the button
    } else if (rewardAds >= 100) {
      syncUniqueId = homeController.generateRandomSixDigitNumber();
      isClaimButtonDisabled = false; // Enable the button
    }
  }

  // void startTimer() {
  //   // Example: Countdown from 100 to 0 with a 1-second interval
  //   const oneSec = Duration(seconds: 1);
  //   int adsTimeInSeconds = int.parse(ads_time);
  //   Timer.periodic(oneSec, (Timer timer) {
  //     if (starttime >= adsTimeInSeconds) {
  //       timer.cancel();
  //
  //       setState(() {
  //         progressbar = 0.0;
  //         timerStarted = false;
  //         progressPercentage;
  //       });
  //       orderCount++;
  //       print('timerCount called $orderCount times.');
  //       multiplyCostValue = orderCount * double.parse(ads_cost);
  //       setState(() {
  //         progressPercentage = (orderCount / maximumValue);
  //         debugPrint("timerCount: $orderCount");
  //         saveTimerCount(orderCount, multiplyCostValue);
  //         if (orderCount < 119) {
  //           isButtonDisabled = true; // Disable the button
  //         } else if (orderCount >= 119) {
  //           syncUniqueId = homeController.generateRandomSixDigitNumber();
  //           debugPrint("syncUniqueId: $syncUniqueId");
  //           isButtonDisabled = true; // Disable the button
  //           // orderCount = 0;
  //         } else if (orderCount == 120) {
  //           isButtonDisabled = false; // Enable the button
  //           // orderCount = 0;
  //         } else if (orderCount > 120) {
  //           progressPercentage = 0.0;
  //           isButtonDisabled = false; // Enable the button
  //           orderCount = 0;
  //         }
  //       });
  //       // if (timerCount < 100) {
  //       //   isButtonDisabled = true; // Disable the button
  //       // } else if (timerCount >= 100) {
  //       //   syncUniqueId = fullTimePageCont.generateRandomSixDigitNumber();
  //       //   isButtonDisabled = false; // Enable the button
  //       //   // timerCount = 1;
  //       // }
  //     } else {
  //       setState(() {
  //         starttime++;
  //         seconds = starttime % adsTimeInSeconds;
  //         progressbar = starttime / adsTimeInSeconds;
  //       });
  //     }
  //   });
  // }

  // Load timerCount from shared preferences
  void loadTimerCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      orderCount = prefs.getInt('timerCount') ?? 0;
      multiplyCostValue = orderCount * double.parse(ads_cost);
      progressPercentage = (orderCount / maximumValue);
    });
  }

  // Save timerCount to shared preferences
  void saveTimerCount(int count, double cost) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timerCount', count);
    await prefs.setDouble('multiplyCostValueLocal', cost);
  }

  String separateNumber(String number) {
    if (number.length != 12) {
      throw Exception("Number must be 12 digits long.");
    }

    List<String> groups = [];

    for (int i = 0; i < 12; i += 4) {
      groups.add(number.substring(i, i + 4));
    }

    return groups.join('-');
  }

  bool isMultipleOf5(int number) {
    return number % 5 == 0;
  }

  double? multiplyCost(int timerCount, String str2) {
    try {
      double num2 = double.parse(str2);
      return timerCount * num2;
    } catch (e) {
      print('Error: Unable to parse the input string as a number.');
      return null;
    }
  }

  void resetValue() {
    setState(() {
      homeController.copiedText.value = '';
      homeController.quantity.value = 0;
      homeController.orderAvailable.value = '0';
      qtySold = homeController.generateQtySoldNumber().toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgLinear4,
      body: DefaultBack(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 3, color: Colors.white),
              borderRadius:
                  BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 35.0,
                      lineWidth: 10.0,
                      animation: true,
                      percent: progressPercentage.clamp(0.0, 1.0),
                      backgroundWidth: 13,
                      center: Text(
                        (progressPercentage * maximumValue)
                            .toInt()
                            .toString(),
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            fontSize: 16.0,
                            color: kTextColor),
                      ),
                      footer: IgnorePointer(
                        ignoring: isClaimButtonDisabled,
                        child: InkWell(
                          onTap: () async {
                            syncType = 'reward_sync';
                            debugPrint("syncType: $syncType");
                            try {
                              prefs = await SharedPreferences.getInstance();
                              setState(() {
                                syncUniqueId;
                              });
                              debugPrint("syncUniqueId: $syncUniqueId");
                              // Call the syncData function and get the result immediately
                              // homeController.syncData(
                              //   prefs.getString(Constant.ID),
                              //   orderCount.toString(),
                              //   (String syncDataSuccess) {
                              //     debugPrint(
                              //         "syncDataSuccess: $syncDataSuccess");
                              //     // Perform actions based on the result of the syncData function
                              //     if (syncDataSuccess == 'true') {
                              //       setState(() {
                              //         isClaimButtonDisabled = true;
                              //         reward_ads = prefs.getString(
                              //             Constant.REWARD_ADS)!;
                              //         ads_time = prefs.getString(
                              //             Constant.ADS_TIME)!;
                              //         balance = prefs
                              //             .getString(Constant.BALANCE)!;
                              //         today_ads = prefs.getString(
                              //             Constant.TODAY_ADS)!;
                              //         total_ads = prefs.getString(
                              //             Constant.TOTAL_ADS)!;
                              //         ads_cost = prefs.getString(
                              //             Constant.ADS_COST)!;
                              //       });
                              //     } else {}
                              //   },
                              // );
                            } catch (e) {
                              // Handle any errors that occur during the process
                              debugPrint("Error: $e");
                            }
                          },
                          child: Container(
                            decoration: isClaimButtonDisabled == false
                                ? BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.deepOrangeAccent,
                                        Colors.pink,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  )
                                : BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            margin: const EdgeInsets.only(top: 10),
                            child: Text(
                              "Sync",
                              style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  fontSize: 12.0,
                                  color: isClaimButtonDisabled == false
                                      ? Colors.white
                                      : Colors.grey[500]
                                  // : Colors.orangeAccent[200],
                                  ),
                            ),
                          ),
                        ),
                      ),
                      linearGradient: const LinearGradient(
                        colors: [
                          Colors.deepOrangeAccent,
                          Colors.pink,
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      // progressColor: Colors.deepOrangeAccent,
                    ),
                    const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          child: const Text(
                            "Wallet Balance",
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                color: Colors.white,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                          ),
                        ),
                        const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Today Orders :",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "Total Orders :",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "Work Days :",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "My Daily Average :",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "Department Store",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kPurpleColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                              ],
                            ),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Obx(
                                  () => Text(
                                    homeController.today_order.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'MontserratBold',
                                        color: kTextColor,
                                        fontSize: Dimensions.FONT_SIZE_SMALL),
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Obx(
                                  () => Text(
                                    homeController.total_order.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'MontserratBold',
                                        color: kTextColor,
                                        fontSize: Dimensions.FONT_SIZE_SMALL),
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Obx(
                                  () => Text(
                                    authCon.work_days.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'MontserratBold',
                                        color: kTextColor,
                                        fontSize: Dimensions.FONT_SIZE_SMALL),
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                const Text(
                                  "500",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const Text(
                          "Copy",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: kTextColor,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT),
                        ),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        InkWell(
                          onTap: () {
                            homeController.copyText(context, productEan);
                          },
                          child: Container(
                            height: Dimensions.BUTTON_HEIGHT,
                            width: size.width * 0.15,
                            decoration: BoxDecoration(
                              color: kPurpleColor,
                              borderRadius: BorderRadius.circular(1000),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.purple.shade800,
                                  width: 4.0,
                                ),
                                right: BorderSide(
                                  color: Colors.purple.shade800,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: const Icon(
                              Icons.copy,
                              color: kWhiteColor,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Column(
                      children: [
                        const Text(
                          "Product EAN",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: kTextColor,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT),
                        ),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Container(
                          height: Dimensions.BUTTON_HEIGHT,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.PADDING_SIZE_SMALL),
                          alignment: Alignment.center,
                          child: Text(
                            productEan,
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Colors.purple.shade800,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Column(
                      children: [
                        const Text(
                          "Qty Sold",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: kTextColor,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT),
                        ),
                        const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                        Container(
                          height: Dimensions.BUTTON_HEIGHT,
                          width: size.width * 0.2,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(1000),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            qtySold,
                            style: const TextStyle(
                                fontFamily: 'MontserratBold',
                                color: Colors.white,
                                fontSize: Dimensions.FONT_SIZE_DEFAULT),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const Text(
                        "Place Order From Warehouse",
                        style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: kWhiteColor,
                            fontSize: Dimensions.FONT_SIZE_LARGE),
                      ),
                      const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Obx(
                                () => InkWell(
                                  onTap: () {
                                    if (homeController.isCoped.value != true) {
                                      debugPrint(
                                          'homeController.isCoped.value: ${homeController.isCoped.value}');
                                      homeController.pasteText(context,productEan);
                                    }
                                  },
                                  child: Container(
                                    height: Dimensions.BUTTON_HEIGHT,
                                    width: size.width * 0.15,
                                    decoration: BoxDecoration(
                                      color: kPurpleColor,
                                      borderRadius: BorderRadius.circular(1000),
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.purple.shade800,
                                          width: 4.0,
                                        ),
                                        right: BorderSide(
                                          color: Colors.purple.shade800,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: homeController.isCoped == true
                                        ? const CupertinoActivityIndicator(
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.paste,
                                            color: kWhiteColor,
                                            size: 14,
                                          ),
                                  ),
                                ),
                              ),
                              const Text(
                                "Paste",
                                style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: Colors.white,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
                              ),
                            ],
                          ),
                          Container(
                              height: Dimensions.BUTTON_HEIGHT,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.PADDING_SIZE_SMALL),
                              alignment: Alignment.center,
                              child: Obx(
                                () => Text(
                                  homeController.copiedText.isEmpty
                                      ? '                            '
                                      : homeController.copiedText.toString(),
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: Colors.purple.shade800,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                ),
                              )),
                          Obx(
                            () => InkWell(
                              onTap: homeController.copiedText.isEmpty
                                  ? () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Product EAN is blank. Copy and paste your product EAN number.",
                                          ),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: kPurpleColor,
                                          behavior: SnackBarBehavior
                                              .floating, // Add this line
                                          margin: EdgeInsets.only(
                                              bottom: 10, left: 15, right: 15),
                                        ),
                                      );
                                    }
                                  : () {
                                      homeController
                                          .productEanCorrent(productEan);
                                      if (homeController.isCheck.value !=
                                          true) {
                                        homeController.checkAvailability(
                                            context,
                                            homeController.copiedText
                                                .toString());
                                      }
                                    },
                              child: Container(
                                height: Dimensions.BUTTON_HEIGHT,
                                width: size.width * 0.2,
                                decoration: BoxDecoration(
                                  // color: Colors.grey,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF569DAA),
                                      Color(0xFF0A4D68),
                                    ],
                                  ),
                                  border: const Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF0A3648),
                                      width: 4.0,
                                    ),
                                    right: BorderSide(
                                      color: Color(0xFF0A3648),
                                      width: 2.0,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(1000),
                                ),
                                alignment: Alignment.center,
                                child: homeController.isCheck == true
                                    ? const CupertinoActivityIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        "Check",
                                        style: TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: Colors.white,
                                            fontSize:
                                                Dimensions.FONT_SIZE_DEFAULT),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => homeController.orderAvailable == "1"
                            ? const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL)
                            : Container(),
                      ),
                      Obx(
                        () => homeController.orderAvailable == "1"
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      const Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: kTextColor,
                                            fontSize:
                                                Dimensions.FONT_SIZE_LARGE),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () => homeController
                                                .decreaseQuantity(),
                                            child: Image.asset(
                                              AppIcons.MINUS_REGTAGLE,
                                              height: 30,
                                            ),
                                          ),
                                          const SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          Obx(
                                            () => homeController.isLoading.value
                                                ? const SizedBox(
                                                    height: 40,
                                                    width: 40,
                                                    child:
                                                        CupertinoActivityIndicator(
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 40,
                                                    width: 40,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      homeController.quantity
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            'MontserratBold',
                                                        color: kWhiteColor,
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_ULTRA_LARGE,
                                                      ),
                                                    ),
                                                  ),
                                          ),
                                          const SizedBox(
                                              width: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          InkWell(
                                            onTap: () => homeController
                                                .increaseQuantity(),
                                            child: Image.asset(
                                              AppIcons.PIUSE_REGTAGLE,
                                              height: 30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                      width:
                                          Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        isConfirm = true;
                                      });
                                      Timer(const Duration(seconds: 3),
                                          () async {
                                        if (qtySold ==
                                            homeController.quantity
                                                .toString()) {
                                          debugPrint(
                                              'qtySold == homeController.quantity');
                                          debugPrint('qtySold:$qtySold');
                                          debugPrint(
                                              'homeController.quantity:${homeController.quantity}');
                                          setState(() {
                                            enablePlaceOrder = true;
                                          });
                                        } else {
                                          debugPrint(
                                              'qtySold != homeController.quantity');
                                          debugPrint('qtySold:$qtySold');
                                          debugPrint(
                                              'homeController.quantity:${homeController.quantity.value}');
                                          setState(() {
                                            enablePlaceOrder = false;
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                "Please correct your Quantity.",
                                              ),
                                              duration: Duration(seconds: 2),
                                              backgroundColor: kPurpleColor,
                                              behavior: SnackBarBehavior
                                                  .floating, // Add this line
                                              margin: EdgeInsets.only(
                                                  bottom: 10,
                                                  left: 15,
                                                  right: 15),
                                            ),
                                          );
                                        }
                                        setState(() {
                                          isConfirm = false;
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: Dimensions.BUTTON_HEIGHT,
                                      width: size.width * 0.36,
                                      decoration: BoxDecoration(
                                        // color: Colors.grey,
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF569DAA),
                                            Color(0xFF0A4D68),
                                          ],
                                        ),
                                        border: const Border(
                                          bottom: BorderSide(
                                            color: Color(0xFF0A3648),
                                            width: 4.0,
                                          ),
                                          right: BorderSide(
                                            color: Color(0xFF0A3648),
                                            width: 2.0,
                                          ),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                      alignment: Alignment.center,
                                      child: isConfirm == true
                                          ? const CupertinoActivityIndicator(
                                              color: Colors.white,
                                            )
                                          : const Text(
                                              "Confirm",
                                              style: TextStyle(
                                                  fontFamily: 'MontserratBold',
                                                  color: Colors.white,
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_DEFAULT),
                                            ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                      Obx(
                        () => homeController.orderAvailable == "1"
                            ? const SizedBox(
                                height: Dimensions.PADDING_SIZE_SMALL)
                            : Container(),
                      ),
                      Obx(
                        () => homeController.orderAvailable == "1"
                            ? InkWell(
                                onTap: enablePlaceOrder == true
                                    ? () {
                                        setState(() {
                                          enablePlaceOrder = false;
                                          isPlaceOrder = true;
                                        });
                                        // setState(() {
                                        //   isPlaceOrder = true;
                                        // });
                                        Timer(const Duration(seconds: 4), () {
                                          // setState(() {
                                          //   isPlaceOrder = false;
                                          // });
                                          homeController.todayOrders();
                                          homeController.totalOrders();
                                          orderCount++;
                                          print('orderCount called $orderCount times.');
                                          multiplyCostValue = orderCount * double.parse(ads_cost);
                                          setState(() {
                                            isPlaceOrder = false;
                                            progressPercentage = (orderCount / maximumValue);
                                            debugPrint("timerCount: $orderCount");
                                            saveTimerCount(orderCount, multiplyCostValue);
                                            if (orderCount < 99) {
                                              isButtonDisabled = true; // Disable the button
                                            } else if (orderCount >= 99) {
                                              // syncUniqueId = homeController.generateRandomSixDigitNumber();
                                              // debugPrint("syncUniqueId: $syncUniqueId");
                                              isButtonDisabled = true; // Disable the button
                                              // orderCount = 0;
                                            } else if (orderCount == 120) {
                                              isButtonDisabled = false; // Enable the button
                                              // orderCount = 0;
                                            } else if (orderCount > 120) {
                                              progressPercentage = 0.0;
                                              isButtonDisabled = false; // Enable the button
                                              orderCount = 0;
                                            }
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              duration: const Duration(seconds: 3),
                                              backgroundColor: kPurpleColor,
                                              behavior: SnackBarBehavior.floating, // Add this line
                                              margin: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
                                              content: RichText(
                                                text: const TextSpan(
                                                  style: TextStyle(
                                                    fontFamily:
                                                        'MontserratBold',
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_DEFAULT,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          'Order Placed Successfully ',
                                                    ),
                                                    TextSpan(
                                                      text: '✔️',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.green,
                                                          fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                          resetValue();
                                          productEan = homeController
                                              .generateRandomNineDigitNumber()
                                              .toString();
                                        });
                                      }
                                    : () {},
                                child: Container(
                                  height: Dimensions.BUTTON_HEIGHT,
                                  width: size.width,
                                  decoration: enablePlaceOrder == true
                                      ? BoxDecoration(
                                          color: kPrimaryColor,
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.deepOrange,
                                              Colors.pink
                                            ],
                                          ),
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.pink.shade900,
                                              width: 4.0,
                                            ),
                                            right: BorderSide(
                                              color: Colors.pink.shade900,
                                              width: 1.0,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                        )
                                      : BoxDecoration(
                                          color: Colors.grey,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey.shade900,
                                              width: 4.0,
                                            ),
                                            right: BorderSide(
                                              color: Colors.grey.shade900,
                                              width: 1.0,
                                            ),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                        ),
                                  alignment: Alignment.center,
                                  child: isPlaceOrder == true
                                      ? const CupertinoActivityIndicator(
                                          color: Colors.white,
                                        )
                                      : const Text(
                                          "Place Order",
                                          style: TextStyle(
                                              fontFamily: 'MontserratBold',
                                              color: Colors.white,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_DEFAULT),
                                        ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Hire Candidates",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                    ),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Icon(
                      Icons.groups,
                      size: 30,
                      color: kWhiteColor,
                    ),
                  ],
                ),
                const Text(
                  "\'Per Hiring Get ₹ 600 Incentives\n( ₹ 500 + 500 Orders ₹ 100 = ₹ 600)\'",
                  // "\"Get Rs 650 Incentives & \n150 Orders Bonus\"",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: kSecondaryColor,
                      fontSize: Dimensions.FONT_SIZE_LARGE),
                ),
                const Text(
                  "Vacancies Available",
                  style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                ),
                const Text(
                  "28994",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: kSecondaryColor,
                      fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: (){
          String text = 'Hello I need help in app';
          String encodedText = Uri.encodeFull(text);
          String uri =
              'https://tawk.to/chat/655e4f8ed600b968d3160d07/default';
          launchUrl(
            Uri.parse(uri),
            mode: LaunchMode.inAppWebView,
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(1000),
            border: Border(
              bottom: BorderSide(
                color: Colors.green.shade900,
                width: 4.0,
              ),
              right: BorderSide(
                color: Colors.green.shade900,
                width: 2.0,
              ),
            ),
          ),
          child: const Icon(Icons.support_agent,color: kWhiteColor,size: 30,),
        ),
      ),
    );
  }

  Future<void> watchAds() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.ADS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    if (jsonData['success']) {
      // Utils().showToast(jsonData['message']);
      final dataList = jsonData['data'] as List;
      final datass = dataList.first;
      prefs.setString(Constant.ADS_LINK, datass[Constant.ADS_LINK]);
      prefs.setString(Constant.ADS_IMAGE, datass[Constant.ADS_IMAGE]);
      setState(() {
        ads_image = prefs.getString(Constant.ADS_IMAGE)!;
        ads_link = prefs.getString(Constant.ADS_LINK)!;
      });
      starttime = 0;
      timerStarted = true;
      // startTimer();
      //userDeatils();
    } else {
      Utils().showToast(jsonData['message']);
    }
  }

  showAlertDialog(
    BuildContext context,
    // String generatedOtp,
  ) {
    Size size = MediaQuery.of(context).size;

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      contentPadding: const EdgeInsets.all(20),
      content: Container(
        height: size.height * 0.1,
        decoration: const BoxDecoration(),
        alignment: Alignment.center,
        child: SlideAction(
          trackBuilder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  state.isPerformingAction ? "Loading..." : "Go To ADS",
                  style: const TextStyle(
                      color: colors.black,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          thumbBuilder: (context, state) {
            return Container(
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: state.isPerformingAction
                    ? const CupertinoActivityIndicator(
                        color: Colors.white,
                      )
                    : const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                      ),
              ),
            );
          },
          action: () async {
            await Future.delayed(
              const Duration(seconds: 2),
              () {
                debugPrint("action completed");
                watchAds();
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

// showAlertDialog(
//   BuildContext context,
//   String generatedOtp,
// ) {
//   Size size = MediaQuery.of(context).size;
//
//   AlertDialog alert = AlertDialog(
//     shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(10))),
//     contentPadding: const EdgeInsets.all(20),
//     content: Container(
//       height: size.height * 0.2,
//       decoration: const BoxDecoration(),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: size.width * 0.5,
//                 child: Text(
//                   generatedOtp,
//                   style: const TextStyle(
//                     fontFamily: 'MontserratBold',
//                     fontSize: 14,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               InkWell(
//                 onTap: () => Navigator.of(context).pop(),
//                 child: Transform.rotate(
//                   angle: 45 * (3.1415926535 / 180),
//                   child: const Icon(
//                     Icons.add,
//                     // Adjust other properties as needed
//                     size: 24.0,
//                     color: Colors.black,
//                   ),
//                 ),
//               )
//             ],
//           ),
//           OtpInputField(
//             generatedOtp: generatedOtp,
//             onPress: (enteredOtp) {
//               if (enteredOtp == generatedOtp) {
//                 print('OTP Matched');
//                 watchAds();
//                 Navigator.of(context).pop();
//               } else {
//                 print('OTP Mismatch');
//               }
//               print('Entered OTP: $enteredOtp');
//             },
//           ),
//         ],
//       ),
//     ),
//   );
//
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }
}

class OtpInputField extends StatefulWidget {
  final String generatedOtp;
  final Function onPress;
  const OtpInputField(
      {super.key, required this.generatedOtp, required this.onPress});

  @override
  _OtpInputFieldState createState() => _OtpInputFieldState();
}

class _OtpInputFieldState extends State<OtpInputField> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();

  @override
  void dispose() {
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildOtpTextField(otpController1),
            buildOtpTextField(otpController2),
            buildOtpTextField(otpController3),
            buildOtpTextField(otpController4),
          ],
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            String enteredOtp =
                "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
            widget.onPress(enteredOtp);
            //
            // if (enteredOtp == widget.generatedOtp) {
            //   print('OTP Matched');
            // } else {
            //   print('OTP Mismatch');
            // }
            // print('Entered OTP: ${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}');
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  Widget buildOtpTextField(TextEditingController controller) {
    return Container(
      width: 50.0,
      height: 50.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: TextField(
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24.0),
        decoration: const InputDecoration(
          counterText: '',
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) {
          FocusScope.of(context).nextFocus();
        },
      ),
    );
  }
}
