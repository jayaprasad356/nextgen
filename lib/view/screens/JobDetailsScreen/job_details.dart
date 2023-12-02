import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:nextgen/Helper/apiCall.dart';
import 'package:nextgen/controller/full_time_page_con.dart';
import 'package:nextgen/controller/home_con.dart';
import 'package:nextgen/controller/home_con.dart';
import 'package:nextgen/model/slider_data.dart';
import 'package:nextgen/model/user.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/image_const.dart';
import 'package:nextgen/util/index.dart';
import 'package:nextgen/view/widget/default_back.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import 'package:slide_action/slide_action.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({Key? key}) : super(key: key);

  @override
  State<JobDetailScreen> createState() => JobDetailScreenState();
}

class JobDetailScreenState extends State<JobDetailScreen> {
  List<String> jobDetailImage = [
    'assets/images/job_detail_1.png',
    'assets/images/job_detail_2.png',
    'assets/images/job_detail_3.png',
    'assets/images/job_detail_4.png',
    'assets/images/job_detail_5.png',
    'assets/images/job_detail_6.png',
    'assets/images/job_detail_7.png',
    'assets/images/job_detail_8.png',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgLinear4,
      body: DefaultBack(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: jobDetailImage.length,
            itemBuilder: (context, index) {
              return Container(
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(jobDetailImage[index])),
              );
            }),
      ),
    );
  }
}
