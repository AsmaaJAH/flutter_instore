//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/flavors_layer/delete_me.dart';
import 'package:instore/my_app.dart';
import 'package:instore/control_layer/functions/authentication_functions/forms_reset.dart';

class GuestModeFunctions {
  GuestModeFunctions._();

  static void onPressCloseBtnOfQuestMode({
    GlobalKey<FormState>? loginFormKey,
    GlobalKey<FormState>? signUpFormKey,
    GlobalKey<FormState>? forgetPasswordFormKey,
  }) {
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      Navigator.of(kNavigatorKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => const DeleteMe(),
        ),
      );
      var isLoggingIn =
          loginFormKey != null && loginFormKey.currentState != null;
      var isSigningUp =
          signUpFormKey != null && signUpFormKey.currentState != null;
      var isForgettingPass = forgetPasswordFormKey != null &&
          forgetPasswordFormKey.currentState != null;

      //reseting everything in the form:
      if (isLoggingIn) {
        loginFormKey.currentState!.reset();
      }
      if (isSigningUp) {
        signUpFormKey.currentState!.reset();
      }
      if (isForgettingPass) {
        forgetPasswordFormKey.currentState!.reset();
      }

      FormsReset.resetEmailForm();
      FormsReset.resetPhoneForm();
      FormsReset.resetNameForm();
      FormsReset.resetPassWordForm();
      FormsReset.resetVerifications(isResettingFromForgetPass: true);

    }
  }
}
