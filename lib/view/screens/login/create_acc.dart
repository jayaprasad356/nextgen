import 'dart:convert';
import 'dart:math';

import 'package:nextgen/Helper/apiCall.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/util/Color.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/util/index.dart';
import 'package:nextgen/view/screens/login/otpVerfication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextgen/view/widget/date_textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info/device_info.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final AuthCon authCon = Get.find<AuthCon>();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController hrIdController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController DOBController = TextEditingController();
  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackLinearColor(
        child: Container(
          height: size.height * 0.9,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kSecondaryLColor,
              borderRadius:
                  BorderRadius.circular(Dimensions.RADIUS_EXTRA2_LARGE)),
          margin: EdgeInsets.only(
              right: Dimensions.PADDING_SIZE_DEFAULT,
              left: Dimensions.PADDING_SIZE_DEFAULT,
              bottom: Dimensions.PADDING_SIZE_EXTRA_LARGE,
              top: size.height * 0.07),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_LARGE),
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(onTap: (){Get.back();},child: const Icon(Icons.arrow_back_ios_new,color: kTextDarkColor,),),
                        const SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                        const Text(
                          "Create Account",
                          style: TextStyle(
                              fontFamily: 'MontserratBold',
                              color: kTextDarkColor,
                              fontSize: Dimensions.FONT_SIZE_CLASSIC_LARGE),
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    const Text(
                      "Name",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter Name', // Hint text
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
                        hintText: 'Enter Email', // Hint text
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
                      "Phone Number",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    TextField(
                      controller: phoneNumController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'Enter Phone Number', // Hint text
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
                      "Date of Birth",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    DateTextField(controller: DOBController,color: kTextDarkColor,borderColor: kPrimaryColor,),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    const Text(
                      "Location",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    TextField(
                      controller: locationController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Enter Location', // Hint text
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
                        obscureText: authCon.obscuredCreate.value,
                        obscuringCharacter: "*",
                        focusNode: authCon.textFieldFocusNodeCreate,
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
                                onTap: authCon.toggleObscuredCreate,
                                child: authCon.obscuredCreate.value ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility,color: kPrimaryColor,)),
                          ),
                        ),
                        style: const TextStyle(
                            fontFamily: 'MontserratBold',
                            color: kTextDarkColor,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      ),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                    const Text(
                      "Enrolled Under HR ID",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    TextField(
                      controller: hrIdController,
                      decoration: InputDecoration(
                        hintText: 'Enter ID', // Hint text
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
                      "Aadhaar Number",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: kTextDarkColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                    const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                    TextField(
                      controller: aadhaarController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      maxLength: 12,
                      decoration: InputDecoration(
                        hintText: 'Enter Aadhaar Number', // Hint text
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
                    SizedBox(height: size.height * 0.1),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: kSecondaryLColor,
                  child: InkWell(
                    onTap: () async {
                      var device_id = await storeLocal.read(key: Constant.MY_DEVICE_ID);
                      authCon.registerAPI(
                          nameController.text,
                          phoneNumController.text,
                          passwordController.text,
                          device_id,
                          emailController.text,
                          locationController.text,
                          DOBController.text,
                          hrIdController.text,
                          aadhaarController.text);
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
                        "Sign up",
                        style: TextStyle(
                            fontFamily: 'MontserratBold',
                            color: Colors.white,
                            fontSize: Dimensions.FONT_SIZE_DEFAULT),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
