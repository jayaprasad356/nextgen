class WithdrawalMod {
  bool? success;
  String? message;
  Data? data;

  WithdrawalMod({this.success, this.message, this.data});

  WithdrawalMod.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Withdrawals>? withdrawals;
  List<UserDetails>? userDetails;

  Data({this.withdrawals, this.userDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['withdrawals'] != null) {
      withdrawals = <Withdrawals>[];
      json['withdrawals'].forEach((v) {
        withdrawals!.add(new Withdrawals.fromJson(v));
      });
    }
    if (json['userDetails'] != null) {
      userDetails = <UserDetails>[];
      json['userDetails'].forEach((v) {
        userDetails!.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (withdrawals != null) {
      data['withdrawals'] = withdrawals!.map((v) => v.toJson()).toList();
    }
    if (userDetails != null) {
      data['userDetails'] = userDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Withdrawals {
  String? id;
  String? userId;
  String? amount;
  String? status;
  String? datetime;
  String? balance;

  Withdrawals(
      {this.id,
        this.userId,
        this.amount,
        this.status,
        this.datetime,
        this.balance});

  Withdrawals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    amount = json['amount'];
    status = json['status'];
    datetime = json['datetime'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['status'] = status;
    data['datetime'] = datetime;
    data['balance'] = balance;
    return data;
  }
}

class UserDetails {
  String? id;
  String? mobile;
  String? name;
  String? email;
  String? totalReferrals;
  String? earn;
  String? balance;
  String? deviceId;
  String? referredBy;
  String? referCode;
  String? withdrawalStatus;
  String? status;
  String? joinedDate;
  String? fcmId;
  String? lastUpdated;
  String? minWithdrawal;
  String? registerBonusSent;
  String? accountNum;
  String? holderName;
  String? bank;
  String? branch;
  String? ifsc;
  String? watchOrders;
  String? ordersCost;
  String? registeredDate;
  String? totalOrders;
  String? todayOrders;
  String? targetRefers;
  String? currentRefers;
  String? supportLan;
  String? supportId;
  String? leadId;
  String? branchId;
  String? workedDays;
  String? ordersTime;
  String? blocked;
  String? referBonusSent;
  String? description;
  String? hrId;
  String? aadhaarNum;
  String? dob;
  String? location;
  String? password;
  String? orderAvailable;
  String? storeId;
  String? averageOrders;
  String? abcdUser;
  String? interested;
  String? hiringEarings;
  String? ordersEarnings;
  String? level;

  UserDetails(
      {this.id,
        this.mobile,
        this.name,
        this.email,
        this.totalReferrals,
        this.earn,
        this.balance,
        this.deviceId,
        this.referredBy,
        this.referCode,
        this.withdrawalStatus,
        this.status,
        this.joinedDate,
        this.fcmId,
        this.lastUpdated,
        this.minWithdrawal,
        this.registerBonusSent,
        this.accountNum,
        this.holderName,
        this.bank,
        this.branch,
        this.ifsc,
        this.watchOrders,
        this.ordersCost,
        this.registeredDate,
        this.totalOrders,
        this.todayOrders,
        this.targetRefers,
        this.currentRefers,
        this.supportLan,
        this.supportId,
        this.leadId,
        this.branchId,
        this.workedDays,
        this.ordersTime,
        this.blocked,
        this.referBonusSent,
        this.description,
        this.hrId,
        this.aadhaarNum,
        this.dob,
        this.location,
        this.password,
        this.orderAvailable,
        this.storeId,
        this.averageOrders,
        this.abcdUser,
        this.interested,
        this.hiringEarings,
        this.ordersEarnings,
        this.level});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    name = json['name'];
    email = json['email'];
    totalReferrals = json['total_referrals'];
    earn = json['earn'];
    balance = json['balance'];
    deviceId = json['device_id'];
    referredBy = json['referred_by'];
    referCode = json['refer_code'];
    withdrawalStatus = json['withdrawal_status'];
    status = json['status'];
    joinedDate = json['joined_date'];
    fcmId = json['fcm_id'];
    lastUpdated = json['last_updated'];
    minWithdrawal = json['min_withdrawal'];
    registerBonusSent = json['register_bonus_sent'];
    accountNum = json['account_num'];
    holderName = json['holder_name'];
    bank = json['bank'];
    branch = json['branch'];
    ifsc = json['ifsc'];
    watchOrders = json['watch_orders'];
    ordersCost = json['orders_cost'];
    registeredDate = json['registered_date'];
    totalOrders = json['total_orders'];
    todayOrders = json['today_orders'];
    targetRefers = json['target_refers'];
    currentRefers = json['current_refers'];
    supportLan = json['support_lan'];
    supportId = json['support_id'];
    leadId = json['lead_id'];
    branchId = json['branch_id'];
    workedDays = json['worked_days'];
    ordersTime = json['orders_time'];
    blocked = json['blocked'];
    referBonusSent = json['refer_bonus_sent'];
    description = json['description'];
    hrId = json['hr_id'];
    aadhaarNum = json['aadhaar_num'];
    dob = json['dob'];
    location = json['location'];
    password = json['password'];
    orderAvailable = json['order_available'];
    storeId = json['store_id'];
    averageOrders = json['average_orders'];
    abcdUser = json['abcd_user'];
    interested = json['interested'];
    hiringEarings = json['hiring_earings'];
    ordersEarnings = json['orders_earnings'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mobile'] = mobile;
    data['name'] = name;
    data['email'] = email;
    data['total_referrals'] = totalReferrals;
    data['earn'] = earn;
    data['balance'] = balance;
    data['device_id'] = deviceId;
    data['referred_by'] = referredBy;
    data['refer_code'] = referCode;
    data['withdrawal_status'] = withdrawalStatus;
    data['status'] = status;
    data['joined_date'] = joinedDate;
    data['fcm_id'] = fcmId;
    data['last_updated'] = lastUpdated;
    data['min_withdrawal'] = minWithdrawal;
    data['register_bonus_sent'] = registerBonusSent;
    data['account_num'] = accountNum;
    data['holder_name'] = holderName;
    data['bank'] = bank;
    data['branch'] = branch;
    data['ifsc'] = ifsc;
    data['watch_orders'] = watchOrders;
    data['orders_cost'] = ordersCost;
    data['registered_date'] = registeredDate;
    data['total_orders'] = totalOrders;
    data['today_orders'] = todayOrders;
    data['target_refers'] = targetRefers;
    data['current_refers'] = currentRefers;
    data['support_lan'] = supportLan;
    data['support_id'] = supportId;
    data['lead_id'] = leadId;
    data['branch_id'] = branchId;
    data['worked_days'] = workedDays;
    data['orders_time'] = ordersTime;
    data['blocked'] = blocked;
    data['refer_bonus_sent'] = referBonusSent;
    data['description'] = description;
    data['hr_id'] = hrId;
    data['aadhaar_num'] = aadhaarNum;
    data['dob'] = dob;
    data['location'] = location;
    data['password'] = password;
    data['order_available'] = orderAvailable;
    data['store_id'] = storeId;
    data['average_orders'] = averageOrders;
    data['abcd_user'] = abcdUser;
    data['interested'] = interested;
    data['hiring_earings'] = hiringEarings;
    data['orders_earnings'] = ordersEarnings;
    data['level'] = level;
    return data;
  }
}
