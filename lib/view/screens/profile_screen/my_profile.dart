import 'dart:async';

import 'package:nextgen/controller/home_con.dart';
import 'package:nextgen/controller/profile_con.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/model/jobs_show.dart';
import 'package:nextgen/reports.dart';
import 'package:nextgen/util/Color.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/view/screens/profile_screen/update_profile_screen.dart';
import 'package:nextgen/view/screens/upi_screen/apply_leave.dart';
import 'package:nextgen/view/screens/upi_screen/marketing_leads.dart';
import 'package:nextgen/view/screens/upi_screen/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // final HomeController homeController = Get.find<HomeController>();
  final ProfileCon profileCon = Get.find<ProfileCon>();

  @override
  void initState() {
    super.initState();
    profileCon.handleAsyncInitMyProfile();
  }

  // void handleAsyncInit() async {
  //   setState(() async {
  //     name = (await storeLocal.read(key: Constant.NAME))!;
  //     mobile_number = (await storeLocal.read(key: Constant.MOBILE))!;
  //     referText = (await storeLocal.read(key: Constant.REFER_CODE))!;
  //     refer_bonus = (await storeLocal.read(key: Constant.REFER_BONUS))!;
  //     debugPrint("name: $name");
  //     debugPrint("mobile_number: $mobile_number");
  //     debugPrint("referText: $referText");
  //     debugPrint("refer_bonus: $refer_bonus");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.secondary_color,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context)
              .size
              .width, // Set width to the screen width
          height: MediaQuery.of(context)
              .size
              .height, // Set height to the screen height
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.secondary_color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          // padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                color: colors.cc_velvet,
                margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                child: Card(
                  child: Container(
                    color: colors.cc_velvet,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            "Hire (Refer) Candidate Get ₹ 500\nIncentives + 500 Orders ₹ 100\n= Total ₹ 600.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Obx(
                                () => OutlinedButton(
                                  onPressed: () {
                                    Utils().showToast("Copied !");
                                    Clipboard.setData(ClipboardData(
                                        text: profileCon.referText.toString()));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      side: const BorderSide(color: colors.red),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 11),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Image.asset(
                                          "assets/images/copy.png",
                                          width: 24.0,
                                          height: 24.0,
                                        ),
                                        const SizedBox(width: 8.0),
                                        Text(
                                            profileCon.referText.toString(),
                                            style: const TextStyle(
                                              color: colors.primary,
                                              fontSize: 12.0,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              MaterialButton(
                                onPressed: () {
                                  Share.share("${profileCon.referText}\nUse my Refer Code and Login to our website ${Constant.NEXTGET_WEB_LINK}");
                                },
                                color: colors.primary_color,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: 14.0,
                                  ),
                                  child: Text(
                                    'Refer Friends',
                                    style: TextStyle(
                                      color: colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(1000),
                        gradient: const LinearGradient(
                          colors: [
                            colors.primary_color,
                            colors.secondary_color
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            profileCon.name.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Obx(
                          () => Text(
                            profileCon.mobile_number.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    Column(
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProfileScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colors.primary,
                            ),
                            alignment: Alignment.center,
                            child: const Text('Update Profile',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colors.white,
                                    fontFamily: "Montserra")),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            Get.to(const ApplyLeave());
                          },
                          child: Container(
                            height: 30,
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: colors.primary,
                            ),
                            alignment: Alignment.center,
                            child: const Text('Apply Leave',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colors.white,
                                    fontFamily: "Montserra")),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Divider(color: Colors.white70, thickness: 1.5),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () => Get.to(const wallet()),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: ImageIcon(
                          AssetImage("assets/images/Wallet.png"),
                          color: colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Wallet",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 15,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 15),
              //   child: InkWell(
              //     onTap: () => Get.to(const MarketingLeads()),
              //     child: const Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Padding(
              //           padding: EdgeInsets.only(right: 10, left: 10),
              //           child: ImageIcon(
              //             AssetImage("assets/images/download-removebg-preview11.png"),
              //             color: colors.white,
              //           ),
              //         ),
              //         SizedBox(
              //           width: 15,
              //         ),
              //         Text(
              //           "Marketing Leads",
              //           textAlign: TextAlign.start,
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 20,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () => Get.to(const report()),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: ImageIcon(
                          AssetImage("assets/images/result.png"),
                          color: colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Transaction",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
