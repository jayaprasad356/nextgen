import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nextgen/data/api/api_client.dart';
import 'package:nextgen/util/Constant.dart';

class AuthRepo {
  final ApiClient apiClient;
  final FlutterSecureStorage storageLocal;

  AuthRepo({required this.apiClient, required this.storageLocal});

  Future<Response> login(String mobile, String password, String deviceId) async {
    Map<String, String> body = {
      'mobile': mobile,
      'password': password,
      'device_id': deviceId,
    };
    return await apiClient.postData(
        Constant.LOGIN_URL, body, {}
    );
  }

  Future<Response> createUser(
    String name,
    String mobile,
    String password,
    String deviceId,
    String email,
    String location,
    String dob,
    String hrId,
    String aadhaarNum,
  ) async {
    Map<String, String> body = {
      'name': name,
      'mobile': mobile,
      'password': password,
      'device_id': deviceId,
      'email': email,
      'location': location,
      'dob': dob,
      'hr_id': hrId,
      'aadhaar_num': aadhaarNum,
    };
    return await apiClient.postData(
      Constant.REGISTER_URL, body, {}
    );
  }

  Future<Response> joinApp(String userId, String abcdUser, String description) async {
    Map<String, String> body = {
      'user_id': userId,
      'abcd_user': abcdUser,
      'description': description,
    };
    return await apiClient.postData(
        Constant.JOIN_URL, body, {}
    );
  }

  Future<Response> forgetPass(String email, String mobile, String password) async {
    Map<String, String> body = {
      'email': email,
      'mobile': mobile,
      'password': password,
    };
    return await apiClient.postData(
        Constant.FORGET_PASS, body, {}
    );
  }

  Future<Response> userDetails(
      String userId,
      ) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(
        Constant.USER_DETAIL_URL, body, {}
    );
  }
}
