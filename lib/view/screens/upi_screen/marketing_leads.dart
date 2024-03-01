import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/controller/wallet_con.dart';
import 'package:nextgen/model/user.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/view/screens/profile_screen/update_profile_screen.dart';
import 'package:nextgen/view/screens/upi_screen/my_withdrawal_records.dart';
import 'package:nextgen/view/screens/upi_screen/verify_ads.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../util/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'bank_detail_screen.dart';

class MarketingLeads extends StatefulWidget {
  const MarketingLeads({Key? key}) : super(key: key);

  @override
  State<MarketingLeads> createState() => _MarketingLeadsState();
}

class _MarketingLeadsState extends State<MarketingLeads> {
  final WalletCon walletCon = Get.find<WalletCon>();
  final AuthCon authCon = Get.find<AuthCon>();
  final TextEditingController _withdrawalAmtController =
  TextEditingController();
  TextEditingController _upiIdController = TextEditingController();
  Utils utils = Utils();
  late SharedPreferences prefs;
  String balance = "";
  String minimum = "";
  String name = "";
  String mobile = "";
  String earn = "0.00";
  // String ordersEarnings = "0.00";
  // String hiringEarnings = "0.00";

  late String _upiId;
  late String _fcmToken;
  late String totalRefund = '';

  @override
  void initState() {
    // TODO: implement initState
    walletCon.handleAsyncInit();
    _upiIdController.text = walletCon.upi.toString();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    walletCon.handleAsyncInit();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _isDisabled = true;
    return Scaffold(
      backgroundColor: colors.secondary_color,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary_color,
                colors.primary_color2
              ], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Marketing Leads",
          style: TextStyle(fontFamily: 'MontserratBold', color: colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, // Set width to the screen width
        height: MediaQuery.of(context)
            .size
            .height, // Set height to the screen height
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [colors.primary_color, colors.secondary_color],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white70
              ),
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                        () => Text(
                      walletCon.name.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                        () => Text(
                      walletCon.mobile.toString(),
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
