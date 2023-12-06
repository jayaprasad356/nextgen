class TransactionMod {
  bool? success;
  String? message;
  List<Data>? data;

  TransactionMod({this.success, this.message, this.data});

  TransactionMod.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? amount;
  String? orders;
  String? type;
  String? datetime;

  Data({this.id, this.amount, this.orders, this.type, this.datetime});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    orders = json['orders'];
    type = json['type'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['orders'] = orders;
    data['type'] = type;
    data['datetime'] = datetime;
    return data;
  }
}
