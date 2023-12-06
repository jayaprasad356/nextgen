import 'package:nextgen/data/api/api_client.dart';
import 'package:nextgen/util/Constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class WalletRepo {
  late final ApiClient apiClient;
  late final FlutterSecureStorage storageLocal;

  WalletRepo({required this.apiClient, required this.storageLocal});

  Future<Response> updateBankDetails(String userId, String holderName,
      String bank, String accountNum, String branch, String ifsc) async {
    Map<String, String> body = {
      'user_id': userId,
      'holder_name': holderName,
      'bank': bank,
      'account_num': accountNum,
      'branch': branch,
      'ifsc': ifsc,
    };
    return await apiClient.postData(Constant.UPDATE_BANK_DETAILS, body, {});
  }

  Future<Response> doWithdrawal(String userId, String amount) async {
    Map<String, String> body = {
      'user_id': userId,
      'amount': amount,
    };
    return await apiClient.postData(Constant.WITHDRAWAL_URL, body, {});
  }

  Future<Response> withdrawalList(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(Constant.MY_WITHDRAWALS_LIST_URL, body, {});
  }

  Future<Response> addToMainBalance(String userId, String walletType) async {
    Map<String, String> body = {
      'user_id': userId,
      'wallet_type': walletType,
    };
    return await apiClient.postData(Constant.ADD_MAIN_BALANCE_URL, body, {});
  }

  Future<Response> transactionAPI(String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    return await apiClient.postData(Constant.TRANSACTIONS_LIST_URL, body, {});
  }
}
