import 'package:intl/intl.dart';
import 'package:nextgen/controller/profile_con.dart';
import 'package:nextgen/controller/upi_controller.dart';
import 'package:nextgen/util/Color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/view/widget/date_textfield.dart';

class ApplyLeave extends StatefulWidget {
  const ApplyLeave({super.key});

  @override
  State<ApplyLeave> createState() => _ApplyLeaveState();
}

class _ApplyLeaveState extends State<ApplyLeave> {
  final ProfileCon profileCon = Get.find<ProfileCon>();
  // final UPIController upiController = Get.find<UPIController>();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  // late List leaveHistory = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileCon.applyLeaveList();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    // profileCon.applyLeaveList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colors.primary_color2,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [colors.primary_color, colors.primary_color2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Apply Leave",
          style: TextStyle(fontFamily: 'MontserratBold', color: colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: colors.white,
          ),
        ),
      ),
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              DateTextField(controller: dateController,color: kWhiteColor,borderColor: kPrimaryColor,startYear: 2024,endYear: 2075,),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: reasonController,
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Enter reason',
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.white60,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 1,
                      color: Colors.white60,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              MaterialButton(
                onPressed: () async {
                  DateTime today = DateTime.now().toLocal();
                  int date = int.parse(DateFormat('dd').format(today));
                  int month = int.parse(DateFormat('MM').format(today));
                  int year = int.parse(DateFormat('yyyy').format(today));
                  print("Today's date: $year/$month/$date");
                  if("$year/$month/$date" == dateController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Can't take leave today",
                        ),
                        duration: Duration(seconds: 2),
                        backgroundColor: kPurpleColor,
                        behavior: SnackBarBehavior.floating,
                        // Add this line
                        margin:
                            EdgeInsets.only(bottom: 10, left: 15, right: 15),
                      ),
                    );
                  } else {
                    debugPrint("dateController: ${dateController.text}\nreasonController.text: ${reasonController.text}");
                    profileCon.applyLeave(dateController.text, reasonController.text);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ApplyLeave()),
                    );
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  height: 40,
                  width: 140,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/btnbg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Apply',
                      style: TextStyle(
                          color: colors.white,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Confirmation',
                  style: TextStyle(
                      color: colors.white,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx( () => ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: profileCon.applyLeaveListData.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: colors.cc_velvet,
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profileCon.applyLeaveListData[index].date,
                            style: const TextStyle(
                                color: colors.white,
                                fontSize: 16,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            profileCon.applyLeaveListData[index].status == '1' ? 'Approval' : 'Not Approval',
                            style: TextStyle(
                                color: profileCon.applyLeaveListData[index].status == '1' ? Colors.green : Colors.redAccent,
                                fontSize: 18,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            profileCon.applyLeaveListData[index].reason,
                            style: const TextStyle(
                                color: colors.white,
                                fontSize: 14,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                ),),
              ),
              // FutureBuilder(
              //   future: null,
              //   builder:
              //       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              //     if (upiController.leaveHistory.isEmpty) {
              //       return const Center(
              //         child: Text(
              //           'Leave History is Empty',
              //           style: TextStyle(
              //               color: colors.white,
              //               fontSize: 14,
              //               fontFamily: "Montserrat",
              //               fontWeight: FontWeight.bold),
              //         ),
              //       );
              //     } else {
              //       return Expanded(
              //         child: ListView.builder(
              //           scrollDirection: Axis.vertical,
              //           itemCount: upiController.leaveHistory.length,
              //           physics: const BouncingScrollPhysics(),
              //           itemBuilder: (BuildContext context, int index) {
              //             return Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 color: colors.cc_velvet,
              //               ),
              //               margin: const EdgeInsets.only(bottom: 10),
              //               padding: const EdgeInsets.all(10),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(
              //                       upiController.leaveHistory[index].date,
              //                       style: const TextStyle(
              //                           color: colors.white,
              //                           fontSize: 16,
              //                           fontFamily: "Montserrat",
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   const Text(
              //                     'approval',
              //                     style: TextStyle(
              //                         color: Colors.green,
              //                         fontSize: 18,
              //                         fontFamily: "Montserrat",
              //                         fontWeight: FontWeight.bold),
              //                   ),
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   Text(
              //                       upiController.leaveHistory[index].reason,
              //                       style: const TextStyle(
              //                           color: colors.white,
              //                           fontSize: 14,
              //                           fontFamily: "Montserrat",
              //                           fontWeight: FontWeight.bold),
              //                     ),
              //                 ],
              //               ),
              //             );
              //           },
              //         ),
              //       );
              //     }
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
