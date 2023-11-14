import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nextgen/data/model/login_mod.dart';
import 'package:nextgen/data/model/register_mod.dart';
import 'package:nextgen/data/model/user_detaile.dart';
import 'package:nextgen/data/repository/auth_repo.dart';
import 'package:nextgen/data/repository/full_time_repo.dart';
import 'package:get/get.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/view/screens/login/login_screen.dart';
import 'package:nextgen/view/screens/login/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCon extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthCon({required this.authRepo}){
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }

  late String loginScc;
  late String registerScc;
  late SharedPreferences prefs;
  String orderAvailable = "";
  String userID = "";

  Future<void> loginAPI(
      mobile,
      password,
      deviceId,
  ) async {
    try {
      final value = await authRepo.login(mobile,password,deviceId);
      var responseData = value.body;
      LoginData loginData = LoginData.fromJson(responseData);
      debugPrint("===> loginData: $loginData");
      debugPrint("===> loginData message: ${loginData.message}");
      debugPrint("===> loginData message: ${loginData.success}");
      Get.snackbar('Sign In', loginData.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);
      if(loginData.success.toString() == 'true'){
        Get.to(const MainScreen());
        prefs.setString(Constant.LOGED_IN_STATUS, "true");
      }
      final String? isLoggedIn = prefs.getString(Constant.LOGED_IN_STATUS);
      debugPrint("store isLoggedIn: $isLoggedIn");
      if (loginData.data != null && loginData.data!.isNotEmpty) {
        userID = loginData.data![0].id!;

        await storeLocal.write(key: Constant.USER_ID, value: userID);
      }
      update();
    } catch (e) {
      debugPrint("loginData errors: $e");
    }
  }

  Future<void> registerAPI(
      name,
      mobile,
      password,
      deviceId,
      email,
      location,
      dob,
      hrId,
      aadhaarNum,
      ) async {
    try {
      final value = await authRepo.createUser(name,mobile,password,deviceId,email,location,dob,hrId,aadhaarNum);
      var responseData = value.body;
      RegisterData registerData = RegisterData.fromJson(responseData);
      debugPrint("===> registerData: $registerData");
      debugPrint("===> registerData message: ${registerData.message}");
      registerScc = registerData.message.toString();
      Get.snackbar("Create Account", registerData.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);
      if(registerData.success.toString() == 'true'){
        Get.to(const LoginScreen());
      }
    } catch (e) {
      debugPrint("registerData errors: $e");
    }
  }

  Future<void> userDetailsAPI(
      userId,
      ) async {
    debugPrint("===> userID : $userID");
    try {
      final value = await authRepo.userDetails(userId);
      var responseData = value.body;
      UserDetail userDetail = UserDetail.fromJson(responseData);
      debugPrint("===> userDetails: $userDetail");
      debugPrint("===> userDetail message: ${userDetail.message}");
      if (userDetail.data != null && userDetail.data!.isNotEmpty) {
        orderAvailable = userDetail.data![0].orderAvailable!;

        await storeLocal.write(key: Constant.ORDERAVAILABLE, value: orderAvailable);
      }
    } catch (e) {
      debugPrint("registerData errors: $e");
    }
  }
}
