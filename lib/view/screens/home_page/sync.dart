import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:nextgen/data/model/sync_data_nextget.dart';
import 'package:nextgen/data/respons/error_response.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/util/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nextgen/view/screens/login/mainScreen.dart';
import 'package:permission_handler/permission_handler.dart';

class Sync extends StatefulWidget {
  final String userId;
  final String orders;
  final String totalQtySold;
  final String deviceID;
  const Sync({super.key, required this.userId, required this.orders, required this.totalQtySold, required this.deviceID});

  @override
  State<Sync> createState() => _SyncState();
}

class _SyncState extends State<Sync> {
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';


  Future<Response> postData(
  String userId, String orders, String totalQtySold, String deviceID, Map<String, String>? headers) async {
    // final url = Uri.parse('https://nextgen.graymatterworks.com/api/wallet.php');
    final url = Uri.parse(Constant.WALLET);

    Map<String, String> body = {
      'user_id': userId,
      'orders': orders,
      'total_qty_sold' : totalQtySold,
      'update' : '1',
      'device_id' : deviceID,
    };

    try {
      debugPrint('====> Post API Call: $url\nHeader: $headers, $body');
      http.Response response = await http.post(
        url,
        headers: headers ?? {},
        body: body,
      );
      debugPrint("response : $response");
      return handleResponse(response);
    } catch (e) {
      debugPrint('====> postData error: $e');
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {
      // Handle JSON decoding error, if any
    }

    if (response.statusCode == 200) {
      // Successful response
      return Response(
        body: body ?? response.body,
        bodyString: response.body.toString(),
        headers: response.headers,
        statusCode: response.statusCode,
        statusText: response.reasonPhrase,
      );
    } else {
      // Error response
      if (body != null && body is! String) {
        if (body.toString().startsWith('{errors: [{code:')) {
          ErrorResponse errorResponse = ErrorResponse.fromJson(body);
          return Response(
            statusCode: response.statusCode,
            body: body,
            statusText: errorResponse.errors[0].message,
          );
        } else if (body.toString().startsWith('{message')) {
          return Response(
            statusCode: response.statusCode,
            body: body,
            statusText: body['message'],
          );
        }
      }
      return Response(
        statusCode: response.statusCode,
        body: body ?? response.body,
        statusText: response.reasonPhrase,
      );
    }
  }

  // Future<String> postData(String userId, String orders, String totalQtySold, Map<String, String>? headers) async {
  //   final url = Uri.parse('https://nextgen.graymatterworks.com/api/wallet.php');
  //   Map<String, String> body = {
  //     'user_id': userId,
  //     'orders': orders,
  //     'total_qty_sold' : totalQtySold,
  //   };
  //
  //   try {
  //     debugPrint('====> Post API Call: $url\nHeader: $headers, $body');
  //     var response = await http.post(
  //       url,
  //       headers: headers ?? {},
  //       body: body,
  //     );
  //
  //     debugPrint("response : ${response.body}");
  //
  //     //   final jsonsData = jsonDecode(response.body);
  //     // syncData.clear();
  //     //
  //     //   for (var Data in jsonsData['data']) {
  //     //     final id = Data['id'];
  //     //     final amount = Data["amount"];
  //     //     final type = Data['type'];
  //     //     final datetime = Data['datetime'];
  //     //
  //     //     List<String> data = [id, amount, type, datetime];
  //     //     syncData.add(data);
  //     //   }
  //
  //     // Parse the response body as JSON
  //
  //     Navigator.of(context).pop();
  //     return response.body;
  //   } catch (e) {
  //     debugPrint('====> postData error: $e');
  //     throw Exception('API call failed with status code: {response.statusCode}');
  //   }
  // }


  void showLoadingIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Disable back button press
          child: const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 8),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void hideLoadingIndicator(BuildContext context) {
    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        backgroundColor: kBgColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 24,),
          onPressed: () => Navigator.pop(context),
        )
      ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Are you sure you want to sync',
                  style: TextStyle(
                      fontFamily: 'MontserratBold',
                      fontSize: 16.0,
                      color: Colors.white
                ),
              ),
              const SizedBox(height: 10,),
              InkWell(
                onTap: () async {
                  try {
                    showLoadingIndicator(context);
                    await Future.delayed(const Duration(seconds: 5));
                    final value = await postData(widget.userId, widget.orders, widget.totalQtySold,widget.deviceID,{});
                    var responseData = value.body;
                    SyncDataNextgen syncDataNextgen = SyncDataNextgen.fromJson(responseData);
                    debugPrint("===> syncDataNextgen: $syncDataNextgen");
                    debugPrint("===> syncDataNextgen message: ${syncDataNextgen.message}");
                    debugPrint("===> syncDataNextgen success: ${syncDataNextgen.success}");
                    hideLoadingIndicator(context);

                    if(syncDataNextgen.success.toString() == 'true'){
                      await storeLocal.delete(key: 'syncDataNextgenSuccess');
                      await storeLocal.write(key: 'syncDataNextgenSuccess', value: syncDataNextgen.success.toString());
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) =>  MainScreen(isNotifyNav: false,)),
                      );
                    }
                    Get.snackbar(
                      syncDataNextgen.success.toString(),
                      syncDataNextgen.message.toString(),
                      duration: const Duration(seconds: 3),
                      colorText: kPrimaryColor,
                      backgroundColor: kWhiteColor,
                    );
                  } catch (e) {
                    // Handle the exception appropriately
                    debugPrint("Error: $e");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepOrangeAccent,
                        Colors.pink,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 10),
                  margin: const EdgeInsets.only(top: 10),
                  child: const Text(
                    "Confirm",
                    style: TextStyle(
                        fontFamily: 'MontserratBold',
                        fontSize: 16.0,
                        color:Colors.white
                      // : Colors.orangeAccent[200],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
