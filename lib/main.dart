import 'dart:convert';
// import 'dart:io';
// import 'dart:html' as html;

// import 'package:color_challenge/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nextgen/controller/auth_con.dart';
import 'package:nextgen/controller/full_time_page_con.dart';
import 'package:nextgen/controller/notification_con.dart';
import 'package:nextgen/controller/pcc_controller.dart';
import 'package:nextgen/controller/home_con.dart';
import 'package:nextgen/controller/profile_con.dart';
import 'package:nextgen/controller/upi_controller.dart';
import 'package:nextgen/controller/wallet_con.dart';
import 'package:nextgen/data/api/api_client.dart';
import 'package:nextgen/data/api/firebase_api.dart';
import 'package:nextgen/data/repository/auth_repo.dart';
import 'package:nextgen/data/repository/full_time_repo.dart';
import 'package:nextgen/data/repository/home_repo.dart';
import 'package:nextgen/data/repository/notification_repo.dart';
import 'package:nextgen/data/repository/profile_repo.dart';
import 'package:nextgen/data/repository/shorts_video_repo.dart';
import 'package:nextgen/data/repository/upi_repo.dart';
import 'package:nextgen/data/repository/wallet_repo.dart';
import 'package:nextgen/data/repository/work_repo.dart';
import 'package:nextgen/test.dart';
import 'package:nextgen/util/color_const.dart';
import 'package:nextgen/view/screens/login/create_acc.dart';
import 'package:nextgen/view/screens/login/loginMobile.dart';
import 'package:nextgen/view/screens/login/login_screen.dart';
import 'package:nextgen/view/screens/login/mainScreen.dart';
import 'package:nextgen/view/screens/login/otpVerfication.dart';
import 'package:nextgen/view/screens/upi_screen/wallet.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'util/Constant.dart';
import 'Helper/apiCall.dart';
import 'controller/utils.dart';
import 'package:package_info/package_info.dart';
import 'package:get/get.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'view/screens/home_page/home_screen.dart';
import 'view/screens/profile_screen/new_profile_screen.dart';
import 'view/screens/updateApp/updateApp.dart';
// import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(const FlutterSecureStorage());

  try {
    if (kIsWeb) {
      debugPrint("The app is running on the web.");
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyCuvfJETE0AdzyfYZ6IpzW1T4J2pAFE6JY",
          authDomain: "next-gen-a052d.firebaseapp.com",
          projectId: "next-gen-a052d",
          storageBucket: "next-gen-a052d.appspot.com",
          messagingSenderId: "526593393536",
          appId: "1:526593393536:web:56701da3c74f04288cb765",
          measurementId: "G-ZZRN46NH58",
        ),
      );
      // await storeLocal.write(key: Constant.IS_WEB, value: 'true');
    } else {
      debugPrint("The app is running on an Android device.");
      // await storeLocal.write(key: Constant.IS_WEB, value: 'false');
    }
    await Firebase.initializeApp();
    await FirebaseApi().initNotification();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
  } catch (e) {
    debugPrint('this is error : $e');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  Get.put(
    AuthCon(
      authRepo: AuthRepo(
          apiClient: ApiClient(
            appBaseUrl: Constant.MainBaseUrl,
            storageLocal: storeLocal,
          ),
          storageLocal: storeLocal),
    ),
  );

  Get.put(
    ProfileCon(
      profileRepo: ProfileRepo(
          storageLocal: storeLocal,
          apiClient: ApiClient(
            appBaseUrl: Constant.MainBaseUrl,
            storageLocal: storeLocal,
          )),
    ),
  );

  Get.put(
    WalletCon(
      walletRepo: WalletRepo(
          storageLocal: storeLocal,
          apiClient: ApiClient(
            appBaseUrl: Constant.MainBaseUrl,
            storageLocal: storeLocal,
          )),
    ),
  );
  //
  Get.put(
    NotificationController(
      notificationRepo: NotificationRepo(
          apiClient: ApiClient(
            appBaseUrl: Constant.MainBaseUrl,
            storageLocal: storeLocal,
          ),
          storageLocal: storeLocal),
    ),
  );

  // Get.put(
  //   WorkCont(
  //     workRepo: WorkRepo(
  //         apiClient: ApiClient(
  //           appBaseUrl: Constant.MainBaseUrl,
  //           storageLocal: storeLocal,
  //         ),
  //         storageLocal: storeLocal),
  //   ),
  // );

  Get.put(
    HomeController(
      homeRepo: HomeRepo(
          apiClient: ApiClient(
              appBaseUrl: Constant.MainBaseUrl, storageLocal: storeLocal),
          storageLocal: storeLocal),
    ),
  );

  // Get.put(
  //   PCC(
  //     shortsVideoRepo: ShortsVideoRepo(
  //         apiClient: ApiClient(
  //           appBaseUrl: Constant.MainBaseUrl,
  //           storageLocal: storeLocal,
  //         ),
  //         storageLocal: storeLocal),
  //   ),
  // );

  // runApp(MyVideoApp());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;
  late String _fcmToken;
  late String appVersion;
  bool update = true;
  String link = "";

  @override
  void initState() {
    super.initState();
    // final isLaptop = isOpenLap();
    // if (isLaptop == 'true') {
    //   // Laptop
    //   print('User is on a laptop');
    // } else {
    //   // Mobile
    //   print('User is on Android');
    // }

    // Utils().deviceInfo();
    // PlatformDeviceIdWebPlugin().getDeviceId();

    try{
      FirebaseMessaging.onMessage.listen(showFlutterNotification);

      SharedPreferences.getInstance().then((prefs) {
        setState(() {
          FirebaseAnalytics.instance.logEvent(name: "appStart");
          _prefs = prefs;
        });
      });

      getToken();

      FirebaseMessaging.instance.getToken().then(
            (token) {
          setState(
                () {
              _fcmToken = token!;
            },
          );
          print('FCM Token: $_fcmToken');
        },
      );
    } catch (e) {
      debugPrint("this is error 404: $e");
    }

    // FirebaseMessaging.onMessage.listen(
    //   (RemoteMessage message) {
    //     print('onMessage received: $message');
    //     //showNotification();
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = message.notification?.android;
    //     if (notification != null && android != null) {
    //       flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description!,
    //             importance: channel.importance!,
    //             playSound: channel.playSound!,
    //             color: Colors.blue,
    //             priority: Priority.high,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ),
    //       );
    //     }
    //   },
    // );

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print('A new onMessageOpenedApp event was published!');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }


  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    debugPrint("Notification Title: ${notification!.title}");
    AndroidNotification? android = message.notification?.android;
    debugPrint("Notification Title: ${notification.title}");

    Get.snackbar("Create Account", notification.title.toString(),colorText: kPrimaryColor,backgroundColor: kWhiteColor,duration: const Duration(seconds: 3),);

    // showModalBottomSheet(context: context, builder: ((context) {
    //   return Card(
    //     child: Column(
    //       children: [
    //         Text(notification.title.toString())
    //       ],
    //     ),
    //   );
    // }));
    // if (notification != null && android != null && !kIsWeb) {
    //   flutterLocalNotificationsPlugin.show(
    //     notification.hashCode,
    //     notification.title,
    //     notification.body,
    //     NotificationDetails(
    //       android: AndroidNotificationDetails(
    //         channel.id,
    //         channel.name,
    //         channelDescription: channel.description,
    //         // TODO add a proper drawable resource to android, for now using
    //         //      one that already exists in example app.
    //         icon: 'launch_background',
    //       ),
    //     ),
    //   );
    // }
  }

  getToken () async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    debugPrint("deviceToken: $deviceToken");
  }

  // String isOpenLap() {
  //   if (!kIsWeb) {
  //     return 'false'; // Running on a non-web platform (e.g., Android)
  //   } else {
  //     return 'true'; // Running in a web-based environment
  //   }
  // }

  // String isOpenLap() {
  //   final userAgent = html.window.navigator.userAgent.toLowerCase();
  //   if (userAgent.contains('android')) {
  //     return 'false';
  //   } else {
  //     return 'true';
  //   }
  // }

  Future<void> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      appVersion = packageInfo.version;
      debugPrint("appVersion: $appVersion");
      var url = Constant.APPUPDATE_URL;
      Map<String, dynamic> bodyObject = {
        Constant.APP_VERSION: appVersion,
      };

      String jsonString = await apiCall(url, bodyObject);
      final Map<String, dynamic> responseJson = jsonDecode(jsonString);

      // Check if the 'data' key exists and is a List
      if (responseJson['data'] is List) {
        final dataList = responseJson['data'] as List;

        if (dataList.isNotEmpty) {
          final datass = dataList.first;
          setState(() {
            link = datass[Constant.LINK];
            update = responseJson["success"];
          });
        } else {
          // Handle empty dataList
        }
      } else {
        // Handle cases where 'data' is not a List
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder:
          (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
        if (snapshot.hasData) {
          final SharedPreferences prefs = snapshot.data!;
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Next Gen',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // routes: {
            //   '/otpVerification': (context) => const OtpVerification(
            //     mobileNumber: '',
            //     otp: '',
            //   ),
            // },
            initialBinding: BindingsBuilder(() {
              Get.put(
                AuthCon(
                  authRepo: AuthRepo(
                      apiClient: ApiClient(
                        appBaseUrl: Constant.MainBaseUrl,
                        storageLocal: storeLocal,
                      ),
                      storageLocal: storeLocal),
                ),
              );
              Get.put(
                ProfileCon(
                  profileRepo: ProfileRepo(
                      storageLocal: storeLocal,
                      apiClient: ApiClient(
                        appBaseUrl: Constant.MainBaseUrl,
                        storageLocal: storeLocal,
                      )),
                ),
              );
              Get.put(
                WalletCon(
                  walletRepo: WalletRepo(
                      storageLocal: storeLocal,
                      apiClient: ApiClient(
                        appBaseUrl: Constant.MainBaseUrl,
                        storageLocal: storeLocal,
                      )),
                ),
              );
              Get.put(
                NotificationController(
                  notificationRepo: NotificationRepo(
                      apiClient: ApiClient(
                        appBaseUrl: Constant.MainBaseUrl,
                        storageLocal: storeLocal,
                      ),
                      storageLocal: storeLocal),
                ),
              );
              Get.put(
                HomeController(
                  homeRepo: HomeRepo(
                      apiClient: ApiClient(
                          appBaseUrl: Constant.MainBaseUrl,
                          storageLocal: storeLocal),
                      storageLocal: storeLocal),
                ),
              );
              // Get.put(
              //   FullTimePageCont(
              //     fullTimeRepo: FullTimeRepo(
              //         apiClient: ApiClient(
              //             appBaseUrl: Constant.MainBaseUrl,
              //             storageLocal: storeLocal),
              //         storageLocal: storeLocal),
              //   ),
              // );
              // Get.put(
              //   UPIController(
              //     upiRepo: UPIRepo(
              //         apiClient: ApiClient(
              //             appBaseUrl: Constant.MainBaseUrl,
              //             storageLocal: storeLocal),
              //         storageLocal: storeLocal),
              //   ),
              // );
            }),
            // home: const TestingPage(),
            // home: const HomeScreen(),
            // home: const LoginScreen(),
            home: screens(prefs),
            // home: NewProfileScreen(mobileNumber: "7010565083"),
            // home: isOpenLap() != 'true'
            //     ? screens(prefs)
            //     : const Scaffold(
            //   backgroundColor: Colors.white,
            //   body: Center(
            //     child: Text("This website is for mobile only"),
            //   ),
            // ),
          );
        } else {
          return const Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}

Widget screens(SharedPreferences prefs) {
  final String? isLoggedIn = prefs.getString(Constant.LOGED_IN_STATUS);
  debugPrint("isLoggedIn: $isLoggedIn");
  if (isLoggedIn != null && isLoggedIn == "true") {
    // showNotification();
    return  MainScreen(isNotifyNav: false,);
  } else {
    return const LoginScreen();
  }
}
//
// Widget screens(SharedPreferences prefs, bool update, String link) {
//   final String? isLoggedIn = prefs.getString(Constant.LOGED_IN_STATUS);
//   debugPrint("isLoggedIn: $isLoggedIn");
//   if (isLoggedIn != null && isLoggedIn == "true") {
//     // showNotification();
//     if (update) {
//       return const MainScreen();
//     } else {
//       return UpdateDialog(link: link);
//     }
//   } else {
//     if (update) {
//       return const LoginScreen();
//     } else {
//       return UpdateDialog(link: link);
//     }
//   }
// }

// void showNotification() {
//   flutterLocalNotificationsPlugin.show(
//       0,
//       "Testing Notification",
//       "This notification comes all the time of opening app",
//       NotificationDetails(
//           android: AndroidNotificationDetails(channel.id, channel.name,
//               channelDescription: channel.description,
//               importance: Importance.high,
//               color: Colors.blue,
//               priority: Priority.high,
//               playSound: true,
//               icon: '@mipmap/ic_launcher')));
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(),
//     );
//   }
// }

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome to Nextgen beta",
          style: TextStyle(
              fontSize: 24,
              color: Colors.blue,
              fontFamily: 'MontserratBold',
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
