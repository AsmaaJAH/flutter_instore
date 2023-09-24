//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/name_form_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/password_form_provider.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/phone_form_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/email_form_provider.dart';
import 'package:instore/my_app.dart';

class FormsReset {
  FormsReset._();

  //------------------------ when using the device back button:------------------------
  static void onWillPop({
    GlobalKey<FormState>? loginFormKey,
    GlobalKey<FormState>? signUpFormKey,
    GlobalKey<FormState>? forgetPasswordFormKey,
  }) {
    var isLoggingIn = loginFormKey != null && loginFormKey.currentState != null;
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
    resetNameForm();
    resetEmailForm();
    resetPhoneForm();
    resetPassWordForm();
    //reset verification code screen:
    resetVerifications();

    // var isResettedMail = resetEmailForm(); var isResettedPhone = resetPhoneForm(); debugPrint( "isResettedMail:$isResettedMail---------- isResettedPhone:$isResettedPhone");
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      Navigator.pop(kNavigatorKey.currentContext!, true);
      return;
    }
  }

  //-------------------------------------- reset form:--------------------------------
  //reset Name form:
  static void resetNameForm({
    GlobalKey<FormState>? signUpFormKey,
  }) {
    var nameState = kNavigatorKey.currentContext!.read<NameFormProviderState>();
    var isSigningUp =
        signUpFormKey != null && signUpFormKey.currentState != null;

    //reseting everything in the form:
    if (isSigningUp) {
      signUpFormKey.currentState!.reset();
    }

    nameState.updateIsErrorNameValidator(false);
  }

  //reset email form:
  static void resetEmailForm({
    GlobalKey<FormState>? loginFormKey,
    GlobalKey<FormState>? signUpFormKey,
  }) {
    var emailState =
        kNavigatorKey.currentContext!.read<EmailFormProviderState>();
    var isLoggingIn = loginFormKey != null && loginFormKey.currentState != null;
    var isSigningUp =
        signUpFormKey != null && signUpFormKey.currentState != null;

    //reseting everything in the form:
    if (isLoggingIn) {
      loginFormKey.currentState!.reset();
    }
    if (isSigningUp) {
      signUpFormKey.currentState!.reset();
    }

    emailState.updateIsErrorEmailValidator(false);
  }

  //reset phone form:
  static void resetPhoneForm({
    GlobalKey<FormState>? loginFormKey,
    GlobalKey<FormState>? signUpFormKey,
    GlobalKey<FormState>? forgetPasswordFormKey,
  }) {
    var phoneState =
        kNavigatorKey.currentContext!.read<PhoneFormProviderState>();
    var isSigningUp =
        signUpFormKey != null && signUpFormKey.currentState != null;
    var isForgettingPass = forgetPasswordFormKey != null &&
        forgetPasswordFormKey.currentState != null;

    //reseting everything in the form:
    if (isSigningUp) {
      signUpFormKey.currentState!.reset();
    }
    if (isForgettingPass) {
      forgetPasswordFormKey.currentState!.reset();
    }

    phoneState.updateIsErrorPhoneValidator(false);
  }

  //reset pass form:
  static void resetPassWordForm({
    GlobalKey<FormState>? loginFormKey,
    GlobalKey<FormState>? signUpFormKey,
    GlobalKey<FormState>? forgetPasswordFormKey,
  }) {
    var passwordState =
        kNavigatorKey.currentContext!.read<PasswordFormProviderState>();
    //reseting everything in the form:
    var isLoggingIn = loginFormKey != null && loginFormKey.currentState != null;
    var isSigningUp =
        signUpFormKey != null && signUpFormKey.currentState != null;
    var isForgettingPass = forgetPasswordFormKey != null &&
        forgetPasswordFormKey.currentState != null;
    if (isLoggingIn) {
      loginFormKey.currentState!.reset();
    }

    if (isSigningUp) {
      signUpFormKey.currentState!.reset();
    }
    if (isForgettingPass) {
      forgetPasswordFormKey.currentState!.reset();
    }

    passwordState.updateIsErrorConfirmPassFormValidator(false);
    passwordState.updateIsErrorPassFormValidator(false);
    passwordState.updatePassword("");
    passwordState.updateIsObscurePassword(true);
    passwordState.updateIsObscureConfirmPassword(true);
  }

  static void resetVerifications({bool isResettingFromForgetPass = false}) {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    var provider = ProviderHelperFunctions.verifyCodeProvider;

    provider.updateIsCountingDown(false);

    provider.updateIsFromLogin(false);

    if (isResettingFromForgetPass) {
      provider.updateIsFromForgetPass(false);
    }
  }
}
