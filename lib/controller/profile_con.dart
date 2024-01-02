import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/data/model/apply_leave.dart';
import 'package:nextgen/data/model/apply_leave_list_mod.dart';
import 'package:nextgen/data/model/update_profile_detail.dart';
import 'package:nextgen/data/repository/profile_repo.dart';
import 'package:nextgen/model/apply_leave_data.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileCon extends GetxController {
  final ProfileRepo profileRepo;
  ProfileCon({required this.profileRepo}) {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
  }

  late SharedPreferences prefs;
  RxString name = "".obs;
  RxString mobile_number = "".obs;
  RxString email = "".obs;
  RxString location = "".obs;
  RxString dob = "".obs;
  RxString hrId = "".obs;
  RxString aadhaarNum = "".obs;
  RxString referText = "".obs;
  RxString refer_bonus = "".obs;
  RxString userId = "".obs;

  RxList<ApplyLeaveListModData> applyLeaveListData =
      <ApplyLeaveListModData>[].obs;

  void handleAsyncInitMyProfile() async {
    userId.value = (await storeLocal.read(key: Constant.ID))!;
    name.value = (await storeLocal.read(key: Constant.NAME))!;
    mobile_number.value = (await storeLocal.read(key: Constant.MOBILE))!;
    email.value = (await storeLocal.read(key: Constant.EMAIL))!;
    location.value = (await storeLocal.read(key: Constant.CITY))!;
    dob.value = (await storeLocal.read(key: Constant.DOB))!;
    hrId.value = (await storeLocal.read(key: Constant.HR_ID))!;
    aadhaarNum.value = (await storeLocal.read(key: Constant.AADHAAR_NUM))!;
    referText.value = (await storeLocal.read(key: Constant.REFER_CODE))!;
    refer_bonus.value = (await storeLocal.read(key: Constant.REFER_BONUS))!;
    debugPrint("name: $name");
    debugPrint("mobile_number: $mobile_number");
    debugPrint("referText: $referText");
    debugPrint("refer_bonus: $refer_bonus");
    update();
  }

  Future<void> updateProfileDetails(
    userName,
    userMobile,
    // password,
    // deviceId,
    userEmail,
    userLocation,
    userDob,
    userHrId,
    userAadhaarNum,
  ) async {
    try {
      final value = await profileRepo.updateProfileDetails(
          userId.value.toString(),
          userName,
          userMobile,
          /*password,deviceId,*/ userEmail,
          userLocation,
          userDob,
          userHrId,
          userAadhaarNum);
      var responseData = value.body;
      UpdateProfileDetails updateProfileDetails =
          UpdateProfileDetails.fromJson(responseData);
      debugPrint("===> updateProfileDetails: $updateProfileDetails");
      debugPrint(
          "===> updateProfileDetails message: ${updateProfileDetails.message}");

      if (updateProfileDetails.data != null &&
          updateProfileDetails.data!.isNotEmpty) {
        name.value = updateProfileDetails.data![0].name.toString();
        mobile_number.value = updateProfileDetails.data![0].mobile.toString();
        email.value = updateProfileDetails.data![0].email.toString();
        location.value = updateProfileDetails.data![0].location.toString();
        dob.value = updateProfileDetails.data![0].dob.toString();
        hrId.value = updateProfileDetails.data![0].hrId.toString();
        aadhaarNum.value = updateProfileDetails.data![0].aadhaarNum.toString();

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

        await storeLocal.write(
            key: Constant.ORDERAVAILABLE,
            value: updateProfileDetails.data![0].orderAvailable.toString());
        await storeLocal.write(
            key: Constant.WORK_DAYS,
            value: updateProfileDetails.data![0].workedDays.toString());
        await storeLocal.write(
            key: Constant.NAME,
            value: updateProfileDetails.data![0].name.toString());
        await storeLocal.write(
            key: Constant.MOBILE,
            value: updateProfileDetails.data![0].mobile.toString());
        await storeLocal.write(
            key: Constant.EMAIL,
            value: updateProfileDetails.data![0].email.toString());
        await storeLocal.write(
            key: Constant.CITY,
            value: updateProfileDetails.data![0].location.toString());
        await storeLocal.write(
            key: Constant.DOB,
            value: updateProfileDetails.data![0].dob.toString());
        await storeLocal.write(
            key: Constant.HR_ID,
            value: updateProfileDetails.data![0].hrId.toString());
        await storeLocal.write(
            key: Constant.ID,
            value: updateProfileDetails.data![0].id.toString());
        await storeLocal.write(
            key: Constant.AADHAAR_NUM,
            value: updateProfileDetails.data![0].aadhaarNum.toString());
        await storeLocal.write(
            key: Constant.REFER_BONUS,
            value: updateProfileDetails.data![0].referBonusSent.toString());
        await storeLocal.write(
            key: Constant.REFER_CODE,
            value: updateProfileDetails.data![0].referCode.toString());
        await storeLocal.write(
            key: Constant.EARN,
            value: updateProfileDetails.data![0].earn.toString());
        await storeLocal.write(
            key: Constant.BALANCE,
            value: updateProfileDetails.data![0].balance.toString());
        await storeLocal.write(
            key: Constant.MIN_WITHDRAWAL,
            value: updateProfileDetails.data![0].minWithdrawal.toString());
        await storeLocal.write(
            key: Constant.HOLDER_NAME,
            value: updateProfileDetails.data![0].holderName.toString());
        await storeLocal.write(
            key: Constant.ACCOUNT_NUM,
            value: updateProfileDetails.data![0].accountNum.toString());
        await storeLocal.write(
            key: Constant.IFSC,
            value: updateProfileDetails.data![0].ifsc.toString());
        await storeLocal.write(
            key: Constant.BANK,
            value: updateProfileDetails.data![0].bank.toString());
        await storeLocal.write(
            key: Constant.BRANCH,
            value: updateProfileDetails.data![0].branch.toString());
        await storeLocal.write(
            key: Constant.HIRING_EARNINGS,
            value: updateProfileDetails.data![0].hiringEarings.toString());
        await storeLocal.write(
            key: Constant.ORDERS_EARNINGS,
            value: updateProfileDetails.data![0].ordersEarnings.toString());
        await storeLocal.write(
            key: Constant.TOTAL_ORDER,
            value: updateProfileDetails.data![0].totalOrders.toString());
        await storeLocal.write(
            key: Constant.TODAY_ORDER,
            value: updateProfileDetails.data![0].todayOrders.toString());
        await storeLocal.write(
            key: Constant.AVERAGE_ORDER,
            value: updateProfileDetails.data![0].averageOrders.toString());
        await storeLocal.write(
            key: Constant.BALANCE_NEXTGEN,
            value: updateProfileDetails.data![0].balance.toString());
        update();
      }

      Get.snackbar(
        "Update Profile",
        updateProfileDetails.message.toString(),
        colorText: kPrimaryColor,
        backgroundColor: kWhiteColor,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      debugPrint("registerData errors: $e");
    }
  }

  Future<void> applyLeave(
    leaveDate,
    reason,
  ) async {
    try {
      final value = await profileRepo.applyLeave(
          userId.value.toString(), leaveDate, reason);
      var responseData = value.body;
      ApplyLeave applyLeave = ApplyLeave.fromJson(responseData);
      debugPrint("===> applyLeave: $applyLeave");
      debugPrint("===> applyLeave message: ${applyLeave.message}");

      Get.snackbar(
        "Apply Leave",
        applyLeave.message.toString(),
        colorText: kPrimaryColor,
        backgroundColor: kWhiteColor,
        duration: const Duration(seconds: 3),
      );

      if (applyLeave.success == 'true') {
        applyLeaveList();
        update();
      }
    } catch (e) {
      debugPrint("registerData errors: $e");
    }
  }

  Future<void> applyLeaveList() async {
    try {
      final value = await profileRepo.applyLeaveList(userId.value.toString());
      var responseData = value.body;
      ApplyLeaveListMod applyLeaveListMod =
          ApplyLeaveListMod.fromJson(responseData);
      debugPrint("===> applyLeaveListMod: $applyLeaveListMod");
      debugPrint(
          "===> applyLeaveListMod message: ${applyLeaveListMod.message}");

      applyLeaveListData.clear();

      if (applyLeaveListMod.data != null &&
          applyLeaveListMod.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var applyLeaveList in applyLeaveListMod.data!) {
          var applyLeaveDataId = applyLeaveList.id!;
          var applyLeaveDataDate = applyLeaveList.date!;
          var applyLeaveDataType = applyLeaveList.type!;
          var applyLeaveDataReason = applyLeaveList.reason!;
          var applyLeaveDataStatus = applyLeaveList.status!;

          // Create a NotificationData object and add it to the list
          ApplyLeaveListModData data = ApplyLeaveListModData(
            applyLeaveDataId,
            applyLeaveDataDate,
            applyLeaveDataType,
            applyLeaveDataReason,
            applyLeaveDataStatus,
          );

          applyLeaveListData.add(data);
        }

        update();
      }
    } catch (e) {
      debugPrint("applyLeaveListMod errors: $e");
    }
  }
}
