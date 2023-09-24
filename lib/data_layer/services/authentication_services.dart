//-------------------------- Flutter Packages Imports ----------------------------------

import 'dart:convert';
import 'package:flutter/cupertino.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_assistant_values/server_constants.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/control_layer/functions/device_info.dart';
import 'package:instore/data_layer/api_helper.dart';
import 'package:instore/data_layer/models/device_model.dart';
import 'package:instore/data_layer/models/response_wrapper_model.dart';
import 'package:instore/control_layer/functions/api_assistant/assist_apihelper.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';

class AuthenticationService {
  final ApiHelper _apiHelper = ApiHelper();
//=====================================================================================
//------------------------------------------log in-------------------------------------
//=====================================================================================

  Future<ResponseWrapperModel?> login({
    required bool isLoginAfterSignUp,
  }) async {
    Map<String, dynamic> postBody =
        await getLoginBody(isLoginAfterSignUp: isLoginAfterSignUp);
    var operation = Variables.loginProvider;
    if (isLoginAfterSignUp) {
      operation = Variables.loginAfterSignup;
    }
    debugPrint(
        "((-----------------[$operation body]-------------))${json.encode(postBody)}");

    ResponseWrapperModel? response = await _apiHelper.postRequest(
      extensionURI: ServerConstants.loginExtension,
      requestBody: json.encode(postBody),
    );

    return response;
  }

  Future<Map<String, dynamic>> getLoginBody({
    required bool isLoginAfterSignUp,
  }) async {
    var fcmToken = await AssistApiHelper.getFCMToken();
    //var fcmToken = ServerConstants.dummyFCMtoken;
    DeviceModel device = DeviceModel(
      timeZone: DeviceInfo.currentDeviceInfo.timeZone,
      deviceType: DeviceInfo.currentDeviceInfo.deviceType,
      firebaseAuthToken: fcmToken,
      localization: ServerConstants.currentLanguageCode,
    );
    ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.loginProvider);
    var provider = ProviderHelperFunctions.loginProvider;
    return {
      "username": isLoginAfterSignUp
          ? provider.loginAfterSignupAttributes.email
          : provider.userAttributesModel.email,
      "password": isLoginAfterSignUp
          ? provider.loginAfterSignupAttributes.password
          : provider.userAttributesModel.password,
      "device": device.toJson(
        isfirebaseTokenExist: true,
      )
    };
  }

//--------------------------------  Sign up ---------------------------------------
  Future<ResponseWrapperModel?> signUp() async {
    Map<String, dynamic> postBody = await getSignupBody();
    debugPrint(
        "((------------------*[create account body]*--------------))$postBody");
    ResponseWrapperModel? response = await _apiHelper.postRequest(
      extensionURI: ServerConstants.signupExtension,
      requestBody: json.encode(postBody),
    );

    return response;
  }

  Future<Map<String, dynamic>> getSignupBody() async {
    ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.signupProvider);
    return {
      "user": ProviderHelperFunctions.signupProvider.userAttributes.toJson(
        isNameExist: true,
        isEmailExist: true,
        isPhoneNumberExist: true,
        isCountryCodeExist: true,
        isPassWordExist: true,
        isPassConfirmExist: true,
      ),
    };
  }
//=====================================================================================
//----------------------------- Verification ------------------------------------------
//=====================================================================================

//----- the api of "sendVerificationCode" ,once the verification code screen is created: ----------------
  Future<ResponseWrapperModel?> sendVerificationCode() async {
    Map<String, dynamic> postBody = await getVerificationCodeBody();
    debugPrint(
        "((-----------------['send verification code message' body]-------------))${json.encode(postBody)}");

    ResponseWrapperModel? response = await _apiHelper.postRequest(
      extensionURI: ServerConstants.sendVerifyCodeExtension,
      requestBody: json.encode(postBody),
    );
    return response;
  }

  Future<Map<String, dynamic>> getVerificationCodeBody() async {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    bool isFromLogin = ProviderHelperFunctions.verifyCodeProvider.isFromLogin;
    bool isFromForgetPassword =
        ProviderHelperFunctions.verifyCodeProvider.isFromForgetPassword;

    if (isFromForgetPassword) {
      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.forgetPassProvider,
      );
      return {
        "user": {
          "country_code": ProviderHelperFunctions
              .forgetPasswordProvider.enteredCountryCode
              .toString()
              .trim(),
          "mobile_number":
              ProviderHelperFunctions.forgetPasswordProvider.enteredPhone.trim()
          // "email": "spree@example.com"
        },
        "code_scope": ServerConstants.resetPassCodeScope
      };
    } else if (isFromLogin) {
      //previous page is log in and didn't verify his info yet:
      ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.loginProvider);
      return {
        "user": ProviderHelperFunctions
            .loginProvider.userModel.userData!.attributes!
            .toJson(
          isCountryCodeExist: true,
          isEmailExist: true,
          isMobileNumberExist: true,
        ),
        "code_scope": ServerConstants.verificationCodeScope
      };
    } else {
      //previous page is sign up:
      ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.signupProvider);
      return {
        "user": ProviderHelperFunctions.signupProvider.userAttributes.toJson(
          isCountryCodeExist: true,
          isEmailExist: true,
          isMobileNumberExist: true,
        ),
        "code_scope": ServerConstants.verificationCodeScope
      };
    }
  }

