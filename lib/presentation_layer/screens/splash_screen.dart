//-------------------------- Flutter Packages Imports ----------------------------------

import 'dart:async';
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/user_current_status.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/login_screen.dart';
import 'package:instore/presentation_layer/screens/presist_tab_view.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/translations/locale_keys.g.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.commonWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImagesAssets.splachScreenLogoPath),
            SizedBox(
              height: kScreenWidth * 0.02,
            ),
            const CustomLocalizedTextWidget(
              fontSize: Variables.double23,
              stringKey: LocaleKeys.splachScreenTitle,
            ),
          ],
        ),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(milliseconds: Variables.int2500), () {
      navigateUser(); //It will redirect  after 2.5 seconds
    });
  }

  void navigateUser() async {
    var isLoggedInStatus = await UserCurrentStatus.updateTokenStatus();
    //Un-comment this below line to enforce the app to log out:
    //isLoggedInStatus = 1==2;
    //debugPrint(isLoggedInStatus.toString());
    if (isLoggedInStatus) {
      var isVerified = await UserCurrentStatus.getIsVerified();

      //  ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      if (isVerified) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const PresistTabView(),
          ),
        );
      } else {
        //if the user didn't verify the phone/email contacts then the user should complete the authentication process again:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LogInScreen(),
          ),
        );
      }
    } else {
      //  ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LogInScreen(),
        ),
      );
    }
  }
}
