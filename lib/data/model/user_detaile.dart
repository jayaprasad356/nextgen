class UserDetail {
  bool? success;
  String? message;
  List<Data>? data;
  List<Settings>? settings;

  UserDetail({this.success, this.message, this.data, this.settings});

  UserDetail.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    if (json['settings'] != null) {
      settings = <Settings>[];
      json['settings'].forEach((v) {
        settings!.add(Settings.fromJson(v));
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
    if (settings != null) {
      data['settings'] = settings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? mobile;
  String? name;
  String? upi;
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
  Null? fcmId;
  String? lastUpdated;
  String? minWithdrawal;
  String? registerBonusSent;
  String? generateCoin;
  String? totalOrdersViewed;
  String? trailCompleted;
  String? accountNum;
  String? holderName;
  String? bank;
  String? branch;
  String? ifsc;
  String? watchOrders;
  String? registeredDate;
  String? totalOrders;
  String? todayOrders;
  String? supportId;
  String? leadId;
  String? branchId;
  String? workedDays;
  String? plan;
  String? videoWallet;
  String? mediaWallet;
  String? postLeft;
  String? ordersTime;
  String? oldPlan;
  String? oldPb;
  String? rewardOrders;
  String? blocked;
  String? referBonusSent;
  String? refer;
  String? description;
  String? ratings;
  String? hrId;
  String? aadhaarNum;
  String? dob;
  String? location;
  String? password;
  String? orderAvailable;
  String? storeId;
  String? averageOrders;
  String? level;
  String? abcdUser;
  String? interested;
  String? ordersEarnings;
  String? hiringEarings;
  String? lastTodayOrders;
  String? minQty;
  String? maxQty;
  String? enrollDate;
  String? planPrice;
  String? studentPlan;
  String? days60Plan;
  String? loginTime;
  String? productStatus;

  Data(
      {this.id,
        this.mobile,
        this.name,
        this.upi,
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
        this.generateCoin,
        this.totalOrdersViewed,
        this.trailCompleted,
        this.accountNum,
        this.holderName,
        this.bank,
        this.branch,
        this.ifsc,
        this.watchOrders,
        this.registeredDate,
        this.totalOrders,
        this.todayOrders,
        this.supportId,
        this.leadId,
        this.branchId,
        this.workedDays,
        this.plan,
        this.videoWallet,
        this.mediaWallet,
        this.postLeft,
        this.ordersTime,
        this.oldPlan,
        this.oldPb,
        this.rewardOrders,
        this.blocked,
        this.referBonusSent,
        this.refer,
        this.description,
        this.ratings,
        this.hrId,
        this.aadhaarNum,
        this.dob,
        this.location,
        this.password,
        this.orderAvailable,
        this.storeId,
        this.averageOrders,
        this.level,
        this.abcdUser,
        this.interested,
        this.ordersEarnings,
        this.hiringEarings,
        this.lastTodayOrders,
        this.minQty,
        this.maxQty,
        this.enrollDate,
        this.planPrice,
        this.studentPlan,
        this.days60Plan,
        this.loginTime,
        this.productStatus});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    name = json['name'];
    upi = json['upi'];
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
    generateCoin = json['generate_coin'];
    totalOrdersViewed = json['total_orders_viewed'];
    trailCompleted = json['trail_completed'];
    accountNum = json['account_num'];
    holderName = json['holder_name'];
    bank = json['bank'];
    branch = json['branch'];
    ifsc = json['ifsc'];
    watchOrders = json['watch_orders'];
    registeredDate = json['registered_date'];
    totalOrders = json['total_orders'];
    todayOrders = json['today_orders'];
    supportId = json['support_id'];
    leadId = json['lead_id'];
    branchId = json['branch_id'];
    workedDays = json['worked_days'];
    plan = json['plan'];
    videoWallet = json['video_wallet'];
    mediaWallet = json['media_wallet'];
    postLeft = json['post_left'];
    ordersTime = json['orders_time'];
    oldPlan = json['old_plan'];
    oldPb = json['old_pb'];
    rewardOrders = json['reward_orders'];
    blocked = json['blocked'];
    referBonusSent = json['refer_bonus_sent'];
    refer = json['refer'];
    description = json['description'];
    ratings = json['ratings'];
    hrId = json['hr_id'];
    aadhaarNum = json['aadhaar_num'];
    dob = json['dob'];
    location = json['location'];
    password = json['password'];
    orderAvailable = json['order_available'];
    storeId = json['store_id'];
    averageOrders = json['average_orders'];
    level = json['level'];
    abcdUser = json['abcd_user'];
    interested = json['interested'];
    ordersEarnings = json['orders_earnings'];
    hiringEarings = json['hiring_earings'];
    lastTodayOrders = json['last_today_orders'];
    minQty = json['min_qty'];
    maxQty = json['max_qty'];
    enrollDate = json['enroll_date'];
    planPrice = json['plan_price'];
    studentPlan = json['student_plan'];
    days60Plan = json['days_60_plan'];
    loginTime = json['login_time'];
    productStatus = json['product_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mobile'] = mobile;
    data['name'] = name;
    data['upi'] = upi;
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
    data['generate_coin'] = generateCoin;
    data['total_orders_viewed'] = totalOrdersViewed;
    data['trail_completed'] = trailCompleted;
    data['account_num'] = accountNum;
    data['holder_name'] = holderName;
    data['bank'] = bank;
    data['branch'] = branch;
    data['ifsc'] = ifsc;
    data['watch_orders'] = watchOrders;
    data['registered_date'] = registeredDate;
    data['total_orders'] = totalOrders;
    data['today_orders'] = todayOrders;
    data['support_id'] = supportId;
    data['lead_id'] = leadId;
    data['branch_id'] = branchId;
    data['worked_days'] = workedDays;
    data['plan'] = plan;
    data['video_wallet'] = videoWallet;
    data['media_wallet'] = mediaWallet;
    data['post_left'] = postLeft;
    data['orders_time'] = ordersTime;
    data['old_plan'] = oldPlan;
    data['old_pb'] = oldPb;
    data['reward_orders'] = rewardOrders;
    data['blocked'] = blocked;
    data['refer_bonus_sent'] = referBonusSent;
    data['refer'] = refer;
    data['description'] = description;
    data['ratings'] = ratings;
    data['hr_id'] = hrId;
    data['aadhaar_num'] = aadhaarNum;
    data['dob'] = dob;
    data['location'] = location;
    data['password'] = password;
    data['order_available'] = orderAvailable;
    data['store_id'] = storeId;
    data['average_orders'] = averageOrders;
    data['level'] = level;
    data['abcd_user'] = abcdUser;
    data['interested'] = interested;
    data['orders_earnings'] = ordersEarnings;
    data['hiring_earings'] = hiringEarings;
    data['last_today_orders'] = lastTodayOrders;
    data['min_qty'] = minQty;
    data['max_qty'] = maxQty;
    data['enroll_date'] = enrollDate;
    data['plan_price'] = planPrice;
    data['student_plan'] = studentPlan;
    data['days_60_plan'] = days60Plan;
    data['login_time'] = loginTime;
    data['product_status'] = productStatus;
    return data;
  }
}

class Settings {
  String? id;
  String? withdrawalStatus;
  String? contactUs;
  String? minWithdrawal;
  String? jobVideo;
  String? minDpCoins;
  String? maxDpCoins;
  String? challengeStatus;
  String? postVideoUrl;
  String? upi;
  String? result;
  String? whatsappChannelLink;
  String? jobDetails;
  String? purchasePlanLink;
  String? postVideoDetails;
  String? referCoins;
  String? registerCoins;
  String? ordersStatus;
  String? vacancies;

  Settings(
      {this.id,
        this.withdrawalStatus,
        this.contactUs,
        this.minWithdrawal,
        this.jobVideo,
        this.minDpCoins,
        this.maxDpCoins,
        this.challengeStatus,
        this.postVideoUrl,
        this.upi,
        this.result,
        this.whatsappChannelLink,
        this.jobDetails,
        this.purchasePlanLink,
        this.postVideoDetails,
        this.referCoins,
        this.registerCoins,
        this.ordersStatus,
        this.vacancies});

  Settings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    withdrawalStatus = json['withdrawal_status'];
    contactUs = json['contact_us'];
    minWithdrawal = json['min_withdrawal'];
    jobVideo = json['job_video'];
    minDpCoins = json['min_dp_coins'];
    maxDpCoins = json['max_dp_coins'];
    challengeStatus = json['challenge_status'];
    postVideoUrl = json['post_video_url'];
    upi = json['upi'];
    result = json['result'];
    whatsappChannelLink = json['whatsapp_channel_link'];
    jobDetails = json['job_details'];
    purchasePlanLink = json['purchase_plan_link'];
    postVideoDetails = json['post_video_details'];
    referCoins = json['refer_coins'];
    registerCoins = json['register_coins'];
    ordersStatus = json['orders_status'];
    vacancies = json['vacancies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['withdrawal_status'] = withdrawalStatus;
    data['contact_us'] = contactUs;
    data['min_withdrawal'] = minWithdrawal;
    data['job_video'] = jobVideo;
    data['min_dp_coins'] = minDpCoins;
    data['max_dp_coins'] = maxDpCoins;
    data['challenge_status'] = challengeStatus;
    data['post_video_url'] = postVideoUrl;
    data['upi'] = upi;
    data['result'] = result;
    data['whatsapp_channel_link'] = whatsappChannelLink;
    data['job_details'] = jobDetails;
    data['purchase_plan_link'] = purchasePlanLink;
    data['post_video_details'] = postVideoDetails;
    data['refer_coins'] = referCoins;
    data['register_coins'] = registerCoins;
    data['orders_status'] = ordersStatus;
    data['vacancies'] = vacancies;
    return data;
  }
}
