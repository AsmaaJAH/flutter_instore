//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';
import 'package:instore/control_layer/functions/authentication_functions/submit.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/control_layer/functions/user_current_status.dart';
import 'package:instore/my_app.dart';
import 'package:instore/data_layer/models/response_wrapper_model.dart';
import 'package:instore/presentation_layer/app_snack_bar.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_assistant_values/server_constants.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';
import 'package:instore/control_layer/managers/shared_pref_manager.dart';
import 'package:instore/data_layer/models/user_model.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/forget_password_second_screen.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/login_screen.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/verify_code_screen.dart';
import 'package:instore/presentation_layer/screens/presist_tab_view.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/control_layer/functions/authentication_functions/forms_reset.dart';

class SuccessActions {
  SuccessActions._();
  static SharedPrefManager sharedPrefManager = SharedPrefManager();

//--------------------------------------  login Success Action: -------------------------------------------
  static dynamic loginSuccessAction(
      ResponseWrapperModel responseWrapperModel) async {
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      debugPrint(
        "((----------------- Access Token ---------))${responseWrapperModel.responseBody['access_token']}",
      );

      sharedPrefManager.setString(
        key: ServerConstants.accessTokenKEY,
        value: responseWrapperModel.responseBody['access_token'],
      );
      await sharedPrefManager.setBool(
        key: ServerConstants.isLoggedInBoolKEY,
        value: true,
      );

      sharedPrefManager.setString(
        key: ServerConstants.phoneKEY,
        value: responseWrapperModel.responseBody['data']['attributes']
                ['phone_number']
            .toString(),
      );
      sharedPrefManager.setString(
        key: ServerConstants.countryCodeKEY,
        value: responseWrapperModel.responseBody['data']['attributes']
                ['country_code']
            .toString(),
      );
      sharedPrefManager.setString(
        key: ServerConstants.emailKEY,
        value: responseWrapperModel.responseBody['data']['attributes']['email']
            .toString(),
      );

      // sharedPrefManager.setString(
      //   key: ServerConstants.userIdKEY,
      //   value: responseWrapperModel.responseBody['data']['id'].toString(),
      // );

      // sharedPrefManager.setString(
      //   key: ServerConstants.userTypeKEY,
      //   value: responseWrapperModel.responseBody['data']['type'].toString(),
      // );

      //printing the saved values:
      await sharedPrefManager
          .getString(key: ServerConstants.accessTokenKEY)
          .then((value) => {
                debugPrint(
                    "((-------------------The Saved access token ---------)) $value"),
              });
      // await sharedPrefManager.getString(key: ServerConstants.userIdKEY).then(
      //       (value) => {
      //         debugPrint("((-----------the saved user id -----------)) $value"),
      //       },
      //     );

      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.accountProvider,
      );
      ProviderHelperFunctions.accountProvider.updateAuthMode(
        AuthMode.authorized,
      );
      bool isVerified = responseWrapperModel.responseBody['data']['attributes']
          ["is_verified"];
      sharedPrefManager.setBool(
        key: ServerConstants.isVerifiedKEY,
        value: isVerified,
      );
      if (isVerified) {
        Navigator.pushAndRemoveUntil(
          kNavigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const PresistTabView(),
          ),
          (route) => false,
        );
      } else {
        ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.loginProvider,
        );
        ProviderHelperFunctions.loginProvider.updateUserModel(
          UserModel().extractUserModel(
            responseWrapper: responseWrapperModel,
            currentOperation: Variables.loginProvider,
          ),
        );
        ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.verifyCodeProvider,
        );
        ProviderHelperFunctions.verifyCodeProvider.updateIsFromLogin(true);
        ProviderHelperFunctions.verifyCodeProvider.updateIsCountingDown(true);
        ProviderHelperFunctions.verifyCodeProvider
            .updateIsFromForgetPass(false);
        var phone = await UserCurrentStatus.displayedPhoneOnScreen;
        ProviderHelperFunctions.verifyCodeProvider.updateDisplayedPhone(phone);
        Submit.sendVerificationCode();
      }
    }
  }

