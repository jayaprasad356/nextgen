// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
//
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:nextgen/Helper/apiCall.dart';
// import 'package:nextgen/controller/full_time_page_con.dart';
// import 'package:nextgen/controller/home_controller.dart';
// import 'package:nextgen/controller/home_con.dart';
// import 'package:nextgen/model/slider_data.dart';
// import 'package:nextgen/model/user.dart';
// import 'package:nextgen/controller/utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nextgen/util/color_const.dart';
// import 'package:nextgen/util/image_const.dart';
// import 'package:nextgen/util/index.dart';
// import 'package:nextgen/view/widget/default_back.dart';
// import 'package:percent_indicator/percent_indicator.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../util/Color.dart';
// import '../../../util/Constant.dart';
// import 'package:slide_action/slide_action.dart';
//
// class WorkScreen extends StatefulWidget {
//   const WorkScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WorkScreen> createState() => WorkScreenState();
// }
//
// class WorkScreenState extends State<WorkScreen> {
//   final WorkCont workCont = Get.find<WorkCont>();
//   final HomeController homeController = Get.find<HomeController>();
//   late SharedPreferences prefs;
//   double starttime = 0; // Set the progress value between 0.0 and 1.0 here
//   String today_ads_remain = "0";
//   String level = '0', status = '';
//   String history_days = '0';
//   String ads_image = 'https://admin.colorjobs.site/dist/img/logo.jpeg';
//   String ads_link = '';
//   int time_start = 0;
//   double seconds = 0.0;
//   String time_left = '0';
//   String max_coin = "0";
//   String refer_amount = "0";
//   String generate_coin = "0";
//   bool _isLoading = true;
//   String balance = "0";
//   String ads_cost = "0";
//   bool timerStarted = false;
//   bool isTrial = true, isPremium = false;
//   Random random = Random();
//   late String contact_us;
//   final TextEditingController _serialController = TextEditingController();
//   String serilarandom = "",
//       basic_wallet = "",
//       // premium_wallet = "",
//       target_refers = "",
//       today_ads = "0",
//       total_ads = "0",
//       reward_ads = "0",
//       ads_time = "0";
//   double progressbar = 0.0;
//   late String image = "", referText = "", offer_image = "", refer_bonus = "";
//   int adsCount = 0;
//   int rewardAds = 0;
//   double progressPercentage = 0.0;
//   double progressPercentageTwo = 0.0;
//   late bool isButtonDisabled;
//   late bool isClaimButtonDisabled;
//   late String generatedOtp;
//   late String syncType;
//   int syncUniqueId = 1;
//   double multiplyCostValue = 0;
//   double maximumValue = 120.0;
//   double currentValue = 60.0;
//   double progressPercentage1 = 0.00;
//   late String isWeb;
//   String orderAvailable = '1';
//   String? productEan = '';
//
//   @override
//   void initState() {
//     super.initState();
//     handleAsyncInit();
//     progressPercentage1 = currentValue / maximumValue;
//
//     isButtonDisabled = true;
//     isClaimButtonDisabled = true;
//
//     // // Initialize focus nodes and controllers
//     // focusNodes = List.generate(4, (index) => FocusNode());
//     // controllers = List.generate(4, (index) => TextEditingController());
//
//     // SharedPreferences.getInstance().then((value) {
//     //   prefs = value;
//     //   ads_time = prefs.getString(Constant.ADS_TIME)!;
//     //   balance = prefs.getString(Constant.BALANCE)!;
//     //   today_ads = prefs.getString(Constant.TODAY_ADS)!;
//     //   total_ads = prefs.getString(Constant.TOTAL_ADS)!;
//     //   ads_cost = prefs.getString(Constant.ADS_COST)!;
//     //   referText = prefs.getString(Constant.REFER_CODE)!;
//     //   reward_ads = prefs.getString(Constant.REWARD_ADS)!;
//     //   debugPrint("reward_ads : $reward_ads");
//     //   // setState(() {
//     //   //   ads_time = prefs.getString(Constant.ADS_TIME)!;
//     //   //   balance = prefs.getString(Constant.BALANCE)!;
//     //   //   today_ads = prefs.getString(Constant.TOTAL_ADS)!;
//     //   //   total_ads = prefs.getString(Constant.TOTAL_ADS)!;
//     //   //   ads_cost = prefs.getString(Constant.ADS_COST)!;
//     //   //   referText = prefs.getString(Constant.REFER_CODE)!;
//     //   //   refer_bonus = prefs.getString(Constant.REFER_BONUS)!;
//     //   //   // adsApi();
//     //   // });
//     //   //ads_status("status");
//     // });
//
//     loadTimerCount();
//     debugPrint("orderAvailable: $orderAvailable");
//
//     // progressPercentageTwo = double.parse(reward_ads);
//     // debugPrint("progressPercentageTwo : $progressPercentageTwo");
//   }
//
//   void handleAsyncInit() async {
//     setState(() async {
//       isWeb = (await storeLocal.read(key: Constant.IS_WEB))!;
//       // productEan = workCont.generateRandomNineDigitNumber()}";
//       // print("productEan: $productEan");
//     });
//   }
//
//   // @override
//   // void dispose() {
//   //   // Dispose focus nodes and controllers
//   //   for (var node in focusNodes) {
//   //     node.dispose();
//   //   }
//   //   for (var controller in controllers) {
//   //     controller.dispose();
//   //   }
//   //   super.dispose();
//   // }
//
//   @override
//   void setState(VoidCallback fn) async {
//     // TODO: implement setState
//     super.setState(fn);
//
//     // balance;
//     // total_ads;
//     // today_ads;
//     // multiplyCostValue = multiplyCost(adsCount, ads_cost)!;
//     if (adsCount < 120) {
//       isButtonDisabled = true; // Disable the button
//     } else if (adsCount >= 120) {
//       isButtonDisabled = false; // Enable the button
//     } else if (adsCount > 120) {
//       progressPercentage = 0.0;
//       isButtonDisabled = false; // Enable the button
//       adsCount = 0;
//     }
//     rewardAds = int.parse(reward_ads);
//     debugPrint("rewardAds : $rewardAds");
//     progressPercentageTwo = double.parse(reward_ads) / maximumValue;
//     debugPrint("progressPercentageTwo : $progressPercentageTwo");
//
//     if (rewardAds < 120) {
//       isClaimButtonDisabled = true; // Disable the button
//     } else if (rewardAds >= 120) {
//       syncUniqueId = workCont.generateRandomSixDigitNumber();
//       isClaimButtonDisabled = false; // Enable the button
//     }
//   }
//
//   void startTimer() {
//     // Example: Countdown from 100 to 0 with a 1-second interval
//     const oneSec = Duration(seconds: 1);
//     int adsTimeInSeconds = int.parse(ads_time);
//     Timer.periodic(oneSec, (Timer timer) {
//       if (starttime >= adsTimeInSeconds) {
//         timer.cancel();
//
//         setState(() {
//           progressbar = 0.0;
//           timerStarted = false;
//           progressPercentage;
//         });
//         adsCount++;
//         print('timerCount called $adsCount times.');
//         multiplyCostValue = adsCount * double.parse(ads_cost);
//         setState(() {
//           progressPercentage = (adsCount / maximumValue);
//           debugPrint("timerCount: $adsCount");
//           saveTimerCount(adsCount, multiplyCostValue);
//           if (adsCount < 119) {
//             isButtonDisabled = true; // Disable the button
//           } else if (adsCount >= 119) {
//             syncUniqueId = workCont.generateRandomSixDigitNumber();
//             debugPrint("syncUniqueId: $syncUniqueId");
//             isButtonDisabled = true; // Disable the button
//             // adsCount = 0;
//           } else if (adsCount == 120) {
//             isButtonDisabled = false; // Enable the button
//             // adsCount = 0;
//           } else if (adsCount > 120) {
//             progressPercentage = 0.0;
//             isButtonDisabled = false; // Enable the button
//             adsCount = 0;
//           }
//         });
//         // if (timerCount < 100) {
//         //   isButtonDisabled = true; // Disable the button
//         // } else if (timerCount >= 100) {
//         //   syncUniqueId = fullTimePageCont.generateRandomSixDigitNumber();
//         //   isButtonDisabled = false; // Enable the button
//         //   // timerCount = 1;
//         // }
//       } else {
//         setState(() {
//           starttime++;
//           seconds = starttime % adsTimeInSeconds;
//           progressbar = starttime / adsTimeInSeconds;
//         });
//       }
//     });
//   }
//
//   // Load timerCount from shared preferences
//   void loadTimerCount() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       adsCount = prefs.getInt('timerCount') ?? 0;
//       multiplyCostValue = adsCount * double.parse(ads_cost);
//       progressPercentage = (adsCount / maximumValue);
//     });
//   }
//
//   // Save timerCount to shared preferences
//   void saveTimerCount(int count, double cost) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setInt('timerCount', count);
//     await prefs.setDouble('multiplyCostValueLocal', cost);
//   }
//
//   String separateNumber(String number) {
//     if (number.length != 12) {
//       throw Exception("Number must be 12 digits long.");
//     }
//
//     List<String> groups = [];
//
//     for (int i = 0; i < 12; i += 4) {
//       groups.add(number.substring(i, i + 4));
//     }
//
//     return groups.join('-');
//   }
//
//   bool isMultipleOf5(int number) {
//     return number % 5 == 0;
//   }
//
//   double? multiplyCost(int timerCount, String str2) {
//     try {
//       double num2 = double.parse(str2);
//       return timerCount * num2;
//     } catch (e) {
//       print('Error: Unable to parse the input string as a number.');
//       return null;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: kBgLinear4,
//       body: DefaultBack(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(
//                   width: 3,
//                   color: Colors.white
//               ),
//               borderRadius: BorderRadius.circular(Dimensions.RADIUS_EXTRA_LARGE),
//             ),
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularPercentIndicator(
//                       radius: 35.0,
//                       lineWidth: 10.0,
//                       animation: true,
//                       percent: progressPercentageTwo.clamp(0.0, 1.0),
//                       backgroundWidth: 13,
//                       center: Text(
//                         (progressPercentageTwo * maximumValue).toInt().toString(),
//                         style: const TextStyle(
//                             fontFamily: 'MontserratBold',
//                             fontSize: 16.0,
//                             color: kTextColor),
//                       ),
//                       footer: IgnorePointer(
//                         ignoring: isClaimButtonDisabled,
//                         child: InkWell(
//                           onTap: () async {
//                             syncType = 'reward_sync';
//                             debugPrint("syncType: $syncType");
//                             try {
//                               prefs = await SharedPreferences.getInstance();
//                               setState(() {
//                                 syncUniqueId;
//                               });
//                               debugPrint("syncUniqueId: $syncUniqueId");
//                               // Call the syncData function and get the result immediately
//                               // workCont.syncData(
//                               //   prefs.getString(Constant.ID),
//                               //   adsCount.toString(),
//                               //   (String syncDataSuccess) {
//                               //     debugPrint(
//                               //         "syncDataSuccess: $syncDataSuccess");
//                               //     // Perform actions based on the result of the syncData function
//                               //     if (syncDataSuccess == 'true') {
//                               //       setState(() {
//                               //         isClaimButtonDisabled = true;
//                               //         reward_ads = prefs.getString(
//                               //             Constant.REWARD_ADS)!;
//                               //         ads_time = prefs.getString(
//                               //             Constant.ADS_TIME)!;
//                               //         balance = prefs
//                               //             .getString(Constant.BALANCE)!;
//                               //         today_ads = prefs.getString(
//                               //             Constant.TODAY_ADS)!;
//                               //         total_ads = prefs.getString(
//                               //             Constant.TOTAL_ADS)!;
//                               //         ads_cost = prefs.getString(
//                               //             Constant.ADS_COST)!;
//                               //       });
//                               //     } else {}
//                               //   },
//                               // );
//                             } catch (e) {
//                               // Handle any errors that occur during the process
//                               debugPrint("Error: $e");
//                             }
//                           },
//                           child: Container(
//                             decoration: isClaimButtonDisabled == false
//                                 ? BoxDecoration(
//                                     gradient: const LinearGradient(
//                                       begin: Alignment.topRight,
//                                       end: Alignment.bottomLeft,
//                                       colors: [
//                                         Colors.deepOrangeAccent,
//                                         Colors.pink,
//                                       ],
//                                     ),
//                                     borderRadius: BorderRadius.circular(10),
//                                   )
//                                 : BoxDecoration(
//                                     color: Colors.grey[200],
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15, vertical: 10),
//                             margin: const EdgeInsets.only(top: 10),
//                             child: Text(
//                               "Sync",
//                               style: TextStyle(
//                                   fontFamily: 'MontserratBold',
//                                   fontSize: 12.0,
//                                   color: isClaimButtonDisabled == false
//                                       ? Colors.white
//                                       : Colors.grey[500]
//                                   // : Colors.orangeAccent[200],
//                                   ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       linearGradient: const LinearGradient(
//                         colors: [
//                           Colors.deepOrangeAccent,
//                           Colors.pink,
//                         ],
//                       ),
//                       circularStrokeCap: CircularStrokeCap.round,
//                       // progressColor: Colors.deepOrangeAccent,
//                     ),
//                     const SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: kSecondaryColor,
//                             borderRadius:
//                                 BorderRadius.circular(Dimensions.RADIUS_SMALL),
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 15,
//                             vertical: 10,
//                           ),
//                           child: const Text(
//                             "Wallet Balance",
//                             style: TextStyle(
//                                 fontFamily: 'MontserratBold',
//                                 color: Colors.white,
//                                 fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
//                           ),
//                         ),
//                         const SizedBox(
//                             height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                         const Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Today Orders :",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                                 SizedBox(
//                                     height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(
//                                   "Total Orders :",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                                 SizedBox(
//                                     height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(
//                                   "Work Days :",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                                 SizedBox(
//                                     height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(
//                                   "My Daily Average :",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                                 SizedBox(
//                                     height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(
//                                   "Department Store",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kPurpleColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                                 width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   "50000",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                                 SizedBox(
//                                     height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(
//                                   "500",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                                 SizedBox(
//                                     height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(
//                                   "500",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                                 SizedBox(
//                                     height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                                 Text(
//                                   "500",
//                                   style: TextStyle(
//                                       fontFamily: 'MontserratBold',
//                                       color: kTextColor,
//                                       fontSize: Dimensions.FONT_SIZE_SMALL),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Column(
//                       children: [
//                         const Text(
//                           "Copy",
//                           style: TextStyle(
//                               fontFamily: 'MontserratBold',
//                               color: kTextColor,
//                               fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                         ),
//                         const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                         InkWell(
//                           onTap: (){
//                             workCont.copyText(context, );
//                           },
//                           child: Container(
//                             height: Dimensions.BUTTON_HEIGHT,
//                             width: size.width * 0.15,
//                             decoration: BoxDecoration(
//                               color: kPurpleColor,
//                               borderRadius: BorderRadius.circular(1000),
//                               border: Border(
//                                 bottom: BorderSide(
//                                   color: Colors.purple.shade800,
//                                   width: 4.0,
//                                 ),
//                                 right: BorderSide(
//                                   color: Colors.purple.shade800,
//                                   width: 2.0,
//                                 ),
//                               ),
//                             ),
//                             child: const Icon(
//                               Icons.copy,
//                               color: kWhiteColor,
//                               size: 14,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//                     Column(
//                       children: [
//                         const Text(
//                           "Product EAN",
//                           style: TextStyle(
//                               fontFamily: 'MontserratBold',
//                               color: kTextColor,
//                               fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                         ),
//                         const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                         Container(
//                           height: Dimensions.BUTTON_HEIGHT,
//                           decoration: BoxDecoration(
//                             color: kSecondaryColor,
//                             borderRadius: BorderRadius.circular(1000),
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
//                           alignment: Alignment.center,
//                           child: Text(
//                             productEan!,
//                             style: const TextStyle(
//                                 fontFamily: 'MontserratBold',
//                                 color: Colors.white,
//                                 fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//                     Column(
//                       children: [
//                         const Text(
//                           "Qty Sold",
//                           style: TextStyle(
//                               fontFamily: 'MontserratBold',
//                               color: kTextColor,
//                               fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                         ),
//                         const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                         Container(
//                           height: Dimensions.BUTTON_HEIGHT,
//                           width: size.width * 0.2,
//                           decoration: BoxDecoration(
//                             color: kSecondaryColor,
//                             borderRadius: BorderRadius.circular(1000),
//                           ),
//
//                           alignment: Alignment.center,
//                           child: const Text(
//                             "34",
//                             style: TextStyle(
//                                 fontFamily: 'MontserratBold',
//                                 color: Colors.white,
//                                 fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
//                 Container(
//                   width: size.width,
//                   decoration: BoxDecoration(
//                     color: kSecondaryColor,
//                     borderRadius:
//                         BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
//                   ),
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 15,
//                     vertical: 15,
//                   ),
//                   alignment: Alignment.center,
//                   child: Column(
//                     children: [
//                       const Text(
//                         "Place Order From Warehouse",
//                         style: TextStyle(
//                             fontFamily: 'MontserratBold',
//                             color: kWhiteColor,
//                             fontSize: Dimensions.FONT_SIZE_LARGE),
//                       ),
//                       const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Column(
//                             children: [
//                               InkWell(
//                                 onTap: (){
//                                   workCont.pasteText(context);
//                                 },
//                                 child: Container(
//                                   height: Dimensions.BUTTON_HEIGHT,
//                                   width: size.width * 0.15,
//                                   decoration: BoxDecoration(
//                                     color: kPurpleColor,
//                                     borderRadius: BorderRadius.circular(1000),
//                                     border: Border(
//                                       bottom: BorderSide(
//                                         color: Colors.purple.shade800,
//                                         width: 4.0,
//                                       ),
//                                       right: BorderSide(
//                                         color: Colors.purple.shade800,
//                                         width: 2.0,
//                                       ),
//                                     ),
//                                   ),
//                                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
//                                   child: const Icon(
//                                     Icons.paste,
//                                     color: kWhiteColor,
//                                     size: 14,
//                                   ),
//                                 ),
//                               ),
//                                   const Text(
//                                     "Paste",
//                                     style: TextStyle(
//                                         fontFamily: 'MontserratBold',
//                                         color: Colors.white,
//                                         fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                                   ),
//                             ],
//                           ),
//                           Container(
//                             height: Dimensions.BUTTON_HEIGHT,
//                             decoration: BoxDecoration(
//                               color: kWhiteColor,
//                               borderRadius: BorderRadius.circular(1000),
//                             ),
//                             padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
//                             alignment: Alignment.center,
//                             child: Obx(() => Text(
//                               workCont.copiedText.isEmpty ? '                            ' : workCont.copiedText.toString(),
//                               style: TextStyle(
//                                   fontFamily: 'MontserratBold',
//                                   color: Colors.purple.shade800,
//                                   fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                             ),)
//                           ),
//                           InkWell(
//                             onTap: () {
//                               workCont.checkAvailability();
//                             },
//                             child: Container(
//                               height: Dimensions.BUTTON_HEIGHT,
//                               width: size.width * 0.2,
//                               decoration: BoxDecoration(
//                                 // color: Colors.grey,
//                                 gradient: const LinearGradient(
//                                   colors: [Color(0xFF569DAA),Color(0xFF0A4D68),],
//                                 ),
//                                 border: const Border(
//                                   bottom: BorderSide(
//                                     color: Color(0xFF0A3648),
//                                     width: 4.0,
//                                   ),
//                                   right: BorderSide(
//                                     color: Color(0xFF0A3648),
//                                     width: 2.0,
//                                   ),
//                                 ),
//                                 borderRadius: BorderRadius.circular(1000),
//                               ),
//                               alignment: Alignment.center,
//                               child: const Text(
//                                 "Check",
//                                 style: TextStyle(
//                                     fontFamily: 'MontserratBold',
//                                     color: Colors.white,
//                                     fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                       InkWell(
//                         child: Obx(() => Container(
//                           height: Dimensions.BUTTON_HEIGHT,
//                           width: size.width * 0.4,
//                           decoration: workCont.orderAvailable == "1" ?  BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [Colors.orange.shade400,Colors.orange.shade900,],
//                             ),
//                             borderRadius: BorderRadius.circular(1000),
//                             border: const Border(
//                               bottom: BorderSide(
//                                 color: Color(0xFFBF6100),
//                                 width: 4.0,
//                               ),
//                               right: BorderSide(
//                                 color: Color(0xFFBF6100),
//                                 width: 2.0,
//                               ),
//                             ),
//                           ) : BoxDecoration(
//                             color: Colors.grey,
//                             borderRadius: BorderRadius.circular(1000),
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Colors.grey.shade900,
//                                 width: 4.0,
//                               ),
//                               right: BorderSide(
//                                 color: Colors.grey.shade900,
//                                 width: 2.0,
//                               ),
//                             ),
//                           ),
//                           alignment: Alignment.center,
//                           child: workCont.orderAvailable.isEmpty ? Container() : Text(
//                             workCont.orderAvailable == "1" ? "Available" : "Not Available",
//                             style: const TextStyle(
//                                 fontFamily: 'MontserratBold',
//                                 color: Colors.white,
//                                 fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                           ),
//                         ),),
//                       ),
//                       const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               const Text(
//                                 "Add to Cart",
//                                 style: TextStyle(
//                                     fontFamily: 'MontserratBold',
//                                     color: kTextColor,
//                                     fontSize: Dimensions.FONT_SIZE_LARGE),
//                               ),
//                               Row(
//                                 children: [
//                                   InkWell(
//                                     onTap: () => workCont.decreaseQuantity(),
//                                     child: Image.asset(
//                                       AppIcons.MINUS_REGTAGLE,
//                                       height: 30,
//                                     ),
//                                   ),
//                                   const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//                                   Obx(
//                                     () => Text(
//                                       workCont.quantity.toString(),
//                                       style: const TextStyle(
//                                         fontFamily: 'MontserratBold',
//                                         color: kWhiteColor,
//                                         fontSize: Dimensions.FONT_SIZE_ULTRA_LARGE,
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//                                   InkWell(
//                                     onTap: () => workCont.increaseQuantity(),
//                                     child: Image.asset(
//                                       AppIcons.PIUSE_REGTAGLE,
//                                       height: 30,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                               width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//                           InkWell(
//                             child: Container(
//                               height: Dimensions.BUTTON_HEIGHT,
//                               width: size.width * 0.36,
//                               decoration: BoxDecoration(
//                                 // color: Colors.grey,
//                                 gradient: const LinearGradient(
//                                   colors: [Color(0xFF569DAA),Color(0xFF0A4D68),],
//                                 ),
//                                 border: const Border(
//                                   bottom: BorderSide(
//                                     color: Color(0xFF0A3648),
//                                     width: 4.0,
//                                   ),
//                                   right: BorderSide(
//                                     color: Color(0xFF0A3648),
//                                     width: 2.0,
//                                   ),
//                                 ),
//                                 borderRadius: BorderRadius.circular(1000),
//                               ),
//                               alignment: Alignment.center,
//                               child: const Text(
//                                 "Confirm",
//                                 style: TextStyle(
//                                     fontFamily: 'MontserratBold',
//                                     color: Colors.white,
//                                     fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                       InkWell(
//                         child: Container(
//                           height: Dimensions.BUTTON_HEIGHT,
//                           width: size.width,
//                           decoration: BoxDecoration(
//                             color: kPrimaryColor,
//                             gradient: const LinearGradient(
//                               colors: [Colors.deepOrange, Colors.pink],
//                             ),
//                             border: Border(
//                               bottom: BorderSide(
//                                 color: Colors.pink.shade900,
//                                 width: 4.0,
//                               ),
//                               right: BorderSide(
//                                 color: Colors.pink.shade900,
//                                 width: 1.0,
//                               ),
//                             ),
//                             borderRadius: BorderRadius.circular(1000),
//                           ),
//                           alignment: Alignment.center,
//                           child: const Text(
//                             "Place Order",
//                             style: TextStyle(
//                                 fontFamily: 'MontserratBold',
//                                 color: Colors.white,
//                                 fontSize: Dimensions.FONT_SIZE_DEFAULT),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Hire Candidates",
//                       style: TextStyle(
//                           fontFamily: 'MontserratBold',
//                           color: kTextColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
//                     ),
//                     SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//                     Icon(
//                       Icons.groups,
//                       size: 30,
//                       color: kWhiteColor,
//                     ),
//                   ],
//                 ),
//                 const Text(
//                   "\"Get Rs 650 Incentives & \n150 Orders Bonus\"",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontFamily: 'MontserratBold',
//                       color: kSecondaryColor,
//                       fontSize: Dimensions.FONT_SIZE_LARGE),
//                 ),
//                 const Text(
//                   "Vacancies Available",
//                   style: TextStyle(
//                       fontFamily: 'MontserratBold',
//                       color: kTextColor,
//                       fontWeight: FontWeight.bold,
//                       fontSize: Dimensions.FONT_SIZE_OVER_LARGE),
//                 ),
//                 const Text(
//                   "28994",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontFamily: 'MontserratBold',
//                       color: kSecondaryColor,
//                       fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> watchAds() async {
//     prefs = await SharedPreferences.getInstance();
//
//     var response = await dataCall(Constant.ADS_URL);
//
//     String jsonDataString = response.toString();
//     final jsonData = jsonDecode(jsonDataString);
//
//     if (jsonData['success']) {
//       // Utils().showToast(jsonData['message']);
//       final dataList = jsonData['data'] as List;
//       final datass = dataList.first;
//       prefs.setString(Constant.ADS_LINK, datass[Constant.ADS_LINK]);
//       prefs.setString(Constant.ADS_IMAGE, datass[Constant.ADS_IMAGE]);
//       setState(() {
//         ads_image = prefs.getString(Constant.ADS_IMAGE)!;
//         ads_link = prefs.getString(Constant.ADS_LINK)!;
//       });
//       starttime = 0;
//       timerStarted = true;
//       startTimer();
//       //userDeatils();
//     } else {
//       Utils().showToast(jsonData['message']);
//     }
//   }
//
//   showAlertDialog(
//     BuildContext context,
//     // String generatedOtp,
//   ) {
//     Size size = MediaQuery.of(context).size;
//
//     AlertDialog alert = AlertDialog(
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(16))),
//       contentPadding: const EdgeInsets.all(20),
//       content: Container(
//         height: size.height * 0.1,
//         decoration: const BoxDecoration(),
//         alignment: Alignment.center,
//         child: SlideAction(
//           trackBuilder: (context, state) {
//             return Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.white,
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 8,
//                   ),
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   state.isPerformingAction ? "Loading..." : "Go To ADS",
//                   style: const TextStyle(
//                       color: colors.black,
//                       fontSize: 14,
//                       fontFamily: "Montserrat",
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             );
//           },
//           thumbBuilder: (context, state) {
//             return Container(
//               margin: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.orange,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Center(
//                 child: state.isPerformingAction
//                     ? const CupertinoActivityIndicator(
//                         color: Colors.white,
//                       )
//                     : const Icon(
//                         Icons.chevron_right,
//                         color: Colors.white,
//                       ),
//               ),
//             );
//           },
//           action: () async {
//             await Future.delayed(
//               const Duration(seconds: 2),
//               () {
//                 debugPrint("action completed");
//                 watchAds();
//                 Navigator.of(context).pop();
//               },
//             );
//           },
//         ),
//       ),
//     );
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
//
// // showAlertDialog(
// //   BuildContext context,
// //   String generatedOtp,
// // ) {
// //   Size size = MediaQuery.of(context).size;
// //
// //   AlertDialog alert = AlertDialog(
// //     shape: const RoundedRectangleBorder(
// //         borderRadius: BorderRadius.all(Radius.circular(10))),
// //     contentPadding: const EdgeInsets.all(20),
// //     content: Container(
// //       height: size.height * 0.2,
// //       decoration: const BoxDecoration(),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               SizedBox(
// //                 width: size.width * 0.5,
// //                 child: Text(
// //                   generatedOtp,
// //                   style: const TextStyle(
// //                     fontFamily: 'MontserratBold',
// //                     fontSize: 14,
// //                     color: Colors.black,
// //                   ),
// //                 ),
// //               ),
// //               InkWell(
// //                 onTap: () => Navigator.of(context).pop(),
// //                 child: Transform.rotate(
// //                   angle: 45 * (3.1415926535 / 180),
// //                   child: const Icon(
// //                     Icons.add,
// //                     // Adjust other properties as needed
// //                     size: 24.0,
// //                     color: Colors.black,
// //                   ),
// //                 ),
// //               )
// //             ],
// //           ),
// //           OtpInputField(
// //             generatedOtp: generatedOtp,
// //             onPress: (enteredOtp) {
// //               if (enteredOtp == generatedOtp) {
// //                 print('OTP Matched');
// //                 watchAds();
// //                 Navigator.of(context).pop();
// //               } else {
// //                 print('OTP Mismatch');
// //               }
// //               print('Entered OTP: $enteredOtp');
// //             },
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// //
// //   showDialog(
// //     context: context,
// //     builder: (BuildContext context) {
// //       return alert;
// //     },
// //   );
// // }
// }
//
// class OtpInputField extends StatefulWidget {
//   final String generatedOtp;
//   final Function onPress;
//   const OtpInputField(
//       {super.key, required this.generatedOtp, required this.onPress});
//
//   @override
//   _OtpInputFieldState createState() => _OtpInputFieldState();
// }
//
// class _OtpInputFieldState extends State<OtpInputField> {
//   TextEditingController otpController1 = TextEditingController();
//   TextEditingController otpController2 = TextEditingController();
//   TextEditingController otpController3 = TextEditingController();
//   TextEditingController otpController4 = TextEditingController();
//
//   @override
//   void dispose() {
//     otpController1.dispose();
//     otpController2.dispose();
//     otpController3.dispose();
//     otpController4.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             buildOtpTextField(otpController1),
//             buildOtpTextField(otpController2),
//             buildOtpTextField(otpController3),
//             buildOtpTextField(otpController4),
//           ],
//         ),
//         const SizedBox(height: 20.0),
//         ElevatedButton(
//           onPressed: () {
//             String enteredOtp =
//                 "${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}";
//             widget.onPress(enteredOtp);
//             //
//             // if (enteredOtp == widget.generatedOtp) {
//             //   print('OTP Matched');
//             // } else {
//             //   print('OTP Mismatch');
//             // }
//             // print('Entered OTP: ${otpController1.text}${otpController2.text}${otpController3.text}${otpController4.text}');
//           },
//           child: const Text('Submit'),
//         ),
//       ],
//     );
//   }
//
//   Widget buildOtpTextField(TextEditingController controller) {
//     return Container(
//       width: 50.0,
//       height: 50.0,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blue, width: 2.0),
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       margin: const EdgeInsets.symmetric(horizontal: 3),
//       child: TextField(
//         controller: controller,
//         maxLength: 1,
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         style: const TextStyle(fontSize: 24.0),
//         decoration: const InputDecoration(
//           counterText: '',
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//         ),
//         onChanged: (value) {
//           FocusScope.of(context).nextFocus();
//         },
//       ),
//     );
//   }
// }
