import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/data/model/add_to_balance.dart';
import 'package:nextgen/data/model/transaction_mod.dart';
import 'package:nextgen/data/model/withdrawal_list_mod.dart';
import 'package:nextgen/data/model/withdrawal_mod.dart';
import 'package:nextgen/data/repository/update_bank_mod.dart';
import 'package:nextgen/data/repository/wallet_repo.dart';
import 'package:nextgen/model/transactionl_data.dart';
import 'package:nextgen/model/withdrawal_data.dart';
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
  RxString hiringEarnings = "".obs;
  RxString ordersEarnings = "".obs;

  RxList<TransactionData> transactionData = <TransactionData>[].obs;
  RxList<WithdrawalData> withdrawalsData = <WithdrawalData>[].obs;

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
    ordersEarnings.value = (await storeLocal.read(key: Constant.ORDERS_EARNINGS))!;
    hiringEarnings.value = (await storeLocal.read(key: Constant.HIRING_EARNINGS))!;
    // double earnAmount = double.parse(earn);
    // totalRefund = 'Total Refund = Rs. ${(earnAmount / 2).toStringAsFixed(2)}';
    debugPrint(
        "userId: $userId\nbalance: $balance\nminimum: $minimum\nupi: $upi\nmobile: $mobile_number\nearn: $earn\nname: $name\nmobile_number :$mobile_number");
    update();
  }

  Future<void> updateBankDetails(
      holder_name,
      bank_name, account_num, branch_area, ifsc_code
      ) async {
    try {
      final value = await walletRepo.updateBankDetails(userId.value.toString(), holder_name,
          bank_name, account_num, branch_area, ifsc_code);
      var responseData = value.body;
      BankDetailsUpdate bankDetailsUpdate = BankDetailsUpdate.fromJson(responseData);
      debugPrint("===> bankDetailsUpdate: $bankDetailsUpdate");
      debugPrint("===> bankDetailsUpdate message: ${bankDetailsUpdate.message}");
      debugPrint("===> bankDetailsUpdate message: ${bankDetailsUpdate.success}");
      Get.snackbar('Bank Details Update', bankDetailsUpdate.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);

      if (bankDetailsUpdate.data != null && bankDetailsUpdate.data!.isNotEmpty) {
        holderName.value = bankDetailsUpdate.data![0].holderName!;
        accountNum.value = bankDetailsUpdate.data![0].accountNum!;
        ifscCode.value = bankDetailsUpdate.data![0].ifsc!;
        bankName.value = bankDetailsUpdate.data![0].bank!;
        branch.value = bankDetailsUpdate.data![0].branch!;

        await storeLocal.delete(key: Constant.HOLDER_NAME);
        await storeLocal.delete(key: Constant.ACCOUNT_NUM);
        await storeLocal.delete(key: Constant.IFSC);
        await storeLocal.delete(key: Constant.BANK);
        await storeLocal.delete(key: Constant.BRANCH);

        await storeLocal.write(key: Constant.ORDERAVAILABLE, value: holderName.value);
        await storeLocal.write(key: Constant.WORK_DAYS, value: accountNum.value);
        await storeLocal.write(key: Constant.TOTAL_ORDER, value: ifscCode.value);
        await storeLocal.write(key: Constant.TODAY_ORDER, value: bankName.value);
        await storeLocal.write(key: Constant.AVERAGE_ORDER, value: branch.value);
      }

      update();
    } catch (e) {
      debugPrint("bankDetailsUpdate errors: $e");
    }
  }

  Future<void> doWithdrawal(
      amount,
      ) async {
    try {
      final value = await walletRepo.doWithdrawal(userId.value.toString(), amount);
      var responseData = value.body;
      WithdrawalMod withdrawalMod = WithdrawalMod.fromJson(responseData);
      debugPrint("===> withdrawalMod: $withdrawalMod");
      debugPrint("===> withdrawalMod message: ${withdrawalMod.message}");
      debugPrint("===> withdrawalMod message: ${withdrawalMod.success}");
      Get.snackbar('Withdrawal', withdrawalMod.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);

      update();
    } catch (e) {
      debugPrint("withdrawalMod errors: $e");
    }
  }

  Future<void> withdrawalList(
      ) async {
    try {
      final value = await walletRepo.withdrawalList(userId.value.toString());
      var responseData = value.body;
      WithdrawalListMod withdrawalListMod = WithdrawalListMod.fromJson(responseData);
      debugPrint("===> withdrawalListMod: $withdrawalListMod");
      debugPrint("===> withdrawalListMod message: ${withdrawalListMod.message}");
      debugPrint("===> withdrawalListMod message: ${withdrawalListMod.success}");

      withdrawalsData.clear();

      if (withdrawalListMod.data != null && withdrawalListMod.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var withdrawalList in withdrawalListMod.data!) {
          var withdrawalListId = withdrawalList.id!;
          var withdrawalListAmount = withdrawalList.amount!;
          var withdrawalListStatus = withdrawalList.status!;
          var withdrawalListDatetime = withdrawalList.datetime!;

          // Create a TransactionData object and add it to the list
          WithdrawalData data = WithdrawalData(
            withdrawalListId,
            withdrawalListAmount,
            withdrawalListStatus,
            withdrawalListDatetime,
          );

          withdrawalsData.add(data);
        }

        update();}
      update();
    } catch (e) {
      debugPrint("loginData errors: $e");
    }
  }

  Future<void> addToMainBalance(walletType) async {
    try {
      final value = await walletRepo.addToMainBalance(userId.value.toString(), walletType);
      var responseData = value.body;
      AddedToBalance addedToBalance = AddedToBalance.fromJson(responseData);
      debugPrint("===> addedToBalance: $addedToBalance");
      debugPrint("===> addedToBalance message: ${addedToBalance.message}");
      debugPrint("===> addedToBalance message: ${addedToBalance.success}");
      Get.snackbar('Balance', addedToBalance.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);

      update();
    } catch (e) {
      debugPrint("addedToBalance errors: $e");
    }
  }

  Future<void> transactionAPI() async {
    try {
      final value = await walletRepo.transactionAPI(userId.value.toString());
      var responseData = value.body;
      TransactionMod transactionMod = TransactionMod.fromJson(responseData);
      debugPrint("===> transactionType: $transactionMod");
      debugPrint("===> transactionMod message: ${transactionMod.message}");
      debugPrint("===> transactionMod message: ${transactionMod.success}");

      transactionData.clear();

      if (transactionMod.data != null && transactionMod.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var transaction in transactionMod.data!) {
          var transactionId = transaction.id!;
          var transactionAmount = transaction.amount!;
          var transactionOrders = transaction.orders!;
          var transactionDatetime = transaction.datetime!;
          var transactionType = transaction.type!;

          // Create a TransactionData object and add it to the list
          TransactionData data = TransactionData(
            transactionId,
            transactionAmount,
            transactionType,
            transactionDatetime,
            transactionOrders,
          );

          transactionData.add(data);
        }

      update();}
    } catch (e) {
      debugPrint("transactionType errors: $e");
    }
  }
}
