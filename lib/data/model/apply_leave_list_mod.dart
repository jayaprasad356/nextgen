class ApplyLeaveListMod {
  bool? success;
  int? totalLeaves;
  String? message;
  List<Data>? data;

  ApplyLeaveListMod({this.success, this.totalLeaves, this.message, this.data});

  ApplyLeaveListMod.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    totalLeaves = json['total_leaves'];
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
    data['total_leaves'] = totalLeaves;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? date;
  String? type;
  String? userId;
  String? reason;
  String? status;

  Data({this.id, this.date, this.type, this.userId, this.reason, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    type = json['type'];
    userId = json['user_id'];
    reason = json['reason'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['type'] = type;
    data['user_id'] = userId;
    data['reason'] = reason;
    data['status'] = status;
    return data;
  }
}
