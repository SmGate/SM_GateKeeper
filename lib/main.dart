// ignore_for_file: avoid_print

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sm_gatekeeper/routes/app_routes.dart';
import 'package:sm_gatekeeper/utils/app_bindings.dart';

import 'const/app_translations.dart';
import 'const/route_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCDmrShxv0r-kUBDpA1bC_vjcmRwv_6jGE",
            appId: "1:1085340446333:ios:6ac309e5ea8c1c52180b14",
            messagingSenderId: "1085340446333",
            projectId: "smart-ga"));
  } else {
    await Firebase.initializeApp();
  }
  getValuesFromPref();
  runApp(const MyApp());
}

String? countryCode;
String? languageCode;

void getValuesFromPref() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  countryCode = preferences.getString("countryCode");
  languageCode = preferences.getString("languageCode");
  print("********************$countryCode");
  print("********************$languageCode");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppTranslations(),
        locale: Locale(languageCode ?? 'en', countryCode ?? 'US'),
        initialBinding: AppBindings(),
        initialRoute: RoutesString.homeScreen,
        onGenerateRoute: (settings) {
          return AppRoutes.generateRoute(settings.name);
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const SplashScreen(),
      ),
    );
  }
}
