import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';
import 'package:instore/data_layer/models/device_model.dart';
import 'package:instore/data_layer/models/response_wrapper_model.dart';

class UserModel {
  UserModel({
    this.userData,
    this.userDevice,
    this.accessToken,
    this.firebaseAuthToken,
  });
  UserData? userData;
  DeviceModel? userDevice;

  String? accessToken;
  String? firebaseAuthToken;

  UserModel extractUserModel({
    required ResponseWrapperModel responseWrapper,
    required String currentOperation,
  }) {
    return UserModel(
      userData: UserData().extractUserData(
        responseWrapper: responseWrapper,
        currentOperation: currentOperation,
      ),
      userDevice: DeviceModel(
        deviceID: responseWrapper.responseBody["device"]['id'],
        localization: responseWrapper.responseBody["device"]['locale'],
        firebaseAuthToken: responseWrapper.responseBody["device"]
            ['firebase_auth_token'],
        isLoggedOut: responseWrapper.responseBody["device"]['logged_out'],
      ),
      accessToken: responseWrapper.responseBody["access_token"],
      firebaseAuthToken: responseWrapper.responseBody["firebase_auth_token"],
    );
  }
}

class UserData {
  UserData({
    this.userID,
    this.userType,
    this.attributes,
    this.relationships,
  });
  String? userID;
  String? userType;
  UserAttributesModel? attributes;
  UserRelationships? relationships;

  UserData extractUserData({
    required ResponseWrapperModel responseWrapper,
    required String currentOperation,
  }) {
    var password = "";

    if (currentOperation == Variables.signupProvider) {
      ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.signupProvider);
      password = ProviderHelperFunctions.signupProvider.password.text
          .toString()
          .trim();
    } else if (currentOperation == Variables.forgetPassProvider) {
      ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.forgetPassProvider);
      password =
          ProviderHelperFunctions.forgetPasswordProvider.enteredPassword.trim();
    } else if (currentOperation == Variables.loginProvider) {
      ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.loginProvider);
      password = ProviderHelperFunctions.loginProvider.enteredPassword.trim();
    }
    UserData responseUserData = UserData(
      userID: responseWrapper.responseBody["data"]['id'],
      userType: responseWrapper.responseBody["data"]['type'],
      attributes: UserAttributesModel(
        password: password,
        passwordConfirmation: password,
        name: responseWrapper.responseBody["data"]['attributes']['name'],
        email: responseWrapper.responseBody["data"]['attributes']['email'],
        phoneNumber: responseWrapper.responseBody["data"]['attributes']
            ['phone_number'],
        countryCode: responseWrapper.responseBody["data"]['attributes']
            ['country_code'],
        storeCredits: responseWrapper.responseBody["data"]['attributes']
            ['store_credits'],
        completedOrders: responseWrapper.responseBody["data"]['attributes']
            ['completed_orders'],
        image: responseWrapper.responseBody["data"]['attributes']['image'],
        firebaseUID: responseWrapper.responseBody["data"]['attributes']
            ['firebase_uid'],
        provider: responseWrapper.responseBody["data"]['attributes']
            ['provider'],
        isEmailVerified: responseWrapper.responseBody["data"]['attributes']
            ['is_email_verified'],
        isMobileVerified: responseWrapper.responseBody["data"]['attributes']
            ['is_mobile_verified'],
        isVerified: responseWrapper.responseBody["data"]['attributes']
            ['is_verified'],
        vendor: responseWrapper.responseBody["data"]['attributes']['vendor'],
      ),
      relationships: UserRelationships(
        defaulBillingAddress: responseWrapper.responseBody["data"]
            ['relationships']['default_billing_address'],
        defaultShippingAddress: responseWrapper.responseBody["data"]
            ['relationships']['default_shipping_address'],
      ),
    );
    return responseUserData;
  }
}

class UserAttributesModel {
  UserAttributesModel({
    this.name,
    this.countryCode,
    this.phoneNumber,
    this.password,
    this.passwordConfirmation,
    this.email,
    this.isEmailVerified,
    this.completedOrders,
    this.firebaseUID,
    this.image,
    this.isMobileVerified,
    this.isVerified,
    this.provider,
    this.storeCredits,
    this.vendor,
  });

