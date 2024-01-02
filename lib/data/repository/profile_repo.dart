import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nextgen/data/api/api_client.dart';
import 'package:nextgen/util/Constant.dart';

class ProfileRepo {
  final ApiClient apiClient;
  final FlutterSecureStorage storageLocal;

  ProfileRepo({required this.apiClient, required this.storageLocal});

  Future<Response> updateProfileDetails(
      String userId,
      String name,
      String mobile,
      // String password,
      // String deviceId,
      String email,
      String location,
      String dob,
      String hrId,
      String aadhaarNum,
      ) async {
    Map<String, String> body = {
      'user_id': userId,
      'name': name,
      'mobile': mobile,
      // 'password': password,
      // 'device_id': deviceId,
      'email': email,
      'location': location,
      'dob': dob,
      'hr_id': hrId,
      'aadhaar_num': aadhaarNum,
    };
    return await apiClient.postData(Constant.UPDATE_PROFILE_URL, body, {});
  }

  Future<Response> applyLeave(
      String userId,
      String leaveDate,
      String reason,
      ) async {
    Map<String, String> body = {
      'user_id': userId,
      'leave_date': leaveDate,
      'reason': reason,
    };
    return await apiClient.postData(Constant.APPLY_LEAVE, body, {});
  }

  Future<Response> applyLeaveList(
      String userId,
      ) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(Constant.APPLY_LEAVE_LIST, body, {});
  }
}
