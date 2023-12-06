import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nextgen/data/api/api_client.dart';
import 'package:nextgen/util/Constant.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final FlutterSecureStorage storageLocal;

  ProfileRepo({required this.apiClient, required this.storageLocal});

  // Future<Response> updateProfileDetails(String userId, String holderName,
  //     String bank, String accountNum, String branch, String ifsc) async {
  //   Map<String, String> body = {
  //     'user_id': userId,
  //     'holder_name': holderName,
  //     'bank': bank,
  //     'account_num': accountNum,
  //     'branch': branch,
  //     'ifsc': ifsc,
  //   };
  //   return await apiClient.postData(Constant.UPDATE_PROFILE_URL, body, {});
  // }
}
