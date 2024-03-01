import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/cupertino.dart';
import 'package:nextgen/Helper/apiCall.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/controller/home_con.dart';
import 'package:nextgen/controller/notification_con.dart';
import 'package:nextgen/controller/pcc_controller.dart';
import 'package:nextgen/model/jobs_show.dart';
import 'package:nextgen/model/user.dart';
import 'package:nextgen/reports.dart';
import 'package:nextgen/util/Color.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/dimensions.dart';
import 'package:nextgen/view/screens/JobDetailsScreen/job_details.dart';
import 'package:nextgen/view/screens/add_screen/ads_screen.dart';
import 'package:nextgen/view/screens/add_screen/full_time_page.dart';
import 'package:nextgen/view/screens/add_screen/work_screen.dart';
import 'package:nextgen/view/screens/home_page/homePage.dart';
import 'package:nextgen/view/screens/home_page/home_screen.dart';
import 'package:nextgen/view/screens/invest/invers_screen.dart';
import 'package:nextgen/view/screens/login/login_screen.dart';
import 'package:nextgen/view/screens/notification_screen/notification_screen.dart';
import 'package:nextgen/view/screens/profile_screen/my_profile.dart';
import 'package:nextgen/view/screens/shorts_vid/3rd_screen.dart';
import 'package:nextgen/view/screens/shorts_vid/my_offer.dart';
import 'package:nextgen/view/screens/shorts_vid/preload_page.dart';
import 'package:nextgen/view/screens/shorts_vid/post_upload.dart';
import 'package:nextgen/view/screens/store/store_page.dart';
import 'package:nextgen/view/screens/upi_screen/upiPay.dart';
import 'package:nextgen/view/screens/upi_screen/wallet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nextgen/view/widget/join_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MainScreen extends StatefulWidget {
  final bool isNotifyNav;
  MainScreen({Key? key, required this.isNotifyNav}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthCon authCon = Get.find<AuthCon>();
  final NotificationController notificationController =
  Get.find<NotificationController>();
  final HomeController homeController = Get.find<HomeController>();
  // final PCC c = Get.find<PCC>();
  final TextEditingController _payAmountController = TextEditingController();
  final TextEditingController _addCoinController = TextEditingController();


  int _selctedIndex = 0;
  String title = "Nextgen";
  String upi_id = "";
  bool _actionsVisible = true;
  bool _logoutVisible = false;
  bool _leftArrowVisible = false;
  bool _notificationVisible = false;
  bool _downloadVisible = false;
  bool _youtubeVideo = false;
  late Users user;
  late SharedPreferences prefs;
  String coins = "0";
  String balance = "";
  String status = "";
  String old_plan = "";
  String plan = "";
  String text = 'Click here Send ScreenShoot';
  // String link = 'http://t.me/Colorchallengeapp1';
  final googleSignIn = GoogleSignIn();
  late String contact_us = "";
  late String _fcmToken;
  int executionCount = 0;
  Timer? timer;
  String joinIsTrue = '';
  late bool isNotifyId;
  late Timer timerNotify;

  @override
  void initState() {
    super.initState();
    // setupSettings();

    if (widget.isNotifyNav != true) {
      notificationController.notificationAPI();
    }

    html.window.addEventListener('visibilitychange', (event) {
      if (html.document.visibilityState == 'visible') {
        // Tab is active
        print('Tab is now active');
        html.window.location.reload();
        // Future.delayed(Duration(seconds: 2), () {
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text("Welcome to Your App"),
        //         content: Text("This is an automatic alert."),
        //         actions: [
        //           InkWell(
        //             onTap: () {
        //               Navigator.of(context).pop(); // Close the dialog
        //             },
        //             child: Text("OK"),
        //           ),
        //         ],
        //       );
        //     },
        //   );
        // });
      } else {
        // Tab is not active
        print('Tab is now inactive');
      }
    });

    FirebaseMessaging.instance.getToken().then((token) {
      setState(() {
        _fcmToken = token!;
        userDeatils();
      });
      print('FCM Token: $_fcmToken');
    });
    startTimer();
    // offerImage();
    debugPrint('widget.isNotifyNav: ${widget.isNotifyNav}');
    if (widget.isNotifyNav == true) {
      _selctedIndex = 2;
    } else {
      _selctedIndex = 0;
    }
    // if (status == '0') {
    //   _selctedIndex = 0;
    // } else {
    //   _selctedIndex = 2;
    // }
  }

  void startTimer() {
    const int maxExecutions = 2;

    timerNotify = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      _initializeData();
      executionCount++;

      if (executionCount >= maxExecutions) {
        timer.cancel();
      }
    });
  }

  Future<void> _initializeData() async {
    String? userID = await storeLocal.read(key: Constant.USER_ID);
    debugPrint('home page userID: $userID');
    authCon.userDetailsAPI(userID);
    prefs = await SharedPreferences.getInstance();
    setState(() async {
      _onItemTapped;
      debugPrint("home page joinIsTrue: $joinIsTrue");
      // joinIsTrue = (await storeLocal.read(key: Constant.JOIN_IS_TRUE)!)!;
      // debugPrint("home page joinIsTrue: $joinIsTrue");
      status = (await storeLocal.read(key: Constant.STATUS))!;
      old_plan = (await storeLocal.read(key: Constant.OLD_PLAN))!;
      plan = (await storeLocal.read(key: Constant.PLAN))!;
      balance = (await storeLocal.read(key: Constant.BALANCE))!;
      isNotifyId = notificationController.isIdMatch.value;
      debugPrint('isNotifyId isNotifyId: $isNotifyId');
      // isNotifyId = (await storeLocal.read(key: "notificationId"))!;
      if(isNotifyId == true) {
        hideLoadingIndicator(context);
        showLoadingIndicator(context);
      }
    });
  }

  @override
  void dispose() {
    timerNotify.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button press
          child: AlertDialog(
            // Remove 'const' here
            content: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'You have new notification',
                    style: TextStyle(
                        fontFamily: 'MontserratMedium',
                        color: Colors.black,
                        fontSize: Dimensions.FONT_SIZE_LARGE),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: (){
                      // Set _selctedIndex to 2 when 'read' is tapped
                      // setState(() {
                      //   _selctedIndex = 2;
                      //   hideLoadingIndicator(context);
                      // });

                      var isNotifyNav = true;

                      notificationController.isIdMatch.value = false;

                      Navigator.of(context).pop();
                      // Navigate to the page corresponding to index 2
                      debugPrint('isNotifyNav: $isNotifyNav');
                      Get.to( MainScreen(isNotifyNav: isNotifyNav));
                      isNotifyNav = false;
                      debugPrint('false isNotifyNav: $isNotifyNav');
                    },
                    child: Container(
                      height: 50,
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
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Text(
                        'Read',
                        style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: kWhiteColor,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    joinIsTrue = prefs.getString(Constant.JOIN_IS_TRUE)!;
    debugPrint("setStatejoinIsTrue: $joinIsTrue");
  }

  // @override
  // void setState(VoidCallback fn) {
  //   // TODO: implement setState
  //   super.setState(fn);
  //   homeController.allSettingsData();
  //   c.offerImageURS();
  // }

  void userDeatils() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.FCM_ID: _fcmToken
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.LOGED_IN, "true");
    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.MOBILE, user.mobile);
    prefs.setString(Constant.NAME, user.name);
    prefs.setString(Constant.UPI, user.upi);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.TODAY_ADS, user.today_ads);
    prefs.setString(Constant.TOTAL_ADS, user.total_ads);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
    prefs.setString(Constant.MIN_WITHDRAWAL, user.min_withdrawal);
    prefs.setString(Constant.HOLDER_NAME, user.holder_name);
    prefs.setString(Constant.ACCOUNT_NUM, user.account_num);
    prefs.setString(Constant.IFSC, user.ifsc);
    prefs.setString(Constant.BANK, user.bank);
    prefs.setString(Constant.BRANCH, user.branch);
    prefs.setString(Constant.OLD_PLAN, user.old_plan);
    prefs.setString(Constant.PLAN, user.plan);
    prefs.setString(Constant.ADS_TIME, user.ads_time);
    prefs.setString(Constant.ADS_COST, user.ads_cost);
    prefs.setString(Constant.REWARD_ADS, user.reward_ads);
    setState(() {
      status = prefs.getString(Constant.STATUS)!;
      old_plan = prefs.getString(Constant.OLD_PLAN)!;
      plan = prefs.getString(Constant.PLAN)!;
      balance = prefs.getString(Constant.BALANCE)!;
    });
    if (user.status == "2" || user.device_id == "0") {
      logout();
      SystemNavigator.pop();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selctedIndex = index;
      if (index == 1) {
        title = "Job Detail";
        _actionsVisible = false;
        _downloadVisible = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _youtubeVideo = true;
      } else if (index == 2) {
        title = "Notifications";
        _actionsVisible = false;
        _downloadVisible = true;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _youtubeVideo = false;
      } else if (index == 3) {
        title = "Profile";
        _actionsVisible = false;
        _downloadVisible = false;
        _logoutVisible = true;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _youtubeVideo = false;
      } else {
        title = "Nextgen";
        _actionsVisible = true;
        _downloadVisible = false;
        _logoutVisible = false;
        _leftArrowVisible = false;
        _notificationVisible = false;
        _youtubeVideo = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgLinear4,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                kBgLinear1,
                kBgLinear2,
                kBgLinear3,
                kBgLinear4,
              ], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Montserra', color: colors.white),
        ),
        leading: _leftArrowVisible
            ? const Icon(
                Icons.arrow_back_outlined,
                color: colors.black,
              )
            : (null),
        actions: _actionsVisible
            ? [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'How to take trail',
                      style: TextStyle(
                          fontFamily: 'MontserratLight',
                          color: kWhiteColor,
                          fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                    ),
                    InkWell(
                        onTap: () {
                          String uri =
                              'https://youtu.be/N0ao4OA_OQI?si=u0DxUYKe7Lrw7RHD';
                          launchUrl(
                            Uri.parse(uri),
                            mode: LaunchMode.inAppWebView,
                          );
                          // authCon.showLoadingIndicator(context);
                          // await Future.delayed(const Duration(seconds: 5));
                          // html.window.location.reload();
                          // authCon.hideLoadingIndicator(context);
                        },
                        child: Container(
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
                              vertical: 5, horizontal: 10),
                          child: const Text(
                            'Open',
                            style: TextStyle(
                                fontFamily: 'MontserratBold',
                                color: kWhiteColor,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                          ),
                        )),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
              ]
            : [
                _logoutVisible
                    ? GestureDetector(
                        onTap: () {
                          // prefs.setString(Constant.LOGED_IN, "false");
                          // logout();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                            child: Image.asset(
                              "assets/images/logout.png",
                              height: 24,
                              width: 30,
                            ),
                          ),
                        ),
                      )
                    : const Text(""),
                _downloadVisible
                    // ? Container()
                    ? Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: InkWell(
                            onTap: () {
                              String uri =
                                  'https://drive.google.com/file/d/1IEFyCyKmAckRR7N043uZaCbTlTt54QoN/view?usp=drivesdk'; //place download link
                              launchUrl(
                                Uri.parse(uri),
                                mode: LaunchMode.inAppWebView,
                              );
                            },
                            child: Container(
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
                                  vertical: 10, horizontal: 20),
                              child: const Text(
                                'Install App',
                                style: TextStyle(
                                    fontFamily: 'MontserratBold',
                                    color: kWhiteColor,
                                    fontSize: Dimensions.FONT_SIZE_SMALL),
                              ),
                            )),
                      )
                    : const Text(""),
                _notificationVisible
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotifyScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                            child: Image.asset(
                              "assets/images/notification.png",
                              height: 24,
                              width: 30,
                            ),
                          ),
                        ),
                      )
                    : const Text(""),
                _youtubeVideo
                    ? Container(
                  width: 100,
                      margin: const EdgeInsets.only(
                        right: 15,),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'How we work',
                              style: TextStyle(
                                  fontFamily: 'MontserratLight',
                                  color: kWhiteColor,
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            ),
                            InkWell(
                                onTap: () {
                                  String uri =
                                      'https://youtu.be/-h4tsBOdF50?si=fX3ez1_UE3l2Rfjx';
                                  launchUrl(
                                    Uri.parse(uri),
                                    mode: LaunchMode.inAppWebView,
                                  );
                                  // authCon.showLoadingIndicator(context);
                                  // await Future.delayed(const Duration(seconds: 5));
                                  // html.window.location.reload();
                                  // authCon.hideLoadingIndicator(context);
                                },
                                child: Container(
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
                                      vertical: 5, horizontal: 10),
                                  child: const Text(
                                    'Open',
                                    style: TextStyle(
                                        fontFamily: 'MontserratBold',
                                        color: kWhiteColor,
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL),
                                  ),
                                )),
                          ],
                        ),
                    )
                    : const Text(""),
              ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 1),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(1)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kPrimaryColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage(
                    "assets/images/home.png",
                  ),
                  color: _selctedIndex == 0 ? Colors.deepOrange : colors.white,
                ),
                label: 'Home',
                backgroundColor: colors.primary_color,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.work,
                      color: _selctedIndex == 1
                          ? Colors.deepOrange
                          : colors.white),
                  label: 'Job Detail',
                  backgroundColor: colors.white),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage(
                    "assets/images/notification.png",
                  ),
                  color: _selctedIndex == 2 ? Colors.deepOrange : colors.white,
                ),
                label: 'Notification',
                backgroundColor: colors.primary_color,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color: _selctedIndex == 3
                          ? Colors.deepOrange
                          : colors.white),
                  label: 'Profile',
                  backgroundColor: colors.white),
            ],
            currentIndex: _selctedIndex,
            selectedItemColor: Colors.deepOrange,
            unselectedItemColor: colors.white,
            onTap: _onItemTapped,
          ),
        ),
      ),
      body: getPage(_selctedIndex),
    );
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

  showTopupBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Top up",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: colors.black,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                          child: Text(
                        "Current Balance",
                        style: TextStyle(fontFamily: "Montserrat"),
                      )),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Text(
                        balance,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat",
                            color: colors.primary),
                      )),
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text("Enter Coins"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _payAmountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                filled: true,
                                border: InputBorder.none,
                                hintText: '5 - 1000'),
                            style: const TextStyle(
                                backgroundColor: Colors.transparent),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MaterialButton(
                        onPressed: () {
                          String amt;
                          amt = _payAmountController.text;
                          double doubleValue = double.parse(amt);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PayPage(doubleValue)),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          height: 80,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/Verify.png"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Pay',
                              style: TextStyle(
                                  color: colors.white,
                                  fontSize: 18,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
          );
        });
  }

  showUpiDetailSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40.0),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const SizedBox(
              height: 500, // Adjust the height according to your needs
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Add Coins",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        // return const JobDetailScreen(); //HomePage(updateAmount: updateAmount);
        return const HomeScreen(); //HomePage(updateAmount: updateAmount);
      case 1:
        return const JobDetailScreen();
      // return const PreloadPage();
      case 2:
        return const NotifyScreen();
      case 3:
        return const MyProfile();
      default:
        return const MyProfile();
    }
  }

  void setupSettings() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.SETTINGS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;

    prefs.setString(Constant.CONTACT_US, datass[Constant.CONTACT_US]);
    prefs.setString(Constant.IMAGE, datass[Constant.IMAGE]);
    prefs.setString(Constant.REFER_BONUS, datass[Constant.REFER_BONUS]);
    prefs.setString(
        Constant.WITHDRAWAL_STATUS, datass[Constant.WITHDRAWAL_STATUS]);
    prefs.setString(
        Constant.WHATSPP_GROUP_LINK, datass[Constant.WHATSPP_GROUP_LINK]);
    // prefs.setString(
    //     Constant.JOB_VIDEO, datass[Constant.JOB_VIDEO]);
    prefs.setString(Constant.JOB_DETAILS, datass[Constant.JOB_DETAILS]);
    prefs.setString(Constant.WATCH_AD_STATUS, datass[Constant.WATCH_AD_STATUS]);
  }
  // void offerImage() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   var response = await dataCall(Constant.OFFER_LIST);
  //
  //   String jsonDataString = response.toString();
  //   final jsonData = jsonDecode(jsonDataString);
  //
  //   final dataList = jsonData['data'] as List;
  //
  //   final datass = dataList.first;
  //   prefs.setString(Constant.OFFER_IMAGE, datass[Constant.IMAGE]);
  //
  //
  // }

  // ontop() {
  //   Clipboard.setData(ClipboardData(text: link));
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     const SnackBar(content: Text('Copied to clipboard')),
  //   );
  //   Utils().showToast("Copied!");
  // }
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  void logout() async {
    clearSharedPreferences();
    SystemNavigator.pop();
    FirebaseAuth.instance.signOut();
    await storeLocal.deleteAll();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
