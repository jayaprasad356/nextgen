import 'package:nextgen/data/api/api_client.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class WorkRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  WorkRepo({required this.apiClient, required this.storageLocal});

  Future<Response> syncData(String userId, String orders) async {
    Map<String, String> body = {
      'user_id': userId,
      'orders': orders,
    };
    return await apiClient.postData(Constant.WALLET, body, {});
  }
}
