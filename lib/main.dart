//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/control_layer/functions/device_info.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/my_app.dart';

void main() async {
  //Ensure Initialization:
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();

  //lock the landscape mode, and allow only the portrait mode:
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  //determine device-info:
  DeviceInfo.determineTimeZone();
  DeviceInfo.determineDeviceType();
  DeviceInfo.determineDeviceLanguage();

  //run E-commerce inStore app with localization:
  runApp(
    EasyLocalization(
      supportedLocales: const [Variables.enUsLocale, Variables.arSaLocale],
      path: 'assets/translations',
      fallbackLocale: Variables.enUsLocale,
      child: const MyApp(),
    ),
  );
}
