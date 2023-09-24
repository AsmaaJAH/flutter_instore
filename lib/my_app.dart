//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';
import 'package:instore/control_layer/managers/themes_manager/mode_themes_manager.dart';
import 'package:instore/presentation_layer/screens/splash_screen.dart';
import 'package:instore/control_layer/functions/user_current_status.dart';

GlobalKey<NavigatorState> kNavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // determine screen dimensions,in order to use the two variables,"kScreenWidth" and "kScreenHeight", in everywhere direcly in any app file u wanna. please, do NOT move them from here, otherwise,the whole-app design won't fit its screen
    knowScreenWidth(context);
    knowScreenHeight(context);

    //determine user-current-status:
    UserCurrentStatus.getAppCurrentLanguageCode(
        context); //no need to put "await" here as it will work in the background

    return MultiProvider(
      providers: ProviderHelperFunctions.getProviders(),
      builder: (context, _) {
        return MaterialApp(
          title: 'E-Commerce',
          debugShowCheckedModeBanner: false,
          theme: ModeThemeManager.lightThemes,
          darkTheme: ModeThemeManager.darkThemes,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorKey: kNavigatorKey,
          home: const SafeArea(
            minimum: EdgeInsets.all(Variables.two),
            child: SplashScreen(),
          ),
        );
      },
    );
  }
}
