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
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
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
    'assets/images/NextGen Job Details - 1.jpg',
    'assets/images/NextGen Job Details - 2.jpg',
    'assets/images/NextGen Job Details - 3.jpg',
    'assets/images/NextGen Job Details - 4.jpg',
    'assets/images/NextGen Job Details - 5.jpg',
    'assets/images/NextGen Job Details - 6.jpg',
    'assets/images/NextGen Job Details - 7.jpg',
    'assets/images/NextGen Job Details - 8.jpg',
    'assets/images/NextGen Job Details - 9.jpg',
    'assets/images/NextGen Job Details - 10.jpg',
    'assets/images/WhatsApp Image 2024-03-01 at 4.13.24 AM.jpeg',
    'assets/images/WhatsApp Image 2024-03-01 at 4.13.59 AM.jpeg',
    'assets/images/NextGen Job Details - 11.jpg',
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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZoomableImageGallery(
                        images: jobDetailImage,
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: Container(
                  width: size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(jobDetailImage[index])),
                ),
              );
            }),
      ),
    );
  }





  // late SharedPreferences prefs;
  // List<String> DeviceID = [];
  // String deviceID = '';
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   readData();
  //   initializeData();
  // }
  //
  // void initializeData() async {
  //   // SharedPreferences.getInstance().then((value) {
  //   //   prefs = value;
  //   //   //userDeatils();
  //   //   //String? userId = prefs.getString(Constant.ID);
  //   //   offer_image = prefs.getString(Constant.OFFER_IMAGE)!;
  //   //   //ads_status("status");
  //   // });
  //   prefs = await SharedPreferences.getInstance();
  //   deviceID = (await storeLocal.read(key: Constant.MY_DEVICE_ID)!)!;
  //   debugPrint("MyOffer deviceID: $deviceID");
  //   setState(() {});
  //   DeviceID.add(deviceID);
  //   prefs.setStringList("DeviceIDList", DeviceID);
  //   areLastTwoIdsEqual();
  //   bool lastTwoIdsEqual = areLastTwoIdsEqual();
  //   Get.snackbar("Equal", lastTwoIdsEqual == true ? 'Last Device ID is Equal' : 'Last Device ID is Not Equal',colorText: Colors.blue,backgroundColor: Colors.white);
  // }
  //
  // bool areLastTwoIdsEqual() {
  //   late bool isTrue;
  //
  //   // Retrieve the last two elements of the list
  //   String lastId = DeviceID[DeviceID.length - 1];
  //   String secondLastId = DeviceID[DeviceID.length - 2];
  //
  //   if (lastId == secondLastId) {
  //     isTrue = true;
  //     debugPrint("Equal");
  //   }else{
  //     isTrue = false;
  //     debugPrint("Not Equal");
  //   }
  //
  //   // Compare the last two elements
  //   return isTrue;
  // }
  //
  // void readData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   // Retrieve the list of device IDs
  //   List<String>? storedDeviceIDs = prefs.getStringList("DeviceIDList");
  //   debugPrint("storedDeviceIDs: $storedDeviceIDs");
  //
  //   if (storedDeviceIDs != null) {
  //     setState(() {
  //       DeviceID = storedDeviceIDs;
  //     });
  //   }
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //     body: Center(
  //       child: Container(
  //         height: size.height,
  //         width: size.width,
  //         decoration: const BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [colors.primary_color, colors.secondary_color],
  //             begin: Alignment.topCenter,
  //             end: Alignment.bottomCenter,
  //           ),
  //         ),
  //         padding: const EdgeInsets.all(20),
  //           child: ListView.builder(
  //             itemCount: DeviceID.length,
  //               itemBuilder: (context, index){
  //                 return Container(
  //                   color: Colors.white,
  //                   margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
  //                   padding: const EdgeInsets.all(10),
  //                   child: Text(
  //                       DeviceID[index],
  //                     style: const TextStyle(
  //                       color: Colors.black,
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 );
  //               }
  //           ),
  //       ),
  //     ),
  //   );
  // }

}

class ZoomableImageGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  ZoomableImageGallery({required this.images, required this.initialIndex});

  @override
  _ZoomableImageGalleryState createState() => _ZoomableImageGalleryState();
}

class _ZoomableImageGalleryState extends State<ZoomableImageGallery> {
  late int currentIndex;
  late PhotoViewController _controller;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = PhotoViewController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Close the gallery when tapped
            },
            child: PhotoViewGallery.builder(
              itemCount: widget.images.length,
              builder: (context, index) {
                return PhotoViewGalleryPageOptions(
                  imageProvider: AssetImage(widget.images[index]),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  controller: _controller,
                );
              },
              backgroundDecoration: const BoxDecoration(color: Colors.black),
              pageController: PageController(initialPage: widget.initialIndex),
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              enableRotation: true,
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.zoom_in,size: 24,color: Colors.white,),
              onPressed: () {
                _controller.scale = (_controller.scale! + 0.2)!; // Increase the scale for zoom in
              },
            ),
          ),
          Positioned(
            top: 20,
            left: 70,
            child: IconButton(
              icon: const Icon(Icons.zoom_out,size: 24,color: Colors.white,),
              onPressed: () {
                _controller.scale = (_controller.scale! - 0.2); // Decrease the scale for zoom out
              },
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.close,size: 24,color: Colors.white,),
              onPressed: () {
                Navigator.pop(context); // Close the gallery
              },
            ),
          ),
        ],
      ),
    );
  }
}


