class ServerConstants {
  const ServerConstants._();
  //------------------------API Remote Server Constants----------------------------
  //---main uri:
  static const String baseUri = "http://18.196.56.240";
  static const String apiVersion = "/api/v2";
  static const String auth = "/auth/";
  static const String mainUri = "$baseUri/$apiVersion";
  static const String loginExtension = "$apiVersion/login";
  static const String signupExtension = "$apiVersion/storefront/account";
  static const String sendVerifyCodeExtension =
      "$apiVersion/$auth/send_verification_message";
  static const String verifyOTPextension = "$apiVersion/$auth/verify_otp";
  static const String forgetPassExtension = "$apiVersion/$auth/reset_password";

  //---languages code:
  static String currentLanguageCode = "";

  //--- backend code scope:
  static String verificationCodeScope = "verification";
  static String resetPassCodeScope = "reset_password";
  //-- backend common error messages:
  static String downSMSservice =
      "Invalid victorylink response"; //phone nuber is wrong or the SMS service is now down
  static String codeExpired = "Code Expired";

  //-----------------------------Firebase Server----------------------------------
  static String dummyFCMtoken = "1UHAR6Bo69WFZ5ih9sdt4CTbzRE2";

  //------------------------ Device Strorage Local Server -----------------
  //-------- shared prefernces internal database:
  //the shared-pref keys:
  static const String accessTokenKEY = "TokenKEYinStore";
  static const String verifyTokenKEY = "VerificationTokenKEYinStore";
  static const String isLoggedInBoolKEY = "isLoggedinKEYinStore";
  static const String userIdKEY = "userIdKEYinStore";
  static const String userTypeKEY = "userTypeKEYinStore";
  static const String languageCodeKEY = "languageCodeKEYinStore";
  static const String isVerifiedKEY = "isVerifiedKEYinStore";
  static const String countryCodeKEY = "countryCodeKEYinStore";
  static const String phoneKEY = "phoneKEYinStore";
  static const String emailKEY = "emailKEYinStore";

  //the shared-pref Data:
  static String currentSharedPrefToken = "";
  static late bool isVerified;
}
