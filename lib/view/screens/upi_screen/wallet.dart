import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/controller/wallet_con.dart';
import 'package:nextgen/model/user.dart';
import 'package:nextgen/controller/utils.dart';
import 'package:nextgen/view/screens/profile_screen/update_profile_screen.dart';
import 'package:nextgen/view/screens/upi_screen/my_withdrawal_records.dart';
import 'package:nextgen/view/screens/upi_screen/verify_ads.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../util/Color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'bank_detail_screen.dart';

class wallet extends StatefulWidget {
  const wallet({Key? key}) : super(key: key);

  @override
  State<wallet> createState() => _walletState();
}

class _walletState extends State<wallet> {
  final WalletCon walletCon = Get.find<WalletCon>();
  final AuthCon authCon = Get.find<AuthCon>();
  final TextEditingController _withdrawalAmtController =
      TextEditingController();
  TextEditingController _upiIdController = TextEditingController();
  Utils utils = Utils();
  late SharedPreferences prefs;
  String balance = "";
  String minimum = "";
  String name = "";
  String mobile = "";
  String earn = "0.00";
  // String ordersEarnings = "0.00";
  // String hiringEarnings = "0.00";

  late String _upiId;
  late String _fcmToken;
  late String totalRefund = '';

  @override
  void initState() {
    // TODO: implement initState
    walletCon.handleAsyncInit();
    _upiIdController.text = walletCon.upi.toString();
    // SharedPreferences.getInstance().then((value) {
    //   prefs = value;
    //   setState(() {
    //     balance = prefs.getString(Constant.BALANCE)!;
    //     minimum = prefs.getString(Constant.MIN_WITHDRAWAL)!;
    //     _upiIdController.text = prefs.getString(Constant.UPI)!;
    //     mobile = prefs.getString(Constant.MOBILE).toString();
    //     earn = prefs.getString(Constant.EARN).toString();
    //     name = prefs.getString(Constant.NAME).toString();
    //     double earnAmount = double.parse(earn);
    //     totalRefund =
    //         'Total Refund = Rs. ${(earnAmount / 2).toStringAsFixed(2)}';
    //   });
    // });
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    walletCon.handleAsyncInit();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool _isDisabled = true;
    return Scaffold(
      backgroundColor: colors.secondary_color,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.primary_color,
                colors.primary_color2
              ], // Change these colors to your desired gradient colors
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: const Text(
          "Wallet",
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
        actions: [                    Padding(
          padding: const EdgeInsets.only(right: 20),
          child: MaterialButton(
            color: colors.primary,
            onPressed: () {
              // Navigate to the BankDetailsScreen when the button is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BankDetailsScreen(),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text('Update Bank Detail',
                style: TextStyle(
                    fontSize: 14,
                    color: colors.white,
                    fontFamily: "Montserra")),
          ),
        ),],
      ),
      body: Container(
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: const Color(0xFF060A70),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.widget_color, // Set the border color
                          width: 2, // Set the border width
                        ),
                        borderRadius:
                            BorderRadius.circular(50), // Set border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(
                              () => Text(
                                walletCon.name.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => Text(
                                walletCon.mobile.toString(),
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => Text(
                                "Total Earnings - ₹${walletCon.earn.toString()}",
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    color: const Color(0xFF060A70),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.widget_color, // Set the border color
                          width: 2, // Set the border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Order Earning",
                              style: GoogleFonts.poppins(
                                // Use GoogleFonts.poppins() to access Poppins font
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   "No Refers",
                            //   style: GoogleFonts.poppins(
                            //     // Use GoogleFonts.poppins() to access Poppins font
                            //     fontSize: 12,
                            //     color: Colors.white,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              color: const Color(0xFF060A70),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colors
                                        .widget_color2, // Set the border color
                                    width: 2, // Set the border width
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                  color: const Color(0xFF080A42),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/money.png',
                                        height: 30,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Adding some spacing between image and text
                                      Obx(
                                        () => Text(
                                          "₹ ${walletCon.ordersEarnings}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                authCon.showLoadingIndicator(context);
                                await Future.delayed(const Duration(seconds: 5));
                                walletCon.addToMainBalance('orders_earnings');
                                authCon.hideLoadingIndicator(context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/main_balance_btn.png',
                                    height: 50,
                                    width:
                                        120, // Replace with the actual image path
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: const Color(0xFF060A70),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: colors.widget_color, // Set the border color
                          width: 2, // Set the border width
                        ),
                        borderRadius:
                            BorderRadius.circular(8), // Set border radius
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 3.0, left: 5.0, right: 5.0, bottom: 3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     Text(
                            //       "Premium Wallet",
                            //       style: GoogleFonts.poppins(
                            //         // Use GoogleFonts.poppins() to access Poppins font
                            //         fontSize: 14,
                            //         color: colors.widget_color,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     const SizedBox(width: 5),
                            //     GestureDetector(
                            //       onTap: () {
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //             const OnlineJobs(),
                            //           ),
                            //         );
                            //       },
                            //       child: Image.asset(
                            //         'assets/images/info.png',
                            //         height: 30,
                            //         width: 20,
                            //       ),
                            //     )
                            //   ],
                            // ),
                            Text(
                              "Hiring Earning",
                              style: GoogleFonts.poppins(
                                // Use GoogleFonts.poppins() to access Poppins font
                                fontSize: 14,
                                color: colors.widget_color,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Text(
                            //   "$target_refers Refers",
                            //   style: GoogleFonts.poppins(
                            //     // Use GoogleFonts.poppins() to access Poppins font
                            //     fontSize: 12,
                            //     color: colors.widget_color,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Card(
                              color: const Color(0xFF060A70),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: colors
                                        .widget_color2, // Set the border color
                                    width: 2, // Set the border width
                                  ),
                                  borderRadius: BorderRadius.circular(35),
                                  color: const Color(0xFF080A42),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3.0,
                                      left: 20.0,
                                      right: 20.0,
                                      bottom: 3.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/money.png',
                                        height: 30,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                          width:
                                              5), // Adding some spacing between image and text
                                      Obx(
                                        () => Text(
                                          "₹ ${walletCon.hiringEarnings}",
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            MaterialButton(
                              onPressed: () async {
                                authCon.showLoadingIndicator(context);
                              await Future.delayed(const Duration(seconds: 5));
                                walletCon.addToMainBalance('hiring_earnings');
                                authCon.hideLoadingIndicator(context);
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/main_balance_btn.png',
                                    height: 50,
                                    width:
                                        120, // Replace with the actual image path
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Main Balance",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colors.white),
              ),
              const SizedBox(height: 5),
              Card(
                color: const Color(0xFF060A70),
                child: Container(
                  width: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: colors.widget_color2, // Set the border color
                      width: 2, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(35),
                    color: const Color(0xFF080A42),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 3.0, left: 20.0, right: 20.0, bottom: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/money.png',
                          height: 30,
                          width: 20,
                        ),
                        const SizedBox(
                            width:
                                5), // Adding some spacing between image and text
                        Obx(
                          () => Text(
                            "₹ ${walletCon.balance.toString()}",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: <Widget>[
              //       // MaterialButton(
              //       //   color: colors.primary,
              //       //   onPressed: () {
              //       //     // Navigate to the BankDetailsScreen when the button is clicked
              //       //     Navigator.push(
              //       //       context,
              //       //       MaterialPageRoute(
              //       //         builder: (context) => BankDetailsScreen(),
              //       //       ),
              //       //     );
              //       //   },
              //       //   shape: RoundedRectangleBorder(
              //       //     borderRadius: BorderRadius.circular(6),
              //       //   ),
              //       //   child: const Text('Update Bank Detail',
              //       //       style: TextStyle(
              //       //           fontSize: 14,
              //       //           color: colors.white,
              //       //           fontFamily: "Montserra")),
              //       // ),
              //       // const SizedBox(height: 5),
              //       // MaterialButton(
              //       //   color: colors.primary,
              //       //   onPressed: () {
              //       //     // Navigate to the BankDetailsScreen when the button is clicked
              //       //     Navigator.push(
              //       //       context,
              //       //       MaterialPageRoute(
              //       //         builder: (context) => UpdateProfileScreen(),
              //       //       ),
              //       //     );
              //       //   },
              //       //   shape: RoundedRectangleBorder(
              //       //     borderRadius: BorderRadius.circular(6),
              //       //   ),
              //       //   child: const Text('Update Profile',
              //       //       style: TextStyle(
              //       //           fontSize: 14,
              //       //           color: colors.white,
              //       //           fontFamily: "Montserra")),
              //       // ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/WhatsApp Image 2023-12-02 at 7.46.52 PM.jpeg'),
              ),),
              // const SizedBox(
              //   height: 15,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 28),
              //   child: Row(
              //     children: [
              //       MaterialButton(
              //         color: colors.primary,
              //         onPressed: () {
              //           Get.to(const ApplyLeave());
              //         },
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(6),
              //         ),
              //         child: const Text('Apply Leave',
              //             style: TextStyle(
              //                 fontSize: 14,
              //                 color: colors.white,
              //                 fontFamily: "Montserra")),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(horizontal: 28),
              //         child: MaterialButton(
              //           color: colors.primary,
              //           onPressed: () {
              //             Get.to(const VerifyAD());
              //           },
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(6),
              //           ),
              //           child: const Text('Verify AD',
              //               style: TextStyle(
              //                   fontSize: 14,
              //                   color: colors.white,
              //                   fontFamily: "Montserra")),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: const Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Withdrawal Amount",
                          style: TextStyle(
                              fontSize: 14,
                              color: colors.white,
                              fontFamily: "Montserra"),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius:
                      BorderRadius.circular(35), // Adjust the radius as needed
                  border:
                      Border.all(color: colors.widget_color), // Border color
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _withdrawalAmtController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter Amount', // Hint text
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors
                        .transparent, // Set to transparent to let the background show
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .transparent), // Set your desired border color
                    ),

                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .transparent), // Set your desired border color for focused state
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Obx(
                    () => RichText(
                      text: TextSpan(
                        text: "Minimum : ",
                        style: const TextStyle(
                            color: colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                        children: [
                          TextSpan(
                            text: "₹${walletCon.minimum.toString()}",
                            style: const TextStyle(
                                color: colors.cc_green,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Montserrat"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const Text(
                "Amount will be credit in 24 hrs.",
                style: TextStyle(
                    fontSize: 10, color: colors.white, fontFamily: "Montserra"),
              ),
              const SizedBox(
                height: 5,
              ),
              // Obx(
              //     () => MaterialButton(
              //     onPressed: () async {
              //       // showAlertDialog(context);
              //       double withdrawalAmt =
              //           double.tryParse(_withdrawalAmtController.text) ?? 0.0;
              //       double minimumAmt = double.tryParse(walletCon.minimum.toString()) ?? 0.0;
              //       if (withdrawalAmt < minimumAmt) {
              //         utils.showToast("please enter minimum ${walletCon.minimum.toString()}");
              //       } else {
              //         doWithdrawal();
              //       }
              //     },
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //     child: Container(
              //       margin: const EdgeInsets.only(left: 10),
              //       height: 50,
              //       width: 150,
              //       decoration: const BoxDecoration(
              //         image: DecorationImage(
              //           image: AssetImage("assets/images/btnbg.png"),
              //           fit: BoxFit.fill,
              //         ),
              //       ),
              //       child: const Center(
              //         child: Text(
              //           'Withdrawal',
              //           style: TextStyle(
              //               color: colors.white,
              //               fontSize: 14,
              //               fontFamily: "Montserrat",
              //               fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              MaterialButton(
                onPressed: () async {
                  // showAlertDialog(context);
                  authCon.showLoadingIndicator(context);
                  await Future.delayed(const Duration(seconds: 5));
                  double withdrawalAmt =
                      double.tryParse(_withdrawalAmtController.text) ?? 0.0;
                  double minimumAmt =
                      double.tryParse(walletCon.minimum.toString()) ?? 0.0;
                  if (withdrawalAmt < minimumAmt) {
                    utils.showToast(
                        "please enter minimum ${walletCon.minimum.toString()}");
                  } else {
                    walletCon.doWithdrawal(context, _withdrawalAmtController.text);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => wallet()),
                    );
                  }
                  authCon.hideLoadingIndicator(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 50,
                  width: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/btnbg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Withdrawal',
                      style: TextStyle(
                          color: colors.white,
                          fontSize: 14,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: const Text(
                            "Withdrawal Record",
                            style: TextStyle(
                                fontSize: 14,
                                color: colors.white,
                                fontFamily: "Montserra"),
                          ),
                        ),
                      ),
                    ],
                  )),
              const MyWithdrawals()
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(
    BuildContext context,
  ) {
    Size size = MediaQuery.of(context).size;
    Widget chatButton = MaterialButton(
      onPressed: () {
        double withdrawalAmt =
            double.tryParse(_withdrawalAmtController.text) ?? 0.0;
        double minimumAmt = double.tryParse(minimum) ?? 0.0;
        if (withdrawalAmt < minimumAmt) {
          utils.showToast("please enter minimum $minimum");
        } else {
          doWithdrawal();
        }
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 50,
        width: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/btnbg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: const Center(
          child: Text(
            'Withdrawal',
            style: TextStyle(
                color: colors.white,
                fontSize: 14,
                fontFamily: "Montserrat",
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    AlertDialog alert = AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: const EdgeInsets.all(20),
      content: Container(
        height: size.height * 0.13,
        decoration: const BoxDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: const Text(
                    "Would you like to purchase post ?",
                    style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Transform.rotate(
                    angle: 45 * (3.1415926535 / 180),
                    child: const Icon(
                      Icons.add,
                      // Adjust other properties as needed
                      size: 24.0,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            chatButton,
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void doWithdrawal() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.WITHDRAWAL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.AMOUNT: _withdrawalAmtController.text,
    };
    String jsonString = await apiCall(url, bodyObject);
    final jsonResponse = jsonDecode(jsonString);
    final message = jsonResponse['message'];
    final status = jsonResponse['success'];

    if (status) {
      FirebaseMessaging.instance.getToken().then((token) {
        setState(() {
          _fcmToken = token!;
          userDeatils();
        });
        print('FCM Token: $_fcmToken');
      });
      setState(() {
        _withdrawalAmtController.text = "";
      });
    }
    utils.showToast(message);
  }

  void userDeatils() async {
    prefs = await SharedPreferences.getInstance();
    var url = Constant.USER_DETAIL_URL;
    Map<String, dynamic> bodyObject = {
      Constant.USER_ID: prefs.getString(Constant.ID),
      Constant.FCM_ID: _fcmToken
    };
    String jsonString = await apiCall(url, bodyObject);
    final Map<String, dynamic> responseJson = jsonDecode(jsonString);
    final dataList = responseJson['data'] as List;
    final Users user = Users.fromJsonNew(dataList.first);

    prefs.setString(Constant.ID, user.id);
    prefs.setString(Constant.UPI, user.upi);
    prefs.setString(Constant.EARN, user.earn);
    prefs.setString(Constant.BALANCE, user.balance);
    prefs.setString(Constant.REFERRED_BY, user.referredBy);
    prefs.setString(Constant.REFER_CODE, user.referCode);
    prefs.setString(Constant.WITHDRAWAL_STATUS, user.withdrawalStatus);
    prefs.setString(Constant.STATUS, user.status);
    prefs.setString(Constant.JOINED_DATE, user.joinedDate);
    prefs.setString(Constant.LAST_UPDATED, user.lastUpdated);
    prefs.setString(Constant.DEAF, user.deaf);
    setState(() {
      balance = user.balance!;
    });
  }
}
