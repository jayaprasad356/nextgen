import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/controller/notification_con.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/view/widget/default_back.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/notification_data.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController notificationController =
      Get.find<NotificationController>();
  late List<NotificationData> notificationData = [];
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.notificationAPI();
  }

  // Future<List<NotificationData>> _getWithdrawalsData() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   Map<String, dynamic> bodyObject = {
  //     Constant.USER_ID: prefs.getString(Constant.ID)!,
  //   };
  //
  //   String response = await apiCall(Constant.NOTIFICATION_LIST_URL,bodyObject);
  //
  //   final jsonsData = jsonDecode(response);
  //   notificationData.clear();
  //
  //   for (var Data in jsonsData['data']) {
  //     final id = Data['id'];
  //     final title = Data["title"];
  //     final description = Data['description'];
  //     final link = Data['link'];
  //     final datetime = Data['datetime'];
  //
  //     NotificationData data = NotificationData(id, title, description,link, datetime);
  //     notificationData.add(data);
  //   }
  //   return notificationData;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgLinear4,
      body: DefaultBack(
        child:  Obx(
          () => ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: notificationController.notificationData.length,
            itemBuilder: (BuildContext context, int index) {
              return SingleChildScrollView(
                child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      color: colors.cc_velvet,
                      margin: const EdgeInsets.only(
                           bottom: 5, top: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notificationController.notificationData[index].title,
                              style: const TextStyle(
                                color: colors.white,
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 5),
                            // Adding some spacing between the two Text widgets
                            Text(
                              notificationController.notificationData[index].description,
                              style: const TextStyle(
                                color: colors.white,
                                fontFamily: 'Montserrat',
                                fontSize:
                                    10, // You can adjust the font size as needed
                              ),
                            ),
                            const SizedBox(height: 5),
                            (notificationController
                                .notificationData[index].link.isNotEmpty)
                              ? MaterialButton(
                                height: 25,
                                color: colors.primary,
                                onPressed: () {
                                  String uri = notificationController
                                      .notificationData[index].link;
                                  launchUrl(
                                    Uri.parse(uri),
                                    mode: LaunchMode.externalApplication,
                                  );
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text('Open',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: colors.white,
                                        fontFamily: "Montserra")),
                              ) : const SizedBox(),
                            SizedBox(height: (notificationController
                                .notificationData[index].link.isNotEmpty)
                                ? 5 : 0),
                            Text(
                              notificationController.notificationData[index].datetime,
                              style: const TextStyle(
                                color: colors.white,
                                fontFamily: 'Montserrat',
                                fontSize:
                                    10, // You can adjust the font size as needed
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              );
            },
          ),
        ),
      ),
    );
  }
}
