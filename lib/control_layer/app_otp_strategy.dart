//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/cupertino.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:otp_autofill/otp_autofill.dart';

//-------------------------- InStore App Imports ----------------------------------

class AppOtpStrategy extends OTPStrategy {
  AppOtpStrategy({
    this.currentOTPcode = Variables.dummyOTPcode,
  });
  final String currentOTPcode;
  @override
  Future<String> listenForCode() {
    debugPrint("AppOtpStrategy()");
    return Future.delayed(
      const Duration(seconds: 4),
      () => "Your code is: $currentOTPcode",
    );
  }
}
