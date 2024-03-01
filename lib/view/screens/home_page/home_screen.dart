import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
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
import 'package:nextgen/view/screens/home_page/sync.dart';
import 'package:nextgen/view/screens/login/mainScreen.dart';
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
  String orderCost = "0";
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
  int totalQtySold = 0;
  int rewardAds = 0;
  double progressPercentage = 0.0;
  double progressPercentageTwo = 0.0;
  late bool isClaimButtonDisabled;
  late String generatedOtp;
  late String syncType;
  int syncUniqueId = 1;
  double multiplyCostValue = 0;
  double maximumValue = 100.0;
  double currentValue = 60.0;
  double progressPercentage1 = 0.00;
  late String isWeb;
  String orderAvailable = '1';
  String productEan = '';
  String qtySold = '';
  bool enablePlaceOrder = false;
  bool enablePlaceOrderAVA = false;
  bool isPlaceOrder = false;
  bool isConfirm = false;
  String workDays = "";
  String averageOrders = "";
  String balanceNextgen = "";
  String ordersEarnings = "";
  String todayOrder = "";
  String totalOrders = "";
  int minQty = 1;
  int maxQty = 1;
  int executionCount = 0;
  Timer? timer;
  bool showActivityIndicator = true;

  @override
  void initState() {
    super.initState();
    // loadOrderCount();
    // homeController.handleAsyncInit();
    authCon.handleAsyncInit();
    // qtySold = homeController.generateQtySoldNumber(int.parse(authCon.minQty.value),int.parse(authCon.maxQty.value)).toString();
    resetValue();
    handleAsyncInit();

    isClaimButtonDisabled = true;

    loadOrderCount();

    // debugPrint("orderCount: $orderCount");
    //
    // if (orderCount <= 99) {
    //   isClaimButtonDisabled = true; // Disable the button
    // } else if (orderCount > 99) {
    //   isClaimButtonDisabled = false; // Disable the button
    // } else if (orderCount > 100) {
    //   isClaimButtonDisabled = false; // Enable the button
    // }

    // isClaimButtonDisabled = true;

    // progressPercentageTwo = double.parse(reward_ads);
    // debugPrint("progressPercentageTwo : $progressPercentageTwo");
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        showActivityIndicator = false;
      });
    });
  }

  void handleAsyncInit() async {
    productEan = homeController.generateRandomNineDigitNumber().toString();
    homeController.productEanCorrent(productEan);
    // homeController.handleAsyncInit();
    setState(() async {
      var todayOrder = await storeLocal.read(key: Constant.TODAY_ORDERS_CON);
      homeController.today_order_con.value = int.parse(todayOrder!);
      // isWeb = (await storeLocal.read(key: Constant.IS_WEB))!;
      // totalOrders = (await storeLocal.read(key: Constant.TOTAL_ORDER))!;
      // orderCost = (await storeLocal.read(key: Constant.ORDER_COST))!;
      // debugPrint("totalOrders: $totalOrders");
    });

    const int maxExecutions = 2;
    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      setState(() async {
        qtySold = homeController
            .generateQtySoldNumber(int.parse(authCon.minQty.value),
                int.parse(authCon.maxQty.value))
            .toString();
        debugPrint("qtySold: $qtySold");
        var syncDataNextgenSuccess =
            await storeLocal.read(key: 'syncDataNextgenSuccess');
        debugPrint("syncDataNextgenSuccess: $syncDataNextgenSuccess");
        if (syncDataNextgenSuccess == 'true') {
          orderCount = 0;
          debugPrint("orderCount: $orderCount");
          totalQtySold = 0;
          debugPrint("totalQtySold: $totalQtySold");
          progressPercentage = 0.0;
          debugPrint("progressPercentage: $progressPercentage");
          saveOrderCount(orderCount, totalQtySold, progressPercentage);
        }
        if (orderCount <= 99) {
          isClaimButtonDisabled = true; // Disable the button
        } else if (orderCount > 99) {
          isClaimButtonDisabled = false; // Disable the button
        } else if (orderCount > 100) {
          isClaimButtonDisabled = false; // Enable the button
        }
        await storeLocal.write(key: 'syncDataNextgenSuccess', value: 'false');
      });
      executionCount++;
      if (executionCount >= maxExecutions) {
        timer.cancel();
      }
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

    // loadOrderCount();

    // debugPrint("orderCount: $orderCount");
    //
    // if (orderCount <= 99) {
    //   isClaimButtonDisabled = true; // Disable the button
    // } else if (orderCount > 99) {
    //   isClaimButtonDisabled = false; // Disable the button
    // } else if (orderCount > 100) {
    //   isClaimButtonDisabled = false; // Enable the button
    // }

    // balance;
    // total_ads;
    // today_ads;
    // multiplyCostValue = multiplyCost(orderCount, ads_cost)!;
    // if (orderCount < 100) {
    //   isClaimButtonDisabled = true; // Disable the button
    // } else if (orderCount >= 100) {
    //   isClaimButtonDisabled = false; // Enable the button
    // } else if (orderCount > 100) {
    //   progressPercentage = 0.0;
    //   isClaimButtonDisabled = false; // Enable the button
    //   orderCount = 0;
    // }
    // rewardAds = int.parse(reward_ads);
    // debugPrint("rewardAds : $rewardAds");
    // progressPercentageTwo = double.parse(reward_ads) / maximumValue;
    // debugPrint("progressPercentageTwo : $progressPercentageTwo");
    //
    // if (rewardAds < 100) {
    //   isClaimButtonDisabled = true; // Disable the button
    // } else if (rewardAds >= 100) {
    //   syncUniqueId = homeController.generateRandomSixDigitNumber();
    //   isClaimButtonDisabled = false; // Enable the button
    // }
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

// Load orderCount from shared preferences
  void loadOrderCount() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      // orderCount = prefs.getInt('orderCount')!;
      String? orderCountLoad = await storeLocal.read(key: 'orderCountHome');
      String? totalQtySoldNum = await storeLocal.read(key: 'totalQtySoldNum');
      String? progressPercentageNum =
          await storeLocal.read(key: 'progressPercentageSave');
      orderCount = int.parse(orderCountLoad!);
      totalQtySold = int.parse(totalQtySoldNum!);
      progressPercentage = double.parse(progressPercentageNum!);
      debugPrint("loadOrderCount orderCount: $orderCount");
      debugPrint("loadOrderCount totalQtySold: $totalQtySold");
      // multiplyCostValue = prefs.getDouble('multiplyCostValue')!;
      // debugPrint("loadOrderCount multiplyCostValue: $multiplyCostValue");
      // progressPercentage = (orderCount / maximumValue);
      debugPrint("loadOrderCount progressPercentage: $progressPercentage");
      if (orderCount <= 99) {
        isClaimButtonDisabled = true; // Disable the button
      } else if (orderCount > 99) {
        isClaimButtonDisabled = false; // Disable the button
      } else if (orderCount > 100) {
        isClaimButtonDisabled = false; // Enable the button
      }
    });
  }