//-------------------------------------------- Sign Up Success Action:--------------------------------------------
  static dynamic signUpSuccessAction(ResponseWrapperModel responseWrapper) {
    UserData responseUserData = UserData().extractUserData(
      responseWrapper: responseWrapper,
      currentOperation: Variables.signupProvider,
    );
    // sharedPrefManager.setBool(
    //   key: ServerConstants.isVerifiedKEY,
    //   value: responseUserData.attributes != null &&
    //           responseUserData.attributes!.isVerified != null
    //       ? responseUserData.attributes!.isVerified!
    //       : false,
    // );

    // sharedPrefManager.setString(
    //   key: ServerConstants.userIdKEY,
    //   value: responseUserData.userID != null ? responseUserData.userID! : "",
    // );

    // //print:
    // await sharedPrefManager.getString(key: ServerConstants.userIdKEY).then(
    //       (value) => {
    //         debugPrint("((---------- the saved user id --------)) $value"),
    //       },
    //     );

    // sharedPrefManager.setString(
    //   key: ServerConstants.userTypeKEY,
    //   value:
    //       responseUserData.userType != null ? responseUserData.userType! : "",
    // );

    sharedPrefManager.setString(
      key: ServerConstants.countryCodeKEY,
      value: responseUserData.attributes != null
          ? responseUserData.attributes!.countryCode!
          : "",
    );
    sharedPrefManager.setString(
      key: ServerConstants.phoneKEY,
      value: responseUserData.attributes != null
          ? responseUserData.attributes!.phoneNumber!
          : "",
    );
    sharedPrefManager.setString(
      key: ServerConstants.emailKEY,
      value: responseUserData.attributes != null
          ? responseUserData.attributes!.email!
          : "",
    );

    ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.signupProvider);
    ProviderHelperFunctions.signupProvider.updateUserModel(
      UserModel(
        userData: responseUserData,
      ),
    );
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.verifyCodeProvider,
      );
      ProviderHelperFunctions.verifyCodeProvider.updateIsCountingDown(true);
      //comment this below line if u wanna:
      ProviderHelperFunctions.verifyCodeProvider.updateIsFromForgetPass(false);
      //navigator:
      Navigator.of(kNavigatorKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => const VerifyCodeScreen(),
        ),
      );
    }
  }

  //------------------------------ Verification Success Action -------------------------
  static dynamic sendVerificationCodeMessageSuccessAction() {
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.verifyCodeProvider,
      );
      bool isFromLogIn = ProviderHelperFunctions.verifyCodeProvider.isFromLogin;
      if (isFromLogIn) {
        Navigator.pushAndRemoveUntil(
          kNavigatorKey.currentContext!,
          MaterialPageRoute(
            builder: (context) => const VerifyCodeScreen(),
          ),
          (route) => false,
        );
      } else {
        //navigator:
        Navigator.of(kNavigatorKey.currentContext!).push(
          MaterialPageRoute(
            builder: (context) => const VerifyCodeScreen(),
          ),
        );
      }
      AppSnackBar(
        context: kNavigatorKey.currentContext!,
        message: LocaleKeys.verifyCodeSendSuccessfully,
      ).showAppSnackBar();
    }
  }

  static dynamic verifyAccountDoneButtonSuccessAction(
    ResponseWrapperModel responseWrapper,
  ) async {
    sharedPrefManager.setString(
      key: ServerConstants.verifyTokenKEY,
      value: responseWrapper.responseBody['token'],
    );

    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.accountProvider,
    );

    ProviderHelperFunctions.accountProvider.updateAuthMode(AuthMode.authorized);

    //print:
    await sharedPrefManager.getString(key: ServerConstants.verifyTokenKEY).then(
          (value) => {
            debugPrint("(( --------the saved verifiy token -------- )) $value"),
          },
        );

    //if previous page is forget password:
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    bool isPreviousPageForgetPassword =
        ProviderHelperFunctions.verifyCodeProvider.isFromForgetPassword;
    bool isPreviousPageLogin =
        ProviderHelperFunctions.verifyCodeProvider.isFromLogin;

    if (isPreviousPageForgetPassword) {
      Navigator.of(kNavigatorKey.currentContext!).push(
        MaterialPageRoute(
          builder: (context) => const ForgetPasswordSecondScreen(),
        ),
      );
    } else if (isPreviousPageLogin) {
      //to keep the user logged in, as it won't change at the backend response until we receive another log in response with the new updates of the user verification state:
      await sharedPrefManager.setBool(
        key: ServerConstants.isVerifiedKEY,
        value: true,
      );
      Navigator.pushAndRemoveUntil(
        kNavigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (context) => const PresistTabView(),
        ),
        (route) => false,
      );
    } else {
      //if previous page is sign up password:
      Submit.login(isLoginAfterSignUp: true);
    }
    FormsReset.resetVerifications(isResettingFromForgetPass: true);
  }

  static dynamic resendVerificationCodeSuccessAction(
    ResponseWrapperModel responseWrapper,
  ) {
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      AppSnackBar(
        context: kNavigatorKey.currentContext!,
        message: LocaleKeys.verifyCodeResendSuccessfully,
        //contentHeight: kScreenHeight * 0.07,
      ).showAppSnackBar();
    }
  }

//-------------------------------------------- Forget Password Success Action:--------------------------------------------
  static dynamic forgetPasswordSuccessAction(
    ResponseWrapperModel responseWrapper,
  ) {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.forgetPassProvider,
    );
    ProviderHelperFunctions.forgetPasswordProvider.updateUserModel(
      UserModel().extractUserModel(
        responseWrapper: responseWrapper,
        currentOperation: Variables.forgetPassProvider,
      ),
    );
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      // reset everything :
      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.verifyCodeProvider,
      );
      ProviderHelperFunctions.verifyCodeProvider.updateIsFromForgetPass(false);
    }
    //navigator:
    Navigator.pushAndRemoveUntil(
      kNavigatorKey.currentContext!,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
      (route) => false,
    );
  }
}
