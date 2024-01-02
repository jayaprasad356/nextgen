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
      context,
      amount,
      ) async {
    try {
      showLoadingIndicator(context);

      await Future.delayed(const Duration(seconds: 5));
      final value = await walletRepo.doWithdrawal(userId.value.toString(), amount);
      var responseData = value.body;
      WithdrawalMod withdrawalMod = WithdrawalMod.fromJson(responseData);
      debugPrint("===> withdrawalMod: $withdrawalMod");
      debugPrint("===> withdrawalMod message: ${withdrawalMod.message}");
      debugPrint("===> withdrawalMod message: ${withdrawalMod.success}");

      if (withdrawalMod.data != null && withdrawalMod.data!.withdrawals!.isNotEmpty && withdrawalMod.data!.withdrawals!.isNotEmpty) {

        await storeLocal.delete(key: Constant.ORDERAVAILABLE);
        await storeLocal.delete(key: Constant.WORK_DAYS);
        await storeLocal.delete(key: Constant.NAME);
        await storeLocal.delete(key: Constant.MOBILE);
        await storeLocal.delete(key: Constant.EMAIL);
        await storeLocal.delete(key: Constant.CITY);
        await storeLocal.delete(key: Constant.DOB);
        await storeLocal.delete(key: Constant.HR_ID);
        await storeLocal.delete(key: Constant.ID);
        await storeLocal.delete(key: Constant.AADHAAR_NUM);
        await storeLocal.delete(key: Constant.REFER_BONUS);
        await storeLocal.delete(key: Constant.REFER_CODE);
        await storeLocal.delete(key: Constant.EARN);
        await storeLocal.delete(key: Constant.BALANCE);
        await storeLocal.delete(key: Constant.MIN_WITHDRAWAL);
        await storeLocal.delete(key: Constant.HOLDER_NAME);
        await storeLocal.delete(key: Constant.ACCOUNT_NUM);
        await storeLocal.delete(key: Constant.IFSC);
        await storeLocal.delete(key: Constant.BANK);
        await storeLocal.delete(key: Constant.BRANCH);
        await storeLocal.delete(key: Constant.HIRING_EARNINGS);
        await storeLocal.delete(key: Constant.ORDERS_EARNINGS);
        await storeLocal.delete(key: Constant.TOTAL_ORDER);
        await storeLocal.delete(key: Constant.TODAY_ORDER);
        await storeLocal.delete(key: Constant.AVERAGE_ORDER);
        await storeLocal.delete(key: Constant.BALANCE_NEXTGEN);

        await storeLocal.write(key: Constant.ORDERAVAILABLE, value: withdrawalMod.data!.userDetails![0].orderAvailable.toString());
        await storeLocal.write(key: Constant.WORK_DAYS, value: withdrawalMod.data!.userDetails![0].workedDays.toString());
        await storeLocal.write(key: Constant.NAME, value: withdrawalMod.data!.userDetails![0].name.toString());
        await storeLocal.write(key: Constant.MOBILE, value: withdrawalMod.data!.userDetails![0].mobile.toString());
        await storeLocal.write(key: Constant.EMAIL, value: withdrawalMod.data!.userDetails![0].email.toString());
        await storeLocal.write(key: Constant.CITY, value: withdrawalMod.data!.userDetails![0].location.toString());
        await storeLocal.write(key: Constant.DOB, value: withdrawalMod.data!.userDetails![0].dob.toString());
        await storeLocal.write(key: Constant.HR_ID, value: withdrawalMod.data!.userDetails![0].hrId.toString());
        await storeLocal.write(key: Constant.ID, value: withdrawalMod.data!.userDetails![0].id.toString());
        await storeLocal.write(key: Constant.AADHAAR_NUM, value: withdrawalMod.data!.userDetails![0].aadhaarNum.toString());
        await storeLocal.write(key: Constant.REFER_BONUS, value: withdrawalMod.data!.userDetails![0].referBonusSent.toString());
        await storeLocal.write(key: Constant.REFER_CODE, value: withdrawalMod.data!.userDetails![0].referCode.toString());
        await storeLocal.write(key: Constant.EARN, value: withdrawalMod.data!.userDetails![0].earn.toString());
        await storeLocal.write(key: Constant.BALANCE, value: withdrawalMod.data!.userDetails![0].balance.toString());
        await storeLocal.write(key: Constant.MIN_WITHDRAWAL, value: withdrawalMod.data!.userDetails![0].minWithdrawal.toString());
        await storeLocal.write(key: Constant.HOLDER_NAME, value: withdrawalMod.data!.userDetails![0].holderName.toString());
        await storeLocal.write(key: Constant.ACCOUNT_NUM, value: withdrawalMod.data!.userDetails![0].accountNum.toString());
        await storeLocal.write(key: Constant.IFSC, value: withdrawalMod.data!.userDetails![0].ifsc.toString());
        await storeLocal.write(key: Constant.BANK, value: withdrawalMod.data!.userDetails![0].bank.toString());
        await storeLocal.write(key: Constant.BRANCH, value: withdrawalMod.data!.userDetails![0].branch.toString());
        await storeLocal.write(key: Constant.HIRING_EARNINGS, value: withdrawalMod.data!.userDetails![0].hiringEarings.toString());
        await storeLocal.write(key: Constant.ORDERS_EARNINGS, value: withdrawalMod.data!.userDetails![0].ordersEarnings.toString());
        await storeLocal.write(key: Constant.TOTAL_ORDER, value: withdrawalMod.data!.userDetails![0].totalOrders.toString());
        await storeLocal.write(key: Constant.TODAY_ORDER, value: withdrawalMod.data!.userDetails![0].todayOrders.toString());
        await storeLocal.write(key: Constant.AVERAGE_ORDER, value: withdrawalMod.data!.userDetails![0].averageOrders.toString());
        await storeLocal.write(key: Constant.BALANCE_NEXTGEN, value: withdrawalMod.data!.userDetails![0].balance.toString());
        update();

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
        update();
      }

      Get.snackbar('Withdrawal', withdrawalMod.message.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);

      update();
      hideLoadingIndicator(context);
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

      if (addedToBalance.data != null && addedToBalance.data!.isNotEmpty) {

        await storeLocal.delete(key: Constant.ORDERAVAILABLE);
        await storeLocal.delete(key: Constant.WORK_DAYS);
        await storeLocal.delete(key: Constant.NAME);
        await storeLocal.delete(key: Constant.MOBILE);
        await storeLocal.delete(key: Constant.EMAIL);
        await storeLocal.delete(key: Constant.CITY);
        await storeLocal.delete(key: Constant.DOB);
        await storeLocal.delete(key: Constant.HR_ID);
        await storeLocal.delete(key: Constant.ID);
        await storeLocal.delete(key: Constant.AADHAAR_NUM);
        await storeLocal.delete(key: Constant.REFER_BONUS);
        await storeLocal.delete(key: Constant.REFER_CODE);
        await storeLocal.delete(key: Constant.EARN);
        await storeLocal.delete(key: Constant.BALANCE);
        await storeLocal.delete(key: Constant.MIN_WITHDRAWAL);
        await storeLocal.delete(key: Constant.UPI);
        await storeLocal.delete(key: Constant.HOLDER_NAME);
        await storeLocal.delete(key: Constant.ACCOUNT_NUM);
        await storeLocal.delete(key: Constant.IFSC);
        await storeLocal.delete(key: Constant.BANK);
        await storeLocal.delete(key: Constant.BRANCH);
        await storeLocal.delete(key: Constant.HIRING_EARNINGS);
        await storeLocal.delete(key: Constant.ORDERS_EARNINGS);
        await storeLocal.delete(key: Constant.TOTAL_ORDER);
        await storeLocal.delete(key: Constant.TODAY_ORDER);
        await storeLocal.delete(key: Constant.AVERAGE_ORDER);
        await storeLocal.delete(key: Constant.BALANCE_NEXTGEN);

        await storeLocal.write(key: Constant.ORDERAVAILABLE, value: addedToBalance.data![0].orderAvailable.toString());
        await storeLocal.write(key: Constant.WORK_DAYS, value: addedToBalance.data![0].workedDays.toString());
        await storeLocal.write(key: Constant.NAME, value: addedToBalance.data![0].name.toString());
        await storeLocal.write(key: Constant.MOBILE, value: addedToBalance.data![0].mobile.toString());
        await storeLocal.write(key: Constant.EMAIL, value: addedToBalance.data![0].email.toString());
        await storeLocal.write(key: Constant.CITY, value: addedToBalance.data![0].location.toString());
        await storeLocal.write(key: Constant.DOB, value: addedToBalance.data![0].dob.toString());
        await storeLocal.write(key: Constant.HR_ID, value: addedToBalance.data![0].hrId.toString());
        await storeLocal.write(key: Constant.ID, value: addedToBalance.data![0].id.toString());
        await storeLocal.write(key: Constant.AADHAAR_NUM, value: addedToBalance.data![0].aadhaarNum.toString());
        await storeLocal.write(key: Constant.REFER_BONUS, value: addedToBalance.data![0].referBonusSent.toString());
        await storeLocal.write(key: Constant.REFER_CODE, value: addedToBalance.data![0].referCode.toString());
        await storeLocal.write(key: Constant.EARN, value: addedToBalance.data![0].earn.toString());
        await storeLocal.write(key: Constant.BALANCE, value: addedToBalance.data![0].balance.toString());
        await storeLocal.write(key: Constant.MIN_WITHDRAWAL, value: addedToBalance.data![0].minWithdrawal.toString());
        await storeLocal.write(key: Constant.UPI, value: addedToBalance.data![0].upi.toString());
        await storeLocal.write(key: Constant.HOLDER_NAME, value: addedToBalance.data![0].holderName.toString());
        await storeLocal.write(key: Constant.ACCOUNT_NUM, value: addedToBalance.data![0].accountNum.toString());
        await storeLocal.write(key: Constant.IFSC, value: addedToBalance.data![0].ifsc.toString());
        await storeLocal.write(key: Constant.BANK, value: addedToBalance.data![0].bank.toString());
        await storeLocal.write(key: Constant.BRANCH, value: addedToBalance.data![0].branch.toString());
        await storeLocal.write(key: Constant.HIRING_EARNINGS, value: addedToBalance.data![0].hiringEarings.toString());
        await storeLocal.write(key: Constant.ORDERS_EARNINGS, value: addedToBalance.data![0].ordersEarnings.toString());
        await storeLocal.write(key: Constant.TOTAL_ORDER, value: addedToBalance.data![0].totalOrders.toString());
        await storeLocal.write(key: Constant.TODAY_ORDER, value: addedToBalance.data![0].todayOrders.toString());
        await storeLocal.write(key: Constant.AVERAGE_ORDER, value: addedToBalance.data![0].averageOrders.toString());
        await storeLocal.write(key: Constant.BALANCE_NEXTGEN, value: addedToBalance.data![0].balance.toString());
        update();

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
        update();
      }

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

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text('Loading...'),
            ],
          ),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }
}