// Save orderCount to shared preferences
  void saveOrderCount(
      int count, int totalQtySoldNum, double progressPercentageNum) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    String orderCountSave = count.toString();
    String totalQtySoldNumSave = totalQtySoldNum.toString();
    String progressPercentageSave = progressPercentageNum.toString();
    await storeLocal.write(key: 'orderCountHome', value: orderCountSave);
    await storeLocal.write(key: 'totalQtySoldNum', value: totalQtySoldNumSave);
    await storeLocal.write(
        key: 'progressPercentageSave', value: progressPercentageSave);
    debugPrint("count: $count");
    debugPrint("totalQtySoldNum: $totalQtySoldNum");
    debugPrint("progressPercentageSave: $progressPercentageSave");
    // await prefs.setInt('orderCount', count);
    // await prefs.setDouble('multiplyCostValue', multiplyCostValue);
  }

  // String separateNumber(String number) {
  //   if (number.length != 12) {
  //     throw Exception("Number must be 12 digits long.");
  //   }
  //
  //   List<String> groups = [];
  //
  //   for (int i = 0; i < 12; i += 4) {
  //     groups.add(number.substring(i, i + 4));
  //   }
  //
  //   return groups.join('-');
  // }

  // bool isMultipleOf5(int number) {
  //   return number % 5 == 0;
  // }

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
      qtySold = homeController
          .generateQtySoldNumber(
              int.parse(authCon.minQty.value), int.parse(authCon.maxQty.value))
          .toString();
      showActivityIndicator = true;
      Future.delayed(const Duration(seconds: 4), () {
        setState(() {
          showActivityIndicator = false;
        });
      });
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
                        (progressPercentage * maximumValue).toInt().toString(),
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            fontSize: 16.0,
                            color: kTextColor),
                      ),
                      footer: IgnorePointer(
                        ignoring: isClaimButtonDisabled,
                        child: InkWell(
                          onTap: () async {
                            // syncType = 'reward_sync';
                            // debugPrint("syncType: $syncType");
                            try {
                              prefs = await SharedPreferences.getInstance();
                              String? userID =
                                  await storeLocal.read(key: Constant.ID);
                              String? deviceID = await storeLocal.read(
                                  key: Constant.DEVICE_ID);
                              debugPrint(
                                  "userID: $userID\ndeviceID: $deviceID");
                              Get.to(Sync(
                                userId: userID!,
                                orders: orderCount.toString(),
                                totalQtySold: totalQtySold.toString(),
                                deviceID: deviceID!,
                              ));
                              // homeController.showLoadingIndicator(context);
                              // await Future.delayed(const Duration(seconds: 5));
                              // homeController.hideLoadingIndicator(context);
                              // homeController.syncData(
                              //   userID,
                              //   orderCount.toString(),
                              //   totalQtySold.toString(),
                              //   (String syncDataNextgenSuccess) {
                              //     debugPrint(
                              //         "syncDataNextgenSuccess: $syncDataNextgenSuccess");
                              //     // Perform actions based on the result of the syncData function
                              //     if (syncDataNextgenSuccess == 'true') {
                              //       isClaimButtonDisabled = true;
                              //       debugPrint(
                              //           "isClaimButtonDisabled: $isClaimButtonDisabled");
                              //       orderCount = 0;
                              //       debugPrint("orderCount: $orderCount");
                              //       totalQtySold = 0;
                              //       debugPrint("totalQtySold: $totalQtySold");
                              //       progressPercentage = 0.0;
                              //       debugPrint(
                              //           "progressPercentage: $progressPercentage");
                              //       setState(() {
                              //         isClaimButtonDisabled = true;
                              //         debugPrint(
                              //             "isClaimButtonDisabled: $isClaimButtonDisabled");
                              //         orderCount = 0;
                              //         debugPrint("orderCount: $orderCount");
                              //         totalQtySold = 0;
                              //         debugPrint("totalQtySold: $totalQtySold");
                              //         progressPercentage = 0.0;
                              //         debugPrint(
                              //             "progressPercentage: $progressPercentage");
                              //         orderAvailable = homeController
                              //             .orderAvailable
                              //             .toString();
                              //         debugPrint(
                              //             "orderAvailable: $orderAvailable");
                              //         workDays =
                              //             homeController.workDays.toString();
                              //         debugPrint("workDays: $workDays");
                              //         todayOrder =
                              //             homeController.todayOrder.toString();
                              //         debugPrint("todayOrder: $todayOrder");
                              //         totalOrders =
                              //             homeController.todayOrder.toString();
                              //         debugPrint("totalOrders: $totalOrders");
                              //         averageOrders = homeController
                              //             .averageOrders
                              //             .toString();
                              //         debugPrint(
                              //             "averageOrders: $averageOrders");
                              //         ordersEarnings = homeController
                              //             .orderEarnings
                              //             .toString();
                              //         // orderAvailable = (await storeLocal.read(
                              //         //     key: Constant.ORDERAVAILABLE)!)!;
                              //         // debugPrint("orderAvailable: $orderAvailable");
                              //         // workDays = (await storeLocal.read(
                              //         //     key: Constant.WORK_DAYS)!)!;
                              //         // debugPrint("workDays: $workDays");
                              //         // todayOrder = (await storeLocal.read(
                              //         //     key: Constant.TODAY_ORDER)!)!;
                              //         // debugPrint("todayOrder: $todayOrder");
                              //         // totalOrders = (await storeLocal.read(
                              //         //     key: Constant.TOTAL_ORDER)!)!;
                              //         // debugPrint("totalOrders: $totalOrders");
                              //         // averageOrders = (await storeLocal.read(
                              //         //     key: Constant.AVERAGE_ORDER)!)!;
                              //         // debugPrint("averageOrders: $averageOrders");
                              //         // ordersEarnings = (await storeLocal.read(
                              //         //     key: Constant.ORDERS_EARNINGS)!)!;
                              //         debugPrint(
                              //             "ordersEarnings: $ordersEarnings");
                              //         saveOrderCount(orderCount, totalQtySold,
                              //             progressPercentage);
                              //       });
                              //     } else {}
                              //   },
                              // );
                              // Navigator.of(context).pushReplacement(
                              //   MaterialPageRoute(builder: (context) => const MainScreen()),
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
                          child: Column(
                            children: [
                              const Text(
                                "Orders Earnings",
                                style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: Colors.white,
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                              ),
                              ordersEarnings != ""
                                  ? Text(
                                      ordersEarnings,
                                      style: const TextStyle(
                                          fontFamily: 'MontserratBold',
                                          color: kTextColor,
                                          fontSize: Dimensions.FONT_SIZE_SMALL),
                                    )
                                  : Obx(
                                      () => Text(
                                        authCon.order_earnings.toString(),
                                        style: const TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: Colors.white,
                                            fontSize: Dimensions
                                                .FONT_SIZE_EXTRA_LARGE),
                                      ),
                                    ),
                            ],
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
                                  "Today Orders ",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "Total Orders ",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "Work Days ",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                                SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Text(
                                  "My Daily Average ",
                                  style: TextStyle(
                                      fontFamily: 'MontserratBold',
                                      color: kTextColor,
                                      fontSize: Dimensions.FONT_SIZE_SMALL),
                                ),
                              ],
                            ),
                            const SizedBox(
                                width: Dimensions.PADDING_SIZE_SMALL),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                todayOrder != ""
                                    ? Text(
                                        "$todayOrder + $orderCount",
                                        style: const TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: kTextColor,
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL),
                                      )
                                    : Obx(
                                        () => Text(
                                          "${authCon.today_order} + $orderCount",
                                          style: const TextStyle(
                                              fontFamily: 'MontserratBold',
                                              color: kTextColor,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                        ),
                                      ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                totalOrders != ""
                                    ? Text(
                                        "$totalOrders + $orderCount",
                                        style: const TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: kTextColor,
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL),
                                      )
                                    : Obx(
                                        () => Text(
                                          "${authCon.total_order} + $orderCount",
                                          style: const TextStyle(
                                              fontFamily: 'MontserratBold',
                                              color: kTextColor,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                        ),
                                      ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                workDays != ""
                                    ? Text(
                                        workDays,
                                        style: const TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: kTextColor,
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL),
                                      )
                                    : Obx(
                                        () => Text(
                                          authCon.work_days.toString(),
                                          style: const TextStyle(
                                              fontFamily: 'MontserratBold',
                                              color: kTextColor,
                                              fontSize:
                                                  Dimensions.FONT_SIZE_SMALL),
                                        ),
                                      ),
                                const SizedBox(
                                    height:
                                        Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                Obx(() => authCon.student_plan.value == '1'
                                    ? const Text(
                                        '300',
                                        style: TextStyle(
                                            fontFamily: 'MontserratBold',
                                            color: kTextColor,
                                            fontSize:
                                                Dimensions.FONT_SIZE_SMALL),
                                      )
                                    : averageOrders != ""
                                        ? Text(
                                            averageOrders,
                                            style: const TextStyle(
                                                fontFamily: 'MontserratBold',
                                                color: kTextColor,
                                                fontSize:
                                                    Dimensions.FONT_SIZE_SMALL),
                                          )
                                        : Obx(
                                            () => Text(
                                              authCon.average_orders.toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'MontserratBold',
                                                  color: kTextColor,
                                                  fontSize: Dimensions
                                                      .FONT_SIZE_SMALL),
                                            ),
                                          )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(
                          children: [
                            Obx(
                              () => Text(
                                authCon.student_plan.value == '1'
                                    ? "Student Plan."
                                    : "Department Store.",
                                style: const TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: kPurpleColor,
                                    fontSize: Dimensions.FONT_SIZE_SMALL),
                              ),
                            ),
                            Obx(
                              () => authCon.student_plan.value == '1'
                                  ? const SizedBox()
                                  : const SizedBox(
                                  width: Dimensions.PADDING_SIZE_SMALL),
                            ),
                            Obx(
                              () => authCon.student_plan.value == '1'
                                  ? const SizedBox()
                                  : InkWell(
                                onTap: () {
                                  // showAlertDialog(context);
                                  showAlertDialog(
                                      context,
                                      authCon.today_order.toString(),
                                      authCon.total_order.toString(),
                                      authCon.work_days.toString());
                                },
                                child: Container(
                                  height: Dimensions.BUTTON_HEIGHT,
                                  width: size.width * 0.2,
                                  decoration: BoxDecoration(
                                    color: kPurpleColor,
                                    borderRadius:
                                    BorderRadius.circular(1000),
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
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Increase\nAverage',
                                    style: TextStyle(
                                        fontFamily: 'MontserratMedium',
                                        color: Colors.white,
                                        fontSize:
                                        Dimensions.FONT_SIZE_SMALL),
                                  ),
                                ),
                              ),
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
                            debugPrint(
                                "student_plan: ${authCon.student_plan.value}");
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
                          child: showActivityIndicator
                              ? const CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  '$qtySold',
                                  style: const TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: Colors.white,
                                    fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                  ),
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
                                      homeController.pasteText(
                                          context, productEan);
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
                                      debugPrint(
                                          "isAvailable: ${homeController.isAvailableRandom.value}");
                                      homeController
                                          .productEanCorrent(productEan);
                                      if (homeController.isCheck.value !=
                                          true) {
                                        homeController.checkAvailability(
                                          context,
                                          homeController.copiedText.toString(),
                                          authCon.productStatus.toString(),
                                        );
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
                            ? homeController.isAvailableRandom.value == true
                                ? const SizedBox(
                                    height: Dimensions.PADDING_SIZE_SMALL)
                                : Container()
                            : Container(),
                      ),
                      Obx(
                        () => homeController.orderAvailable == "1"
                            ? homeController.isAvailableRandom.value == true
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                "Add to Cart",
                                                style: TextStyle(
                                                    fontFamily:
                                                        'MontserratBold',
                                                    color: kTextColor,
                                                    fontSize: Dimensions
                                                        .FONT_SIZE_LARGE),
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
                                                    () => homeController
                                                            .isLoading.value
                                                        ? SizedBox(
                                                            height: 40,
                                                            width: homeController
                                                                        .quantity >=
                                                                    100
                                                                ? 55
                                                                : 40,
                                                            child:
                                                                const CupertinoActivityIndicator(
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 40,
                                                            width: homeController
                                                                        .quantity >=
                                                                    100
                                                                ? 55
                                                                : 40,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              homeController
                                                                  .quantity
                                                                  .toString(),
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'MontserratBold',
                                                                color:
                                                                    kWhiteColor,
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
                                              width: Dimensions
                                                  .PADDING_SIZE_EXTRA_SMALL),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isConfirm = true;
                                              });
                                              Timer(const Duration(seconds: 3),
                                                  () async {
                                                if (enablePlaceOrderAVA ==
                                                    true) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                      content: Text(
                                                        "Place Order Now Try Again...",
                                                      ),
                                                      duration:
                                                          Duration(seconds: 2),
                                                      backgroundColor:
                                                          kPurpleColor,
                                                      behavior: SnackBarBehavior
                                                          .floating, // Add this line
                                                      margin: EdgeInsets.only(
                                                          bottom: 10,
                                                          left: 15,
                                                          right: 15),
                                                    ),
                                                  );
                                                  setState(() {
                                                    isConfirm = false;
                                                  });
                                                } else {
                                                  if (int.parse(qtySold) ==
                                                      int.parse(homeController
                                                          .quantity
                                                          .toString())) {
                                                    debugPrint(
                                                        'qtySold == homeController.quantity');
                                                    debugPrint(
                                                        'qtySold:$qtySold');
                                                    debugPrint(
                                                        'homeController.quantity:${homeController.quantity}');
                                                    setState(() {
                                                      homeController
                                                          .enablePlaceOrder
                                                          .value = true;
                                                      enablePlaceOrderAVA =
                                                          true;
                                                      debugPrint(
                                                          'homeController.enablePlaceOrder.value:$homeController.enablePlaceOrder.value');
                                                    });
                                                  } else {
                                                    debugPrint(
                                                        'qtySold != homeController.quantity');
                                                    debugPrint(
                                                        'qtySold:$qtySold');
                                                    debugPrint(
                                                        'homeController.quantity:${homeController.quantity.value}');
                                                    setState(() {
                                                      homeController
                                                          .enablePlaceOrder
                                                          .value = false;
                                                    });
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                          "Please correct your Quantity.",
                                                        ),
                                                        duration: Duration(
                                                            seconds: 2),
                                                        backgroundColor:
                                                            kPurpleColor,
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
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: Dimensions.BUTTON_HEIGHT,
                                              width:
                                                  homeController.quantity >= 100
                                                      ? size.width * 0.33
                                                      : size.width * 0.36,
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
                                                        fontFamily:
                                                            'MontserratBold',
                                                        color: Colors.white,
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_DEFAULT,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                          height:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      InkWell(
                                        onTap: homeController
                                                    .enablePlaceOrder.value ==
                                                true
                                            ? (int.parse(authCon.today_order
                                                        .toString()) <
                                                    int.parse(authCon
                                                        .average_orders
                                                        .toString()))
                                                // ? (int.parse(homeController
                                                // .todayOrder.value !=
                                                // ""
                                                // ? homeController.todayOrder
                                                // .toString()
                                                // : authCon.today_order
                                                // .toString()) >=
                                                // int.parse(homeController
                                                //     .averageOrders.value !=
                                                //     ""
                                                //     ? homeController.averageOrders
                                                //     .toString()
                                                //     : authCon.average_orders
                                                //     .toString()))
                                                ? () {
                                                    setState(() {
                                                      homeController
                                                          .enablePlaceOrder
                                                          .value = false;
                                                      isPlaceOrder = true;
                                                    });
                                                    homeController
                                                        .showLoadingIndicator(
                                                            context);
                                                    Timer(
                                                        const Duration(
                                                            seconds: 4),
                                                        orderCount >= 100
                                                            ? () {
                                                                setState(() {
                                                                  isPlaceOrder =
                                                                      false;
                                                                });
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  const SnackBar(
                                                                    duration: Duration(
                                                                        seconds:
                                                                            3),
                                                                    backgroundColor:
                                                                        kPurpleColor,
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating, // Add this line
                                                                    margin: EdgeInsets.only(
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                    content:
                                                                        Text(
                                                                      'Sync Now Try Again...',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'MontserratBold',
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            Dimensions.FONT_SIZE_DEFAULT,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                                resetValue();
                                                                productEan =
                                                                    homeController
                                                                        .generateRandomNineDigitNumber()
                                                                        .toString();
                                                                homeController
                                                                    .hideLoadingIndicator(
                                                                        context);
                                                              }
                                                            : () {
                                                                homeController
                                                                    .todayOrders();
                                                                // multiplyCostValue =
                                                                //     orderCount *
                                                                //         double.parse(authCon
                                                                //             .orders_cost
                                                                //             .toString());
                                                                setState(() {
                                                                  isPlaceOrder =
                                                                      false;
                                                                  enablePlaceOrderAVA =
                                                                      false;
                                                                  orderCount++;
                                                                  // progressPercentage = (orderCount / maximumValue);
                                                                  print(
                                                                      'orderCount called $orderCount times.');
                                                                  debugPrint(
                                                                      "timerCount: $orderCount");
                                                                  totalQtySold = int.parse(homeController
                                                                          .quantity
                                                                          .toString()) +
                                                                      totalQtySold;
                                                                  debugPrint(
                                                                      "totalQtySold: $totalQtySold");
                                                                  if (orderCount <=
                                                                      99) {
                                                                    // orderCount=99;
                                                                    progressPercentage =
                                                                        (orderCount /
                                                                            maximumValue);
                                                                    print(
                                                                        'progressPercentage $progressPercentage times.');
                                                                    isClaimButtonDisabled =
                                                                        true; // Disable the button
                                                                  } else if (orderCount >
                                                                      99) {
                                                                    // syncUniqueId = homeController.generateRandomSixDigitNumber();
                                                                    // debugPrint("syncUniqueId: $syncUniqueId");
                                                                    // orderCount = 0;
                                                                    progressPercentage =
                                                                        (orderCount /
                                                                            maximumValue);
                                                                    isClaimButtonDisabled =
                                                                        false; // Disable the button
                                                                    // orderCount = 0;
                                                                  } else if (orderCount >
                                                                      100) {
                                                                    progressPercentage =
                                                                        0.0;
                                                                    isClaimButtonDisabled =
                                                                        false; // Enable the button
                                                                    orderCount =
                                                                        0;
                                                                  }
                                                                  saveOrderCount(
                                                                      orderCount,
                                                                      totalQtySold,
                                                                      progressPercentage);
                                                                });
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                  SnackBar(
                                                                    duration: const Duration(
                                                                        seconds:
                                                                            3),
                                                                    backgroundColor:
                                                                        kPurpleColor,
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .floating, // Add this line
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            10,
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                    content:
                                                                        RichText(
                                                                      text:
                                                                          const TextSpan(
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'MontserratBold',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              Dimensions.FONT_SIZE_DEFAULT,
                                                                        ),
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                'Order Placed Successfully ',
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                '✔️',
                                                                            style:
                                                                                TextStyle(
                                                                              fontWeight: FontWeight.bold,
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
                                                                productEan =
                                                                    homeController
                                                                        .generateRandomNineDigitNumber()
                                                                        .toString();
                                                                homeController
                                                                    .hideLoadingIndicator(
                                                                        context);
                                                              });
                                                  }
                                                : () {
                                                    setState(() {
                                                      homeController
                                                          .enablePlaceOrder
                                                          .value = false;
                                                      isPlaceOrder = true;
                                                    });
                                                    homeController
                                                        .showLoadingIndicator(
                                                            context);
                                                    // setState(() {
                                                    //   isPlaceOrder = true;
                                                    // });
                                                    Timer(
                                                        const Duration(
                                                            seconds: 4), () {
                                                      setState(() {
                                                        isPlaceOrder = false;
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          duration: Duration(
                                                              seconds: 3),
                                                          backgroundColor:
                                                              kPurpleColor,
                                                          behavior: SnackBarBehavior
                                                              .floating, // Add this line
                                                          margin:
                                                              EdgeInsets.only(
                                                                  bottom: 10,
                                                                  left: 15,
                                                                  right: 15),
                                                          content: Text(
                                                            'You have completed today orders',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'MontserratBold',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: Dimensions
                                                                  .FONT_SIZE_DEFAULT,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                      resetValue();
                                                      productEan = homeController
                                                          .generateRandomNineDigitNumber()
                                                          .toString();
                                                      homeController
                                                          .hideLoadingIndicator(
                                                              context);
                                                    });
                                                  }
                                            : () {},
                                        child: Container(
                                          height: Dimensions.BUTTON_HEIGHT,
                                          width: size.width,
                                          // decoration: homeController.enablePlaceOrder.value == true
                                          decoration: homeController
                                                      .enablePlaceOrder.value ==
                                                  true
                                              ?
                                              // ? (int.parse(authCon.today_order
                                              //             .toString()) >=
                                              //         int.parse(authCon
                                              //             .average_orders
                                              //             .toString()))
                                              //     // ? (int.parse(homeController
                                              //     // .todayOrder.value !=
                                              //     // ""
                                              //     // ? homeController.todayOrder
                                              //     // .toString()
                                              //     // : authCon.today_order
                                              //     // .toString()) >=
                                              //     // int.parse(homeController
                                              //     //     .averageOrders
                                              //     //     .value !=
                                              //     //     ""
                                              //     //     ? homeController.averageOrders
                                              //     //     .toString()
                                              //     //     : authCon.average_orders
                                              //     //     .toString()))
                                              //     ? BoxDecoration(
                                              //         color: Colors.grey,
                                              //         border: Border(
                                              //           bottom: BorderSide(
                                              //             color:
                                              //                 Colors.grey.shade900,
                                              //             width: 4.0,
                                              //           ),
                                              //           right: BorderSide(
                                              //             color:
                                              //                 Colors.grey.shade900,
                                              //             width: 1.0,
                                              //           ),
                                              //         ),
                                              //         borderRadius:
                                              //             BorderRadius.circular(
                                              //                 1000),
                                              //       )
                                              //     : BoxDecoration(
                                              BoxDecoration(
                                                  color: kPrimaryColor,
                                                  gradient:
                                                      const LinearGradient(
                                                    colors: [
                                                      Colors.deepOrange,
                                                      Colors.pink
                                                    ],
                                                  ),
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          Colors.pink.shade900,
                                                      width: 4.0,
                                                    ),
                                                    right: BorderSide(
                                                      color:
                                                          Colors.pink.shade900,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                )
                                              : BoxDecoration(
                                                  color: Colors.grey,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color:
                                                          Colors.grey.shade900,
                                                      width: 4.0,
                                                    ),
                                                    right: BorderSide(
                                                      color:
                                                          Colors.grey.shade900,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1000),
                                                ),
                                          alignment: Alignment.center,
                                          // child: (int.parse(authCon.today_order
                                          //             .toString()) >=
                                          //         int.parse(authCon.average_orders
                                          //             .toString()))
                                          //     // child: (int.parse(
                                          //     //     homeController.todayOrder.value !=
                                          //     //         ""
                                          //     //         ? homeController.todayOrder
                                          //     //         .toString()
                                          //     //         : authCon.today_order
                                          //     //         .toString()) >=
                                          //     //     int.parse(homeController
                                          //     //         .averageOrders.value !=
                                          //     //         ""
                                          //     //         ? homeController.averageOrders
                                          //     //         .toString()
                                          //     //         : authCon.average_orders
                                          //     //         .toString()))
                                          //     ? const Text(
                                          //         "Place Order",
                                          //         style: TextStyle(
                                          //             fontFamily: 'MontserratBold',
                                          //             color: Colors.white,
                                          //             fontSize: Dimensions
                                          //                 .FONT_SIZE_DEFAULT),
                                          //       )
                                          //     : isPlaceOrder == true
                                          child: isPlaceOrder == true
                                              ? const CupertinoActivityIndicator(
                                                  color: Colors.white,
                                                )
                                              : const Text(
                                                  "Place Order",
                                                  style: TextStyle(
                                                      fontFamily:
                                                          'MontserratBold',
                                                      color: Colors.white,
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_DEFAULT),
                                                ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container()
                            : Container(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Hire Candidates",
                //       style: TextStyle(
                //           fontFamily: 'MontserratBold',
                //           color: kTextColor,
                //           fontWeight: FontWeight.bold,
                //           fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                //     ),
                //     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                //     Icon(
                //       Icons.groups,
                //       size: 30,
                //       color: kWhiteColor,
                //     ),
                //   ],
                // ),
                // const Text(
                //   "\'Per Hiring Get ₹ 600 Incentives\n( ₹ 500 + 500 Orders ₹ 100 = ₹ 600)\'",
                //   // "\"Get Rs 650 Incentives & \n150 Orders Bonus\"",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       fontFamily: 'MontserratBold',
                //       color: kSecondaryColor,
                //       fontSize: Dimensions.FONT_SIZE_LARGE),
                // ),
                const Text(
                  "Vacancies Available",
                  style: TextStyle(
                      fontFamily: 'MontserratBold',
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                ),
                Obx(
                  () => Text(
                    authCon.vacancies.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'MontserratBold',
                        color: kSecondaryColor,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          String text = 'Hello I need help in app';
          String encodedText = Uri.encodeFull(text);
          String uri =
              'https://tawk.to/chat/656c7dd3bfb79148e599a506/1hgnsn1et';
          launchUrl(
            Uri.parse(uri),
            mode: LaunchMode.inAppWebView,
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1000),
          ),
          child: Image.asset('assets/images/download-removebg-preview.png'),
        ),
      ),
    );
  }

  // Future<void> watchAds() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   var response = await dataCall(Constant.ADS_URL);
  //
  //   String jsonDataString = response.toString();
  //   final jsonData = jsonDecode(jsonDataString);
  //
  //   if (jsonData['success']) {
  //     // Utils().showToast(jsonData['message']);
  //     final dataList = jsonData['data'] as List;
  //     final datass = dataList.first;
  //     prefs.setString(Constant.ADS_LINK, datass[Constant.ADS_LINK]);
  //     prefs.setString(Constant.ADS_IMAGE, datass[Constant.ADS_IMAGE]);
  //     setState(() {
  //       ads_image = prefs.getString(Constant.ADS_IMAGE)!;
  //       ads_link = prefs.getString(Constant.ADS_LINK)!;
  //     });
  //     starttime = 0;
  //     timerStarted = true;
  //     // startTimer();
  //     //userDeatils();
  //   } else {
  //     Utils().showToast(jsonData['message']);
  //   }
  // }

  // syncAlertDialog(
  //   BuildContext context,
  //   // String generatedOtp,
  // ) {
  //   Size size = MediaQuery.of(context).size;
  //
  //   AlertDialog alert = const AlertDialog(
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.all(Radius.circular(16))),
  //     contentPadding: EdgeInsets.all(20),
  //     content: CupertinoActivityIndicator(
  //       color: Colors.pink,
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

  void showAlertDialog(
    BuildContext context,
    String todayOrders,
    String totalOrders,
    String totalWorkedDays,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MyAlertDialog(
          todayOrders: todayOrders,
          totalOrders: totalOrders,
          totalWorkedDays: totalWorkedDays,
        );
      },
    );
  }

  // showAlertDialog(
  //   BuildContext context,
  //   String todayOrders,
  //   String totalOrders,
  //   String totalWorkedDays,
  // ) {
  //   final TextEditingController totalOrdersTarget = TextEditingController();
  //   @override
  //   void dispose() {
  //     totalOrdersTarget.dispose();
  //     super.dispose();
  //   }
  //
  //   int total_orders = (int.parse(totalOrders) - int.parse(todayOrders));
  //   // int total_missed_orders = 0;
  //   int total_missed_orders =
  //       (int.tryParse(totalWorkedDays)! * 500) - total_orders;
  //
  //   // double result = 0.0;
  //   // String resultText = '0';
  //   //
  //   double result = ((total_missed_orders < 0 ? 0 : total_missed_orders) / 500);
  //   String resultText = result % 1 == 0
  //       ? result.toInt().toString()
  //       : (result >= 0 ? result.ceil() : result.floor()).toString();
  //
  //   Size size = MediaQuery.of(context).size;
  //   Container alert = Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(16),
  //       color: const Color(0xFFF2F2F2),
  //     ),
  //     margin: EdgeInsets.symmetric(
  //         horizontal: size.width * 0.1, vertical: size.height * 0.1),
  //     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //     alignment: Alignment.center,
  //     child: Column(
  //       children: [
  //         Align(
  //           alignment: Alignment.topRight,
  //           child: IconButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             icon: Container(
  //               decoration: const BoxDecoration(
  //                   shape: BoxShape.circle, color: Colors.white),
  //               padding: const EdgeInsets.all(3),
  //               child: Transform.rotate(
  //                 angle: 45 * 3.1415926535 / 180,
  //                 child: const Icon(Icons.add),
  //               ),
  //             ),
  //           ),
  //         ),
  //         const Text(
  //           'Average Calculator',
  //           style: TextStyle(
  //               fontFamily: 'MontserratBold',
  //               color: colors.primary_color,
  //               fontSize: 18),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         const Text(
  //           'Today\'s Orders Generated, Will Not Be Calculated.',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               fontFamily: 'MontserratMedium',
  //               color: colors.red,
  //               fontSize: 12),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 0),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               const Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Total Orders Generated:',
  //                     style: TextStyle(
  //                         fontFamily: 'MontserratMedium',
  //                         color: colors.black,
  //                         fontSize: 14),
  //                   ),
  //                   Text(
  //                     'Total Worked Days:',
  //                     style: TextStyle(
  //                         fontFamily: 'MontserratMedium',
  //                         color: colors.black,
  //                         fontSize: 14),
  //                   ),
  //                   // SizedBox(height: 10,),
  //                   // Text(
  //                   //   'Total Orders Target:',
  //                   //   style: TextStyle(
  //                   //       fontFamily: 'MontserratMedium',
  //                   //       color: colors.black,
  //                   //       fontSize: 14),
  //                   // ),
  //                   // SizedBox(height: 10,),
  //                   Text(
  //                     'Total Missed Orders:',
  //                     style: TextStyle(
  //                         fontFamily: 'MontserratMedium',
  //                         color: colors.black,
  //                         fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 width: 10,
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     total_orders.toString(),
  //                     style: const TextStyle(
  //                         fontFamily: 'MontserratBold',
  //                         color: colors.primary_color,
  //                         fontSize: 14),
  //                   ),
  //                   Text(
  //                     totalWorkedDays.toString(),
  //                     style: const TextStyle(
  //                         fontFamily: 'MontserratBold',
  //                         color: colors.primary_color,
  //                         fontSize: 14),
  //                   ),
  //                   // Card(
  //                   //   child: SizedBox(
  //                   //     height: 40,
  //                   //     width: 120,
  //                   //     child: TextField(
  //                   //       controller: totalOrdersTarget,
  //                   //       decoration: InputDecoration(
  //                   //         filled: true,
  //                   //         fillColor: const Color(0xFFF2F2F2),
  //                   //         labelText: 'Enter Target',
  //                   //         labelStyle: const TextStyle(
  //                   //             fontFamily: 'MontserratBold',
  //                   //             color: Colors.grey,
  //                   //             fontSize: 12),
  //                   //         border: OutlineInputBorder(
  //                   //           borderSide: const BorderSide(
  //                   //             width: 0.5,
  //                   //             color: colors.primary_color,
  //                   //           ),
  //                   //           borderRadius: BorderRadius.circular(10.0),
  //                   //         ),
  //                   //         enabledBorder: OutlineInputBorder(
  //                   //           borderSide: const BorderSide(
  //                   //             width: 0.5,
  //                   //             color: colors.primary_color,
  //                   //           ),
  //                   //           borderRadius: BorderRadius.circular(10.0),
  //                   //         ),
  //                   //       ),
  //                   //       style: const TextStyle(
  //                   //         fontFamily: 'MontserratBold',
  //                   //         color: colors.primary_color,
  //                   //         fontSize: 14,
  //                   //       ),
  //                   //     ),
  //                   //   ),
  //                   // ),
  //                   Text(
  //                     total_missed_orders < 0
  //                         ? "0"
  //                         : total_missed_orders.toString(),
  //                     style: const TextStyle(
  //                         fontFamily: 'MontserratBold',
  //                         color: colors.primary_color,
  //                         fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(left: 20),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               const Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     'Total Orders Target:',
  //                     style: TextStyle(
  //                         fontFamily: 'MontserratMedium',
  //                         color: colors.black,
  //                         fontSize: 14),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     'Total Missed Orders:',
  //                     style: TextStyle(
  //                         fontFamily: 'MontserratMedium',
  //                         color: colors.black,
  //                         fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 width: 10,
  //               ),
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Card(
  //                     child: SizedBox(
  //                       height: 50,
  //                       width: 120,
  //                       child: TextField(
  //                         controller: totalOrdersTarget,
  //                         keyboardType: TextInputType.number,
  //                         inputFormatters: [
  //                           FilteringTextInputFormatter.digitsOnly
  //                         ],
  //                         decoration: const InputDecoration(
  //                             enabledBorder: InputBorder.none,
  //                             filled: true,
  //                             fillColor: Color(0xFFF2F2F2),
  //                             hintText: 'Enter Target',
  //                             hintStyle: TextStyle(
  //                                 fontFamily: 'MontserratBold',
  //                                 color: Colors.grey,
  //                                 fontSize: 12),
  //                             border: InputBorder.none),
  //                         style: const TextStyle(
  //                           fontFamily: 'MontserratBold',
  //                           color: colors.primary_color,
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   Text(
  //                     total_missed_orders < 0
  //                         ? "0"
  //                         : total_missed_orders.toString(),
  //                     style: const TextStyle(
  //                         fontFamily: 'MontserratBold',
  //                         color: colors.primary_color,
  //                         fontSize: 14),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Card(
  //           child: InkWell(
  //             onTap: () {
  //               setState(() {
  //                 total_missed_orders = ((int.tryParse(totalWorkedDays)! +
  //                         (int.tryParse(totalOrdersTarget.text)!) * 500) -
  //                     total_orders);
  //                 debugPrint("total_missed_orders: $total_missed_orders");
  //                 result =
  //                     ((total_missed_orders < 0 ? 0 : total_missed_orders) /
  //                         500);
  //                 resultText = result % 1 == 0
  //                     ? result.toInt().toString()
  //                     : (result >= 0 ? result.ceil() : result.floor())
  //                         .toString();
  //                 debugPrint("resultText: $resultText");
  //               });
  //             },
  //             child: Container(
  //               height: Dimensions.BUTTON_HEIGHT,
  //               width: size.width * 0.2,
  //               decoration: BoxDecoration(
  //                 color: colors.primary,
  //                 borderRadius: BorderRadius.circular(16),
  //                 border: const Border(
  //                   bottom: BorderSide(
  //                     color: colors.secondary_color,
  //                     width: 4.0,
  //                   ),
  //                   right: BorderSide(
  //                     color: colors.secondary_color,
  //                     width: 2.0,
  //                   ),
  //                 ),
  //               ),
  //               alignment: Alignment.center,
  //               child: const Text(
  //                 'Calculate',
  //                 style: TextStyle(
  //                     fontFamily: 'MontserratMedium',
  //                     color: Colors.white,
  //                     fontSize: Dimensions.FONT_SIZE_SMALL),
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         const Divider(
  //           height: 0.5,
  //           color: Colors.white70,
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         const Text(
  //           'Total Hirings Needed',
  //           style: TextStyle(
  //               fontFamily: 'MontserratMedium',
  //               color: colors.black,
  //               fontSize: 14),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //           decoration: BoxDecoration(
  //               color: kSecondaryColor, borderRadius: BorderRadius.circular(6)),
  //           child: Text(
  //             resultText,
  //             style: const TextStyle(
  //                 fontFamily: 'MontserratBold',
  //                 color: colors.white,
  //                 fontSize: 16),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Container(
  //           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //           decoration: BoxDecoration(
  //               color: kSecondaryColor,
  //               borderRadius: BorderRadius.circular(10)),
  //           child: const Text(
  //             "Note : No Of Hirings shown is subject to today's date. And it will change on a daily basis, Based on total orders missed and worked days.",
  //             style: TextStyle(
  //                 fontFamily: 'MontserratMedium',
  //                 color: colors.white,
  //                 fontSize: 10),
  //           ),
  //         ),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         const Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //               "Hire Candidates",
  //               style: TextStyle(
  //                   fontFamily: 'MontserratBold',
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
  //             ),
  //             SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
  //             Icon(
  //               Icons.groups,
  //               size: 30,
  //               color: Colors.black,
  //             ),
  //           ],
  //         ),
  //         const Text(
  //           "\'Per Hiring Get ₹ 600 Incentives\n( ₹ 500 + 500 Orders ₹ 100 = ₹ 600)\'",
  //           // "\"Get Rs 650 Incentives & \n150 Orders Bonus\"",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //               fontFamily: 'MontserratBold',
  //               color: colors.red,
  //               fontSize: Dimensions.FONT_SIZE_DEFAULT),
  //         ),
  //       ],
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

class MyAlertDialog extends StatefulWidget {
  final String todayOrders;
  final String totalOrders;
  final String totalWorkedDays;
  const MyAlertDialog(
      {super.key,
      required this.todayOrders,
      required this.totalOrders,
      required this.totalWorkedDays});
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  final TextEditingController totalOrdersTarget = TextEditingController();
  @override
  void dispose() {
    totalOrdersTarget.dispose();
    super.dispose();
  }

  int get totalOrdersDifference =>
      int.parse(widget.totalOrders) - int.parse(widget.todayOrders);

  // int get totalMissedOrders =>
  //     ((int.tryParse(widget.totalWorkedDays)! + 1) ?? 0) * 500 - totalOrdersDifference;
  //
  // double get result => (totalMissedOrders < 0 ? 0 : totalMissedOrders) / 500;
  //
  // String get resultText => result % 1 == 0
  //     ? result.toInt().toString()
  //     : (result >= 0 ? result.ceil() : result.floor()).toString();

  int totalMissedOrdersCalculate = 0;
  // double resultCalculate = 0;
  String resultTextCalculate = "0";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF2F2F2),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.1),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Scaffold(
        backgroundColor: const Color(0xFFF2F2F2),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    padding: const EdgeInsets.all(3),
                    child: Transform.rotate(
                      angle: 45 * 3.1415926535 / 180,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
              ),
              const Text(
                'Average Calculator',
                style: TextStyle(
                    fontFamily: 'MontserratBold',
                    color: colors.primary_color,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total Orders Generated:',
                        style: TextStyle(
                            fontFamily: 'MontserratMedium',
                            color: colors.black,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Total Worked Days:',
                        style: TextStyle(
                            fontFamily: 'MontserratMedium',
                            color: colors.black,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Enter Today\'s Target',
                            style: TextStyle(
                                fontFamily: 'MontserratMedium',
                                color: colors.black,
                                fontSize: 14),
                          ),
                          Image.asset(
                            'assets/images/arrow.123354.png',
                            height: 30,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        'Total Missed Orders:',
                        style: TextStyle(
                            fontFamily: 'MontserratMedium',
                            color: colors.black,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        totalOrdersDifference.toString(),
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.primary_color,
                            fontSize: 14),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${int.parse(widget.totalWorkedDays) + 1}",
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.primary_color,
                            fontSize: 14),
                      ),
                      Card(
                        color: const Color(0xFFF2F2F2),
                        elevation: 0,
                        child: SizedBox(
                          height: 50,
                          width: size.width * 0.2,
                          child: TextField(
                            controller: totalOrdersTarget,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: kSecondaryColor,
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0.1,
                                  color: Colors.white70,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 0.1,
                                  color: Colors.white70,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            style: const TextStyle(
                              fontFamily: 'MontserratBold',
                              color: colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        totalMissedOrdersCalculate.toString(),
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            color: colors.primary_color,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                color: const Color(0xFFF2F2F2),
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    if (totalOrdersTarget.text.isNotEmpty) {
                      setState(() {
                        totalMissedOrdersCalculate =
                            ((int.tryParse(widget.totalWorkedDays)! + 1) * 500 -
                                (int.tryParse(totalOrdersTarget.text)!) -
                                totalOrdersDifference);
                        debugPrint(
                            "totalMissedOrdersCalculate: $totalMissedOrdersCalculate");

                        var resultCalculate = ((totalMissedOrdersCalculate < 0
                                ? 0
                                : totalMissedOrdersCalculate) /
                            500);
                        resultTextCalculate = resultCalculate % 1 == 0
                            ? resultCalculate.toInt().toString()
                            : (resultCalculate >= 0
                                    ? resultCalculate.ceil()
                                    : resultCalculate.floor())
                                .toString();
                        debugPrint("resultTextCalculate: $resultTextCalculate");
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 3),
                          backgroundColor: kPurpleColor,
                          behavior: SnackBarBehavior.floating, // Add this line
                          margin:
                              EdgeInsets.only(bottom: 10, left: 15, right: 15),
                          content: Text(
                            'Please enter your today target',
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Colors.white,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: Dimensions.BUTTON_HEIGHT,
                    width: size.width * 0.25,
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
                    child: const Text(
                      'Calculate',
                      style: TextStyle(
                          fontFamily: 'MontserratMedium',
                          color: Colors.white,
                          fontSize: Dimensions.FONT_SIZE_SMALL),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                height: 0.5,
                color: Colors.white70,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Total Hirings Needed',
                style: TextStyle(
                    fontFamily: 'MontserratMedium',
                    color: colors.black,
                    fontSize: 14),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  resultTextCalculate,
                  style: const TextStyle(
                      fontFamily: 'MontserratBold',
                      color: colors.white,
                      fontSize: 16),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Note : No Of Hirings shown is subject to today's date. And it will change on a daily basis, Based on total orders missed and worked days.",
                  style: TextStyle(
                      fontFamily: 'MontserratMedium',
                      color: colors.white,
                      fontSize: 10),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hire Candidates",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                  Icon(
                    Icons.groups,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              ),
              const Text(
                "\'Per Hiring Get ₹ 600 Incentives\n( ₹ 500 + 500 Orders ₹ 100 = ₹ 600)\'",
                // "\"Get Rs 650 Incentives & \n150 Orders Bonus\"",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'MontserratBold',
                    color: colors.red,
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
