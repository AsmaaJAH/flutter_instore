//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/control_layer/functions/api_assistant/request_assistant.dart';
import 'package:instore/control_layer/functions/authentication_functions/success_actions.dart';
import 'package:instore/data_layer/models/user_model.dart';
import 'package:instore/data_layer/repositories/authentication_repository.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';

class Submit {
  Submit._();

  static final AuthenticationRepository authenticationRepository =
      AuthenticationRepository();
//------------------------------- Log in -------------------------------------
  static void login({
    required bool isLoginAfterSignUp,
  }) async {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.loginProvider,
    );
    debugPrint("-------------- submit log in -------------");
    debugPrint("isLoginAfterSignUp: $isLoginAfterSignUp");

    if (isLoginAfterSignUp) {
      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.signupProvider,
      );
      debugPrint(
          "-----------hereeeeeee----------${ProviderHelperFunctions.signupProvider.userModel.userData!.attributes!.email!.trim()}${ProviderHelperFunctions.signupProvider.userModel.userData!.attributes!.password!.trim()}");
      ProviderHelperFunctions.loginProvider.putInfoOfLoginAfterSignup(
        UserAttributesModel(
          email: ProviderHelperFunctions
              .signupProvider.userModel.userData!.attributes!.email!
              .trim(),
          password: ProviderHelperFunctions
              .signupProvider.userModel.userData!.attributes!.password!
              .trim(),
        ),
      );
    } else {
      ProviderHelperFunctions.loginProvider.putUserInfo(
        UserAttributesModel(
          email: ProviderHelperFunctions.loginProvider.email.text.trim(),
          password: ProviderHelperFunctions.loginProvider.password.text.trim(),
        ),
      );
    }

    RequestAssistant.makeRequest(
      requestFunction: () async => authenticationRepository.login(
          isLoginAfterSignUp: isLoginAfterSignUp),
      successAction: (responseValue) =>
          SuccessActions.loginSuccessAction(responseValue),
    );
  }

//--------------------------- Create account ----------------------------------
  static Future<void> signUp() async {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.signupProvider,
    );

    ProviderHelperFunctions.signupProvider.putUserInfo(
      UserAttributesModel(
        name: ProviderHelperFunctions.signupProvider.name.text.trim(),
        email: ProviderHelperFunctions.signupProvider.email.text.trim(),
        password: ProviderHelperFunctions.signupProvider.password.text.trim(),
        passwordConfirmation:
            ProviderHelperFunctions.signupProvider.password.text.trim(),
        phoneNumber: ProviderHelperFunctions.signupProvider.phone.text.trim(),
        countryCode: ProviderHelperFunctions.signupProvider.countryCode
            .toString()
            .trim(),
      ),
    );

    RequestAssistant.makeRequest(
      requestFunction: () async => authenticationRepository.signUp(),
      successAction: (responseValue) =>
          SuccessActions.signUpSuccessAction(responseValue),
    );
  }

//----------------------- Verification ------------------------------------------
  static void sendVerificationCode() {
    RequestAssistant.makeRequest(
      requestFunction: () async =>
          authenticationRepository.sendVerificationCode(),
      successAction: (responseValue) =>
          SuccessActions.sendVerificationCodeMessageSuccessAction(),
    );
  }

  static void verifyAccountDoneButton() {
    RequestAssistant.makeRequest(
      requestFunction: () async =>
          await authenticationRepository.verifyAccount(),
      successAction: (responseValue) =>
          SuccessActions.verifyAccountDoneButtonSuccessAction(
        responseValue,
      ),
    );
  }

  static void resendCode() {
    ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.verifyCodeProvider);
    ProviderHelperFunctions.verifyCodeProvider.updateIsCountingDown(true);
    RequestAssistant.makeRequest(
      requestFunction: () async =>
          authenticationRepository.sendVerificationCode(),
      successAction: (responseValue) =>
          SuccessActions.resendVerificationCodeSuccessAction(
        responseValue,
      ),
    );
  }

//--------------------------------Forget password ------------------------------
  static void forgetPassword() async {
    ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.forgetPassProvider);

    ProviderHelperFunctions.forgetPasswordProvider.putUserInfo(
      UserAttributesModel(
        //email: ,
        countryCode: ProviderHelperFunctions
            .forgetPasswordProvider.enteredCountryCode
            .toString()
            .trim(),
        phoneNumber:
            ProviderHelperFunctions.forgetPasswordProvider.enteredPhone,
        password: ProviderHelperFunctions.forgetPasswordProvider.enteredPassword
            .trim(),
        passwordConfirmation: ProviderHelperFunctions
            .forgetPasswordProvider.enteredPassword
            .trim(),
      ),
    );

    RequestAssistant.makeRequest(
      requestFunction: () async => authenticationRepository.forgetPassword(),
      successAction: (responseValue) =>
          SuccessActions.forgetPasswordSuccessAction(responseValue),
    );
  }
}
