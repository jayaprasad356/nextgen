import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/util/Constant.dart';

class ProfileCon extends GetxController {
  RxString name = "".obs;
  RxString mobile_number = "".obs;
  RxString email = "".obs;
  RxString location = "".obs;
  RxString dob = "".obs;
  RxString hrId = "".obs;
  RxString aadhaarNum = "".obs;
  RxString referText = "".obs;
  RxString refer_bonus = "".obs;

  void handleAsyncInitMyProfile() async {
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
}