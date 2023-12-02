import 'package:nextgen/data/api/api_client.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class NotificationRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  NotificationRepo({required this.apiClient, required this.storageLocal});

  Future<Response> notificationAPI() async {
    return await apiClient.postData(
        Constant.NOTIFICATION_LIST_URL,{},{}
    );
  }
}