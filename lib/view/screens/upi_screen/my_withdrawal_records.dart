import 'dart:convert';
import 'package:get/get.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/controller/wallet_con.dart';
import 'package:nextgen/model/withdrawal_data.dart';
import 'package:flutter/material.dart';

import '../../../util/Color.dart';
import '../../../util/Constant.dart';
import '../../../Helper/apiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWithdrawals extends StatefulWidget {
  const MyWithdrawals({Key? key}) : super(key: key);

  @override
  State<MyWithdrawals> createState() => _MyWithdrawalsState();
}

class _MyWithdrawalsState extends State<MyWithdrawals> {
  final WalletCon walletCon = Get.find<WalletCon>();
  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletCon.transactionAPI();
  }
  // late List<WithdrawalData> withdrawalsData = [];
  // late SharedPreferences prefs;
  // Future<List<WithdrawalData>> _getWithdrawalsData() async {
  //   prefs = await SharedPreferences.getInstance();
  //
  //   Map<String, dynamic> bodyObject = {
  //     Constant.USER_ID: prefs.getString(Constant.ID)!,
  //   };
  //
  //   String response = await apiCall(Constant.MY_WITHDRAWALS_LIST_URL,bodyObject);
  //
  //   final jsonsData = jsonDecode(response);
  //   withdrawalsData.clear();
  //
  //   for (var Data in jsonsData['data']) {
  //     final id = Data['id'];
  //     final amount = Data["amount"];
  //     final status = Data['status'];
  //     final datetime = Data['datetime'];
  //
  //     WithdrawalData data = WithdrawalData(id, amount, status, datetime);
  //     withdrawalsData.add(data);
  //   }
  //   return withdrawalsData;
  // // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   debugPrint("withdrawalsData: $withdrawalsData");
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: walletCon.withdrawalList(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (walletCon.withdrawalsData.isEmpty) {
          return const Center(
              child: Column(
                children: [
                 // CircularProgressIndicator(color: colors.primary),
                ],
              ));
        } else {
          return  SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: walletCon.withdrawalsData.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        color: colors.cc_velvet,
                        margin: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 5, top: 5),
                        child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children:  [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 15,
                                              top: 10,
                                              bottom: 10.0),
                                          child: Text("Amount",
                                              style: TextStyle(
                                                  color: colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 15, bottom: 10),
                                          child: Text("₹${walletCon.withdrawalsData[index].amount}",
                                              style: const TextStyle(
                                                  color: colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children:  [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Text("Time",
                                              style: TextStyle(
                                                  color: colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(bottom: 10),
                                          child: Text(walletCon.withdrawalsData[index].datetime,
                                              style: const TextStyle(
                                                  color: colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                      children:  [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              right: 15.0,
                                              top: 10,
                                              bottom: 10),
                                          child: Text("Status",
                                              style: TextStyle(
                                                  color: colors.white,
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12)),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15, bottom: 10),
                                          child: Text(
                                            walletCon.withdrawalsData[index].status=="0"? "Pending": walletCon.withdrawalsData[index].status=="1" ? "Completed" : "Cancelled",
                                            style:  TextStyle(
                                                color: walletCon.withdrawalsData[index].status == "0"  ? colors.greyss : walletCon.withdrawalsData[index].status=="1" ? colors.cc_green : colors.red ,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),

                              ],
                            )),
                      )),
                );
              },
            ),
          );
        }
      },
    );
  }
}
