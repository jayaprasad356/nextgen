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
  late RxList notificationData = [].obs;

  Future<void> notificationAPI() async {
    try {
      final value = await notificationRepo.notificationAPI();
      var responseData = value.body;
      NotificationMod notificationMod = NotificationMod.fromJson(responseData);
      debugPrint("===> notificationMod: $notificationMod");
      debugPrint("===> notificationMod message: ${notificationMod.message}");

      for (var notification in notificationMod.data!) {
        // Extracting values from each notification
        String id = notification.id ?? '';
        String title = notification.title ?? '';
        String description = notification.description ?? '';
        String link = notification.link ?? '';
        String datetime = notification.datetime ?? '';

        notificationData.clear();

        // Creating a list of strings for each notification and adding it to notificationData
        List<String> notificationInfo = [id, title, description, link, datetime];
        notificationData.add(notificationInfo);
      }
    } catch (e) {
      debugPrint("notificationMod errors: $e");
    }
  }
}
