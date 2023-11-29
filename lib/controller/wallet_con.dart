import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/data/repository/update_bank_mod.dart';
import 'package:nextgen/data/repository/wallet_repo.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletCon extends GetxController {
  final WalletRepo walletRepo;
  WalletCon({required this.walletRepo}){
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }

  late SharedPreferences prefs;
  RxString name = "".obs;
  RxString mobile_number = "".obs;
  RxString balance = "".obs;
  RxString minimum = "".obs;
  RxString mobile = "".obs;
  RxString earn = "".obs;
  RxString upi = "".obs;
  RxString userId = "".obs;
  RxString holderName = "".obs;
  RxString accountNum = "".obs;
  RxString ifscCode = "".obs;
  RxString bankName = "".obs;
  RxString branch = "".obs;
  RxString basicWallet = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    handleAsyncInit();
  }

  void handleAsyncInit() async {
    debugPrint(
        "balance: $balance\nminimum: $minimum\nupi: $upi\nmobile: $mobile\nearn: $earn\nname: $name");
    balance.value = (await storeLocal.read(key: Constant.BALANCE))!;
    minimum.value = (await storeLocal.read(key: Constant.MIN_WITHDRAWAL))!;
    mobile.value = (await storeLocal.read(key: Constant.MOBILE))!;
    earn.value = (await storeLocal.read(key: Constant.EARN))!;
    name.value = (await storeLocal.read(key: Constant.NAME))!;
    upi.value = (await storeLocal.read(key: Constant.UPI))!;
    userId.value = (await storeLocal.read(key: Constant.USER_ID))!;
    holderName.value = (await storeLocal.read(key: Constant.HOLDER_NAME))!;
    accountNum.value = (await storeLocal.read(key: Constant.ACCOUNT_NUM))!;
    ifscCode.value = (await storeLocal.read(key: Constant.IFSC))!;
    bankName.value = (await storeLocal.read(key: Constant.BANK))!;
    branch.value = (await storeLocal.read(key: Constant.BRANCH))!;
    // double earnAmount = double.parse(earn);
    // totalRefund = 'Total Refund = Rs. ${(earnAmount / 2).toStringAsFixed(2)}';
    debugPrint(
        "userId: $userId\nbalance: $balance\nminimum: $minimum\nupi: $upi\nmobile: $mobile_number\nearn: $earn\nname: $name\nmobile_number :$mobile_number");
    update();
  }

  Future<void> updateBankDetails(
      holderName,
      bank, accountNum, branch, ifsc
      ) async {
    try {
      final value = await walletRepo.updateBankDetails(userId.value.toString(), holderName,
          bank, accountNum, branch, ifsc);
      var responseData = value.body;
      BankDetailsUpdate bankDetailsUpdate = BankDetailsUpdate.fromJson(responseData);
      debugPrint("===> bankDetailsUpdate: $bankDetailsUpdate");
      debugPrint("===> bankDetailsUpdate message: ${bankDetailsUpdate.message}");
      debugPrint("===> bankDetailsUpdate message: ${bankDetailsUpdate.success}");
      Get.snackbar('Sign In', bankDetailsUpdate.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);

      update();
    } catch (e) {
      debugPrint("loginData errors: $e");
    }
  }

  Future<void> doWithdrawal(
      amount,
      ) async {
    try {
      final value = await walletRepo.doWithdrawal(userId.value.toString(), amount);
      var responseData = value.body;
      BankDetailsUpdate bankDetailsUpdate = BankDetailsUpdate.fromJson(responseData);
      debugPrint("===> bankDetailsUpdate: $bankDetailsUpdate");
      debugPrint("===> bankDetailsUpdate message: ${bankDetailsUpdate.message}");
      debugPrint("===> bankDetailsUpdate message: ${bankDetailsUpdate.success}");
      Get.snackbar('Sign In', bankDetailsUpdate.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);

      update();
    } catch (e) {
      debugPrint("loginData errors: $e");
    }
  }
}
