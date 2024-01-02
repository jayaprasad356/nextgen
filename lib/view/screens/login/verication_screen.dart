import 'dart:convert';
import 'dart:math';

import 'package:nextgen/Helper/apiCall.dart';
import 'package:nextgen/util/Color.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/util/index.dart';
import 'package:nextgen/view/screens/login/otpVerfication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info/device_info.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _referCodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;
  final googleSignIn = GoogleSignIn();
  bool isSigningIn = false;
  String email = "";
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  int randomNumber = Random().nextInt(900000) + 100000;
  late String contact_us;

  @override
  void initState() {
    super.initState();

    // Utils().deviceInfo();
    // PlatformDeviceIdWebPlugin().getDeviceId();
    setState(() {
      setupSettings();
    });
  }

  void setupSettings() async {
    prefs = await SharedPreferences.getInstance();

    var response = await dataCall(Constant.SETTINGS_URL);

    String jsonDataString = response.toString();
    final jsonData = jsonDecode(jsonDataString);

    final dataList = jsonData['data'] as List;

    final datass = dataList.first;
    contact_us = datass[Constant.CONTACT_US];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackLinearColor(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: kBgColor,
                  borderRadius:
                  BorderRadius.circular(Dimensions.RADIUS_EXTRA2_LARGE)),
              margin: const EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_DEFAULT,vertical: Dimensions.PADDING_SIZE_EXTRA_LARGE),
              padding:
              const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Verification",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        color: kTextColor,
                        fontSize: Dimensions.FONT_SIZE_CLASSIC_LARGE),
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter OTP', // Hint text
                      hintStyle: const TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kHintText,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: kPrimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: const TextStyle(
                        fontFamily: 'MontserratBold',
                        color: kTextColor,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  ),
                  const SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                  InkWell(
                    child: Container(
                      height: Dimensions.BUTTON_HEIGHT,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Verify",
                        style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: Colors.white,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      ),
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

  otpsuccess() async {
    Map<String, dynamic> bodyObject = {
      Constant.EMAIL: 'dsds',
    };

    if (_referCodeController.text.isNotEmpty) {
      bodyObject[Constant.REFERRED_BY] = _referCodeController.text;
    }
    String jsonString = await apiCall(
        "https://api.authkey.io/request?authkey=b45c58db6d261f2a&mobile=" +
            _mobileNumberController.text +
            "&country_code=91&sid=9214&otp=" +
            randomNumber.toString() +
            "&company=A1 Ads",
        bodyObject);
  }

  showReferCodeSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(40.0),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SingleChildScrollView(
              child: SizedBox(
                height: 350,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      // const Center(
                      //   child: Text(
                      //     "Enter Referal Code (optional)",
                      //     style: TextStyle(
                      //         fontSize: 18,
                      //         color: colors.greyss,
                      //         fontFamily: "Montserrat"),
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            filled: true,
                            hintText: "Enter Name",
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: _referCodeController,
                          decoration: const InputDecoration(
                            hintText: "Enter Refer Code (optional)",
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: colors.primary),
                            ),
                          ),
                          style: const TextStyle(
                              backgroundColor: Colors.transparent),
                        ),
                      ),

                      const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Same device Multiple Register",
                              style: TextStyle(
                                color: colors.cc_red,
                                fontFamily: 'Montserrat',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Refer bonus can’t be send",
                              style: TextStyle(
                                color: colors.cc_red,
                                fontFamily: 'Montserrat',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),
                      MaterialButton(
                        onPressed: () {
                          //newRegister();
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
                              'Continue',
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

  showSuccesDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Center(
          child: Text(
            'Allow one device one Registration only',
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