  Map? vendor;

  int? storeCredits;
  int? completedOrders;

  String? name;
  String? email;
  String? countryCode;
  String? phoneNumber;
  String? password;
  String? passwordConfirmation;
  String? image;
  String? firebaseUID;
  String? provider;

  bool? isEmailVerified;
  bool? isMobileVerified;
  bool? isVerified;

  UserAttributesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    email = json['email'];
    image = json['image'];
    isEmailVerified = json['is_email_verified'];
    isMobileVerified = json['is_mobile_verified'];
    isVerified = json['is_verified'];
    completedOrders = json['completed_orders'];
    firebaseUID = json['firebase_uid'];
    provider = json['no_provider'];
    storeCredits = json['store_credits'];
    vendor = json['vendor'];
  }

  Map<String, dynamic> toJson({
    bool isNameExist = false,
    bool isPhoneNumberExist = false,
    bool isMobileNumberExist = false,
    bool isCountryCodeExist = false,
    bool isPassWordExist = false,
    bool isPassConfirmExist = false,
    bool isEmailExist = false,
    bool isImageExist = false,
    bool isEmailVerifyExist = false,
    bool isPhoneVerifyExist = false,
    bool isVerifyExist = false,
    bool isCompeleteOrderExist = false,
    bool isfirebaseUIDExist = false,
    bool isVendorExist = false,
    bool isStoreCreditsExist = false,
    bool isProviderExist = false,
  }) {
    final map = <String, dynamic>{};
    if (isNameExist) map['name'] = name;
    if (isCountryCodeExist) map['country_code'] = countryCode;
    if (isPhoneNumberExist) map['phone_number'] = phoneNumber;
    if (isMobileNumberExist) map['mobile_number'] = phoneNumber;
    if (isPassWordExist) map['password'] = password;
    if (isPassConfirmExist) map['password_confirmation'] = passwordConfirmation;
    if (isEmailExist) map['email'] = email;
    if (isImageExist) map['image'] = image;
    if (isEmailVerifyExist) map['is_email_verified'] = isEmailVerified;
    if (isPhoneVerifyExist) map['is_mobile_verified'] = isMobileVerified;
    if (isVerifyExist) map['is_verified'] = isVerified;
    if (isCompeleteOrderExist) map['completed_orders'] = completedOrders;
    if (isfirebaseUIDExist) map['firebase_uid'] = firebaseUID;
    if (isProviderExist) map['no_provider'] = provider;
    if (isStoreCreditsExist) map['store_credits'] = storeCredits;
    if (isVendorExist) map['vendor'] = vendor;

    return map;
  }
}

class UserRelationships {
  UserRelationships({
    this.defaulBillingAddress,
    this.defaultShippingAddress,
  });
  Map? defaulBillingAddress;
  Map? defaultShippingAddress;
}







//var create_account_response={
//     "data": {
//         "id": "101",
//         "type": "custom_user",
//         "attributes": {
//             "email": "ahmed.medhat.inovaeg011@gmail.com",
//             "store_credits": 0,
//             "completed_orders": 0,
//             "name": "ahmed",
//             "country_code": "20",
//             "phone_number": "1063424075",
//             "image": null,
//             "firebase_uid": null,
//             "provider": "no_provider",
//             "is_email_verified": false,
//             "is_mobile_verified": false,
//             "is_verified": false,
//             "vendor": null
//         },
//         "relationships": {
//             "default_billing_address": {
//                 "data": null
//             },
//             "default_shipping_address": {
//                 "data": null
//             }
//         }
//     }
// } 
//








