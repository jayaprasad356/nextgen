import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nextgen/data/model/join_mod.dart';
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

typedef JoinDataCallback = void Function(String joinDataSuccess);

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
  final textFieldFocusNode = FocusNode();
  final textFieldFocusNodeCreate = FocusNode();
  RxBool obscured = true.obs;
  RxBool obscuredCreate = true.obs;
  RxString work_days = ''.obs;
  RxString today_order = ''.obs;
  RxString total_order = ''.obs;
  RxString average_orders = ''.obs;
  RxString balance_nextgen = ''.obs;
  RxString orders_cost = ''.obs;
  RxString joinIsTrue = ''.obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    String? userID = await storeLocal.read(key: Constant.USER_ID);
    debugPrint('userID: $userID');
    userDetailsAPI(userID);
  }

  void toggleObscured() {
      obscured.value = !obscured.value;
      if (textFieldFocusNode.hasPrimaryFocus) return;
      textFieldFocusNode.canRequestFocus = false;
      update();
  }

  void toggleObscuredCreate() {
    obscuredCreate.value = !obscuredCreate.value;
    if (textFieldFocusNodeCreate.hasPrimaryFocus) return;
    textFieldFocusNodeCreate.canRequestFocus = false;
    update();
  }

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
      if(loginData.registered.toString() == 'true'){
        Get.to(const MainScreen());
        prefs.setString(Constant.LOGED_IN_STATUS, "true");
      }
      final String? isLoggedIn = prefs.getString(Constant.LOGED_IN_STATUS);
      if (loginData.data != null && loginData.data!.isNotEmpty) {
        String userID = loginData.data![0].id!;
        debugPrint("userID: $userID");

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

  // Future<void> joinAPI(
  //     context,
  //     abcdUser,
  //     description,
  //     ) async {
  //   var userID = await storeLocal.read(key: Constant.USER_ID);
  //   try {
  //     final value = await authRepo.joinApp(userID!,abcdUser,description);
  //     var responseData = value.body;
  //     debugPrint("===> responseData: $responseData");
  //     JoinData joinData = JoinData.fromJson(responseData);
  //     debugPrint("===> joinData: $joinData");
  //     debugPrint("===> joinData message: ${joinData.message}");
  //     debugPrint("===> joinData message: ${joinData.success}");
  //     if(joinData.success.toString() == 'true') {
  //       prefs.setString(Constant.JOIN_IS_TRUE, "true");
  //     } else {
  //       prefs.setString(Constant.JOIN_IS_TRUE, "false");
  //     }
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //       content: Text("Thanks For Showing Interest. We Will Call You For Further Process."),
  //       duration: Duration(seconds: 2),
  //       backgroundColor: kPurpleColor,
  //       behavior: SnackBarBehavior.floating, // Add this line
  //       margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
  //     ));
  //   } catch (e) {
  //     debugPrint("joinData errors: $e");
  //   }
  // }

  Future<void> joinAPI(
      context,
      abcdUser,
      description,
      JoinDataCallback callback, // Add the callback parameter
      ) async {
    var userID = await storeLocal.read(key: Constant.USER_ID);
    try {
      final value = await authRepo.joinApp(userID!,abcdUser,description);
      var responseData = value.body;
      debugPrint("===> responseData: $responseData");
      JoinData joinData = JoinData.fromJson(responseData);
      debugPrint("===> joinData: $joinData");
      debugPrint("===> joinData message: ${joinData.message}");
      debugPrint("===> joinData message: ${joinData.success}");
      if(joinData.success.toString() == 'true') {
        prefs.setString(Constant.JOIN_IS_TRUE, "true");
        joinIsTrue.value = 'true';
      } else {
        prefs.setString(Constant.JOIN_IS_TRUE, "false");
        joinIsTrue.value = 'false';
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Thanks For Showing Interest. We Will Call You For Further Process."),
        duration: Duration(seconds: 2),
        backgroundColor: kPurpleColor,
        behavior: SnackBarBehavior.floating, // Add this line
        margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
      ));
      callback(joinData.success.toString());
    } catch (e) {
      debugPrint("joinData errors: $e");
    }
  }

  Future<void> userDetailsAPI(
      userId,
      ) async {
    String? userID = await storeLocal.read(key: Constant.USER_ID);
    debugPrint("===> userID : $userID");
    try {
      final value = await authRepo.userDetails(userId);
      var responseData = value.body;
      UserDetail userDetail = UserDetail.fromJson(responseData);
      debugPrint("===> userDetails: $userDetail");
      debugPrint("===> userDetail message: ${userDetail.message}");
      if (userDetail.data != null && userDetail.data!.isNotEmpty) {
        work_days.value = userDetail.data![0].workedDays.toString();
        total_order.value = userDetail.data![0].totalOrders.toString();
        today_order.value = userDetail.data![0].totalOrders.toString();
        average_orders.value = userDetail.data![0].averageOrders.toString();
        balance_nextgen.value = userDetail.data![0].balance.toString();
        orders_cost.value = userDetail.data![0].ordersCost.toString();

        await storeLocal.write(key: Constant.ORDERAVAILABLE, value: userDetail.data![0].orderAvailable.toString());
        await storeLocal.write(key: Constant.WORK_DAYS, value: userDetail.data![0].workedDays.toString());
        await storeLocal.write(key: Constant.NAME, value: userDetail.data![0].name.toString());
        await storeLocal.write(key: Constant.MOBILE, value: userDetail.data![0].mobile.toString());
        await storeLocal.write(key: Constant.EMAIL, value: userDetail.data![0].email.toString());
        await storeLocal.write(key: Constant.CITY, value: userDetail.data![0].location.toString());
        await storeLocal.write(key: Constant.DOB, value: userDetail.data![0].dob.toString());
        await storeLocal.write(key: Constant.HR_ID, value: userDetail.data![0].hrId.toString());
        await storeLocal.write(key: Constant.ID, value: userDetail.data![0].id.toString());
        await storeLocal.write(key: Constant.AADHAAR_NUM, value: userDetail.data![0].aadhaarNum.toString());
        await storeLocal.write(key: Constant.REFER_BONUS, value: userDetail.data![0].referBonusSent.toString());
        await storeLocal.write(key: Constant.REFER_CODE, value: userDetail.data![0].referCode.toString());
        await storeLocal.write(key: Constant.EARN, value: userDetail.data![0].earn.toString());
        await storeLocal.write(key: Constant.BALANCE, value: userDetail.data![0].balance.toString());
        await storeLocal.write(key: Constant.MIN_WITHDRAWAL, value: userDetail.data![0].minWithdrawal.toString());
        await storeLocal.write(key: Constant.UPI, value: userDetail.data![0].upi.toString());
        await storeLocal.write(key: Constant.HOLDER_NAME, value: userDetail.data![0].holderName.toString());
        await storeLocal.write(key: Constant.ACCOUNT_NUM, value: userDetail.data![0].accountNum.toString());
        await storeLocal.write(key: Constant.IFSC, value: userDetail.data![0].ifsc.toString());
        await storeLocal.write(key: Constant.BANK, value: userDetail.data![0].bank.toString());
        await storeLocal.write(key: Constant.BRANCH, value: userDetail.data![0].branch.toString());
        await storeLocal.write(key: Constant.HIRING_EARNINGS, value: userDetail.data![0].hiringEarings.toString());
        await storeLocal.write(key: Constant.ORDERS_EARNINGS, value: userDetail.data![0].ordersEarnings.toString());
        await storeLocal.write(key: Constant.TOTAL_ORDER, value: userDetail.data![0].totalOrders.toString());
        await storeLocal.write(key: Constant.TODAY_ORDER, value: userDetail.data![0].todayOrders.toString());
        await storeLocal.write(key: Constant.AVERAGE_ORDER, value: userDetail.data![0].averageOrders.toString());
        await storeLocal.write(key: Constant.BALANCE_NEXTGEN, value: userDetail.data![0].balance.toString());
        await storeLocal.write(key: Constant.ORDER_COST, value: userDetail.data![0].ordersCost.toString());
        update();
      }
      update();
    } catch (e) {
      debugPrint("registerData errors: $e");
    }
  }
}
