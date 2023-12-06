import 'dart:convert';

import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/controller/profile_con.dart';
import 'package:nextgen/model/user.dart';
import 'package:nextgen/util/Color.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/dimensions.dart';
import 'package:nextgen/view/screens/login/mainScreen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextgen/view/widget/back_linear_color.dart';
import 'package:nextgen/view/widget/date_textfield.dart';
import 'package:nextgen/view/widget/default_back.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Helper/apiCall.dart';

class JoinScreen extends StatefulWidget {
  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Join",
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
      body: JoinForm(),
    );
  }
}

class JoinForm extends StatefulWidget {
  @override
  State<JoinForm> createState() => _JoinFormState();
}

class _JoinFormState extends State<JoinForm> {
  // final AuthCon authCon = Get.find<AuthCon>();
  final TextEditingController commentController = TextEditingController();

  String name = "";
  int isSelected = 2;
  bool isFiledComment = true;
  String joinIsTrue = '';
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    // _nameController.text = profileCon.name.toString();
    _initializeData();
  }

  Future<void> _initializeData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      joinIsTrue = prefs.getString(Constant.JOIN_IS_TRUE)!;
    });
  }

  @override
  void setState(VoidCallback fn) async {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgLinear4,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: DefaultBack(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Let us know more about you.",
                style: TextStyle(
                    fontFamily: 'MontserratBold',
                    color: joinIsTrue == '' || joinIsTrue == 'false'
                        ? kWhiteColor
                        : kHintText,
                    fontSize: Dimensions.FONT_SIZE_DEFAULT),
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              ToggleButtons(
                isSelected: const [false, false],
                onPressed: joinIsTrue == '' || joinIsTrue == 'false'
                    ? (int index) {
                        setState(() {
                          isSelected = index;
                        });
                        print('Button $index tapped.');
                      }
                    : (int index) {
                        setState(() {
                          isSelected = 2;
                        });
                      },
                children: [
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.435,
                    decoration: joinIsTrue == '' || joinIsTrue == 'false'
                        ? isSelected == 0
                            ? BoxDecoration(
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
                                borderRadius: BorderRadius.circular(20),
                              )
                            : BoxDecoration(
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
                                borderRadius: BorderRadius.circular(20),
                              )
                        : BoxDecoration(
                            color: Colors.grey,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade700,
                                width: 4.0,
                              ),
                              right: BorderSide(
                                color: Colors.grey.shade700,
                                width: 1.0,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                    margin: EdgeInsets.only(right: size.width * 0.02),
                    alignment: Alignment.center,
                    child: const Text(
                      "New Registration\n( Rs 4999)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.white,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                  ),
                  Container(
                    height: size.height * 0.15,
                    width: size.width * 0.435,
                    decoration: joinIsTrue == '' || joinIsTrue == 'false'
                        ? isSelected == 1
                            ? BoxDecoration(
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
                                borderRadius: BorderRadius.circular(20),
                              )
                            : BoxDecoration(
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
                                borderRadius: BorderRadius.circular(20),
                              )
                        : BoxDecoration(
                            color: Colors.grey,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade700,
                                width: 4.0,
                              ),
                              right: BorderSide(
                                color: Colors.grey.shade700,
                                width: 1.0,
                              ),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                    margin: EdgeInsets.only(right: size.width * 0.02),
                    alignment: Alignment.center,
                    child: const Text(
                      "I am ABCD Users\n( Rs 3999)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: Colors.white,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              isSelected == 0 || isSelected == 1
                  ? Text(
                      "Comments",
                      style: TextStyle(
                          fontFamily: 'MontserratBold',
                          color: joinIsTrue == '' || joinIsTrue == 'false'
                              ? kWhiteColor
                              : kHintText,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    )
                  : const SizedBox(),
              const SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              isSelected == 0 || isSelected == 1
                  ? TextField(
                      controller: commentController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      cursorColor: kWhiteColor,
                      onChanged: (value) {
                        setState(() {
                          isFiledComment = value.isEmpty;
                          debugPrint(" value.isEmpty: ${value.isEmpty}");
                        });
                      },
                      enabled: joinIsTrue == '' || joinIsTrue == 'false'
                          ? true
                          : false,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Comments', // Hint text
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
                          color: kWhiteColor,
                          fontSize: Dimensions.FONT_SIZE_DEFAULT),
                    )
                  : const SizedBox(),
              Expanded(child: Container()),
              InkWell(
                onTap: joinIsTrue == '' || joinIsTrue == 'false'
                    ? isFiledComment == false
                        ? () async {
                            // authCon.joinAPI(context, isSelected.toString(),
                            //     commentController.text,
                            //     (String joinDataSuccess) {
                            //   debugPrint("joinDataSuccess: $joinDataSuccess");
                            //   // Perform actions based on the result of the syncData function
                            //   if (joinDataSuccess == 'true') {
                            //     setState(() {
                            //       joinIsTrue =
                            //           prefs.getString(Constant.JOIN_IS_TRUE)!;
                            //       debugPrint("joinIsTrue:$joinIsTrue");
                            //     });
                            //   }
                            // });
                            // setState(() {
                            //   joinIsTrue = prefs.getString(Constant.JOIN_IS_TRUE)!;
                            //   debugPrint("joinIsTrue:$joinIsTrue");
                            // });
                          }
                        : () {}
                    : () {},
                child: Container(
                  height: Dimensions.BUTTON_HEIGHT,
                  width: size.width,
                  decoration: joinIsTrue == '' || joinIsTrue == 'false'
                      ? BoxDecoration(
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
                        )
                      : BoxDecoration(
                          color: Colors.grey,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade700,
                              width: 4.0,
                            ),
                            right: BorderSide(
                              color: Colors.grey.shade700,
                              width: 1.0,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(1000),
                        ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        color: Colors.white,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