//var login_Response={
//     "data": {
//         "id": "30",
//         "type": "custom_user",
//         "attributes": {
//             "email": "ahmed.medhat.inovaeg2@gmail.com",
//             "store_credits": 0,
//             "completed_orders": 0,
//             "name": "Ahmed",
//             "country_code": null,
//             "phone_number": "1063424070",
//             "image": null,
//             "firebase_uid": "nfEsXWAB5jQkphagWHOorr0YIPC3",
//             "provider": "no_provider",
//             "is_email_verified": false,
//             "is_mobile_verified": false,
//             "is_verified": false,
//             "vendor": {
//                 "id": 12,
//                 "is_verified": false,
//                 "about": null,
//                 "company_name": "Test",
//                 "commercial_number": "2134564454",
//                 "tax_id": "562221545545",
//                 "company_description": "kjknoknko",
//                 "status": "pending",
//                 "company_logo": "https://esolarbucket.s3.eu-central-1.amazonaws.com/staging/H3O2rqh5F8Sftvt5dn1bnQ_2023-05-23%2009%3A57%3A00%20%2B0000.webp",
//                 "rating": "0.0",
//                 "count": 0,
//                 "website": null,
//                 "founded_in": null,
//                 "headquarters": null,
//                 "subscription": {
//                     "id": 1,
//                     "tier": 1,
//                     "name": "Silver"
//                 },
//                 "vendor_types": [
//                     {
//                         "id": 1,
//                         "name": "Supplier"
//                     },
//                     {
//                         "id": 2,
//                         "name": "Constructor"
//                     }
//                 ],
//                 "tax_certificate": null,
//                 "commercial_certificates": null,
//                 "branches": []
//             }
//         },
//         "relationships": {
//             "default_billing_address": {
//                 "data": null
//             },
//             "default_shipping_address": {
//                 "data": null
//             }
//         }
//     },
//
//
///////
//
//     "access_token": "eyJhbGciOiJIUzI1NiJ9.eyJhdXRoZW50aWNhYmxlX2lkIjozMCwiYXV0aGVudGljYWJsZV90eXBlIjoiU3ByZWU6OlVzZXIiLCJkZXZpY2UiOjQ2LCJjcmVhdGVkX2F0IjoxNjkzOTg4MzAxLCJleHAiOjQ4NDk2ODM1MDF9.XB7r8sbN36Sr97SscDKS04tY2YHV3t9gZ4FMDiULBYE",
//     "device": {
//         "id": 46,
//         "locale": "en",
//         "logged_out": false,
//         "firebase_auth_token": "1UHAR6Bo69WFZ5ih9sdt4CTbzRE2"
//     },
//     "firebase_auth_token": "eyJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay10ZThjcUBob21lc2RlLTZlMmI5LmlhbS5nc2VydmljZWFjY291bnQuY29tIiwic3ViIjoiZmlyZWJhc2UtYWRtaW5zZGstdGU4Y3FAaG9tZXNkZS02ZTJiOS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHl0b29sa2l0Lmdvb2dsZWFwaXMuY29tL2dvb2dsZS5pZGVudGl0eS5pZGVudGl0eXRvb2xraXQudjEuSWRlbnRpdHlUb29sa2l0IiwiaWF0IjoxNjkzOTg4MzAxLCJleHAiOjE2OTM5OTE5MDEsInVpZCI6Im5mRXNYV0FCNWpRa3BoYWdXSE9vcnIwWUlQQzMiLCJjbGFpbXMiOnsicHJlbWl1bV9hY2NvdW50IjpmYWxzZX19.X9_xAVjbCAiHwdbE_SQ0afa2s9QxYqNOfBHsgh6djoOSCmR0WVEFcl7d6brE736OeSE555UfJjKlwteCwEMXI_vU2mJS3MhPTbCvhOC48APtByIIMmnXACgVDrk5gErYzAnjnpFiPGw-Veo9hWEohQXk-WVL2EPpLPAt61fvkmBqCy8g0f2QrdBBf_D07eeQOgEmCju02gutTXtNxS0Vi_KvThsCtJHAbP_GxVKBnpd-GOwCIK8xa8y91Vxe47p9rvN_QSEN4HdpeXpuiWGnq_M0nxlXobPwVu_GU3Y6fUlcpUWEZy6wNWtn57vK65_k4Q1KGzSJwARtaVyhWgoQWA"
// ///
// 
// 
// 
// };