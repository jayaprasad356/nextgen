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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthCon authCon = Get.find<AuthCon>();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late SharedPreferences prefs;

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
                    const Text(
                      "Sign in Your Account",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_CLASSIC_LARGE),
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
                        obscureText: authCon.obscured.value,
                        obscuringCharacter: "*",
                        focusNode: authCon.textFieldFocusNode,
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
                        var device_id =
                            await storeLocal.read(key: Constant.MY_DEVICE_ID);
                        authCon.loginAPI(phoneNumController.text,
                            passwordController.text, device_id);
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
                          "Sign in",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: Colors.white,
                              fontSize: Dimensions.FONT_SIZE_DEFAULT),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const InkWell(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: kPrimaryColor,
                              fontSize: Dimensions.FONT_SIZE_SMALL,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(const CreateAccountScreen());
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
                              borderRadius: BorderRadius.circular(1000),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                  fontFamily: 'MontserratBold',
                                  color: Colors.white,
                                  fontSize: Dimensions.FONT_SIZE_DEFAULT),
                            ),
                          ),
                        ),
                      ],
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
