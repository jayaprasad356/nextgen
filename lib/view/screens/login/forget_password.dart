import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:nextgen/Helper/apiCall.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/util/Color.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/util/index.dart';
import 'package:nextgen/view/screens/login/create_acc.dart';
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

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  final AuthCon authCon = Get.find<AuthCon>();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;
  late Timer _timer;
  late String deviceID;

  @override
  void initState() {
    super.initState();
    // authCon.deviceInfo();
    deviceInfo();
    // _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
    //   refreshPage();
    // });
  }

  Future<String> deviceInfo() async {
    // late String deviceId;
    Random random = Random();
    int min = 10000000; // Smallest eight-digit number
    int max = 99999999; // Largest eight-digit number

    deviceID = (min + random.nextInt(max - min)).toString();

    debugPrint("deviceId deviceInfo: $deviceID");

    await storeLocal.write(key: Constant.MY_DEVICE_ID, value: deviceID);

    return deviceID;
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   super.dispose();
  // }

  // void refreshPage() {
  //   setState(() async {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgLinear4,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BackLinearColor(
          child: Column(
            children: [
              Expanded(child: Container()),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: kSecondaryLColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_EXTRA2_LARGE)),
                margin: EdgeInsets.only(
                  right: Dimensions.PADDING_SIZE_DEFAULT,
                  left: Dimensions.PADDING_SIZE_DEFAULT,
                  bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,
                  top: size.height * 0.07,
                ),
                padding:
                    const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            color: kTextDarkColor,
                          ),
                        ),
                        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        const Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: kTextDarkColor,
                              fontSize: Dimensions.FONT_SIZE_CLASSIC_LARGE),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      controller: phoneNumController,
                      decoration: InputDecoration(
                        hintText: 'Mobile Phone Number', // Hint text
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
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email ID', // Hint text
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
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    const Text(
                      "Password",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Obx(
                      () => TextField(
                        controller: passwordController,
                        obscureText: authCon.obscuredPass.value,
                        obscuringCharacter: "*",
                        focusNode: authCon.textFieldFocusNodePass,
                        decoration: InputDecoration(
                          hintText: 'Enter Password', // Hint text
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
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, top: 10, bottom: 10),
                            child: GestureDetector(
                                onTap: authCon.toggleObscuredPass,
                                child: authCon.obscuredPass.value
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(
                                        Icons.visibility,
                                        color: kPrimaryColor,
                                      )),
                          ),
                        ),
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            color: kTextDarkColor,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      ),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    const Text(
                      "Confirm Password",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    Obx(
                      () => TextField(
                        controller: confirmController,
                        obscureText: authCon.obscured.value,
                        obscuringCharacter: "*",
                        focusNode: authCon.textFieldFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Enter Confirm Password', // Hint text
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
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(
                                right: 10, top: 10, bottom: 10),
                            child: GestureDetector(
                                onTap: authCon.toggleObscured,
                                child: authCon.obscured.value
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(
                                        Icons.visibility,
                                        color: kPrimaryColor,
                                      )),
                          ),
                        ),
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            color: kTextDarkColor,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      ),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    InkWell(
                      onTap: () async {
                        authCon.showLoadingIndicator(context);
                        await Future.delayed(const Duration(seconds: 5));
                        if (passwordController.text == confirmController.text) {
                          authCon.forgetPass(context,emailController.text,
                              phoneNumController.text, passwordController.text);
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Please check confirm password is similar to password."),
                            duration: Duration(seconds: 2),
                            backgroundColor: kPurpleColor,
                            behavior:
                                SnackBarBehavior.floating, // Add this line
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15),
                          ));
                        }
                        authCon.hideLoadingIndicator(context);
                      },
                      child: Container(
                        height: Dimensions.BUTTON_HEIGHT,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          gradient: const LinearGradient(
                            colors: [Colors.deepOrange, Colors.pink],
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
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Confirm",
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
      ),
    );
  }
}