//----- the api of "verifyAccount" Done button: -------------------------------------
  Future<ResponseWrapperModel?> verifyAccount() async {
    await AssistApiHelper.getUpToDateHeaders();
    Map<String, String>? headers = {
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": "application/json",
      "Accept-Language": ServerConstants.currentLanguageCode,
      "Timezone": DeviceInfo.currentDeviceInfo.timeZone!,
    };
    Map<String, dynamic> postBody = await getVerifyOTPbody();
    debugPrint(
        "((-----------------['verify OTP'api body]-------------))${json.encode(postBody)}");

    ResponseWrapperModel? response = await _apiHelper.postRequest(
      extensionURI: ServerConstants.verifyOTPextension,
      requestBody: json.encode(postBody),
      customizedHeaders: headers,
    );
    return response;
  }

  Future<Map<String, dynamic>> getVerifyOTPbody() async {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.pinCodeProvider,
    );
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    bool isFromForgetPassword =
        ProviderHelperFunctions.verifyCodeProvider.isFromForgetPassword;
    bool isFromLogin = ProviderHelperFunctions.verifyCodeProvider.isFromLogin;

    if (isFromForgetPassword) {
      return {
        "code_scope": ServerConstants.resetPassCodeScope,
        "verification_code": ProviderHelperFunctions.pinCodeProvider.pinCode,
        "user": {
          "country_code": ProviderHelperFunctions
              .forgetPasswordProvider.enteredCountryCode
              .toString()
              .trim(),
          "mobile_number":
              ProviderHelperFunctions.forgetPasswordProvider.enteredPhone.trim()
          // "email": "spree@example.com"
        }
      };
    } else if (isFromLogin) {
      //previous page is log in:
          ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.loginProvider,
    );
      return {
        "code_scope": ServerConstants.verificationCodeScope,
        "verification_code": ProviderHelperFunctions.pinCodeProvider.pinCode,
        "user": ProviderHelperFunctions.loginProvider.userModel.userData!.attributes!.toJson(
          isCountryCodeExist: true,
          isMobileNumberExist: true,
          isEmailExist: true,
        ),
      };
    } else {
          //previous page is sign up:
   ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.signupProvider,
    );
      return {
        "code_scope": ServerConstants.verificationCodeScope,
        "verification_code": ProviderHelperFunctions.pinCodeProvider.pinCode,
        "user": ProviderHelperFunctions.signupProvider.userAttributes.toJson(
          isCountryCodeExist: true,
          isMobileNumberExist: true,
          isEmailExist: true,
        ),
      };
    }
  }
//============================================================================
//--------------------------------- Forget Password --------------------------
//=============================================================================

  Future<ResponseWrapperModel?> forgetPassword() async {
    await AssistApiHelper.getUpToDateHeaders();
    Map<String, String>? headers = {
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Content-type": "application/json",
      "Accept-Language": ServerConstants.currentLanguageCode,
      "Authorization": "Bearer ${ServerConstants.currentSharedPrefToken}",
      "verification-token": ServerConstants.currentSharedPrefToken,
    };
    Map<String, dynamic> postBody = await getForgetPassBody();
    debugPrint(
        "((-----------------[Forget password body]-------------))${json.encode(postBody)}");

    ResponseWrapperModel? response = await _apiHelper.postRequest(
      extensionURI: ServerConstants.forgetPassExtension,
      requestBody: json.encode(postBody),
      customizedHeaders: headers,
    );

    return response;
  }

  Future<Map<String, dynamic>> getForgetPassBody() async {
    var fcmToken = await AssistApiHelper.getFCMToken();
    //var fcmToken = ServerConstants.dummyFCMtoken;
    DeviceModel device = DeviceModel(
      firebaseAuthToken: fcmToken,
    );
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.forgetPassProvider,
    );
    return {
      "user":
          ProviderHelperFunctions.forgetPasswordProvider.userAttributes.toJson(
        isCountryCodeExist: true,
        isEmailExist: true,
        isMobileNumberExist: true,
        isPassConfirmExist: true,
        isPassWordExist: true,
      ),
      "device": device.toJson(
        isfirebaseTokenExist: true,
      )
    };
  }
}
