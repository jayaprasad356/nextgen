import 'dart:async';
import 'dart:html';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:nextgen/data/model/notification_mod.dart';
import 'package:nextgen/data/model/sync_data_nextget.dart';
import 'package:nextgen/data/repository/full_time_repo.dart';
import 'package:nextgen/data/repository/home_repo.dart';
import 'package:nextgen/data/repository/notification_repo.dart';
import 'package:nextgen/data/repository/work_repo.dart';
import 'package:nextgen/model/notification_data.dart';
import 'package:nextgen/model/sync_data_list.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/dimensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});
  late SharedPreferences prefs;
  RxList<NotificationData> notificationData = <NotificationData>[].obs;

  Future<void> notificationAPI() async {
    try {
      final value = await notificationRepo.notificationAPI();
      var responseData = value.body;
      NotificationMod notificationMod = NotificationMod.fromJson(responseData);
      debugPrint("===> notificationMod: $notificationMod");
      debugPrint("===> notificationMod message: ${notificationMod.message}");

      notificationData.clear();

      if (notificationMod.data != null && notificationMod.data!.isNotEmpty) {
        // Use a loop if there can be multiple transactions
        for (var notification in notificationMod.data!) {
          var notificationId = notification.id!;
          var notificationTitle = notification.title!;
          var notificationDescription = notification.description!;
          var notificationLink = notification.link!;
          var notificationDatetime = notification.datetime!;

          // Create a NotificationData object and add it to the list
          NotificationData data = NotificationData(
            notificationId,
            notificationTitle,
            notificationDescription,
            notificationLink,
            notificationDatetime,
          );

          notificationData.add(data);
        }

        update();}
    } catch (e) {
      debugPrint("notificationMod errors: $e");
    }
  }
}
