//Conventions contains const values or convenant-agreement variables
//that all the project developers agree on using them in the whole app
import 'package:flutter/material.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/translations/locale_keys.g.dart';

class Variables {
  //==================================================================
  //----------------------------- Strings-----------------------------
  //==================================================================

  static const String loginAfterSignup = "loginAfterSignup";

  //-------------------------our custom-app supported languages code:
  static const String enLangCode = "en";
  static const String arLangCode = "ar";
  static const String enCountryCode = "US";
  static const String arCountryCode = "SA";

  static const enUsLocale =
      Locale(Variables.enLangCode, Variables.enCountryCode);
  static const arSaLocale =
      Locale(Variables.arLangCode, Variables.arCountryCode);
//-------------------------phone country code:

  static const String egyptPhoneCode = "+20";
//-----------------------------------Presentation layer strings:
  static const String dummyOTPcode = 'I am a cute awesome code, write me here';
  //------------------------- Widgets:
  //---buttons:
  static const double buttonDefaultHeight = 44.0;
  static final double buttonDefaultwidth = kScreenWidth * 0.9;

  //--- TextFormField:
  static const double minTextFormFieldHeight =
      35.0; //--->kindly, don't edit this num or
  //don't make this height smaller than 35 ever never
  //, other wise, u will not match the design requirments in the whole app.

  //--- OverlayBuilder:
  static const dummyOverlayItems = [
    {"name": LocaleKeys.firstItem, "isSelected": true},
    {"name": LocaleKeys.secondItem, "isSelected": false}
  ];

  //--- Linear-circular indicator:
  static const double strokeAlignCenter = 0.0;
  //---------------------------------------------Data layer strings:
  //--- providers:
  static const String accountProvider = "accountProvider";
  static const String loginProvider = "login";
  static const String signupProvider = "signup";
  static const String forgetPassProvider = 'forgetpassword';
  static const String pinCodeProvider = 'pinCodeProvider';
  static const String verifyCodeProvider = "verifyCodeProvider";

//-----------------------------------------------------------------------------------------------
  //---------------------------- Authentication:
  //Regex expressions:
  static RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  static RegExp passwordRegex = RegExp(
      r"(?=.*?[0-9])(?=.*[A-Za-z])(?=.*?[!@)#-$=.%؟,-;:'&%>^+<~])(?=.*)(?=.*\W+)");
  // password checker will return a match if and only if the password contains : // Minimum 1 letter // Minimum 1 Numeric Number // Minimum 1 Special Character: ex---> Common Allow Character ( ! @ # $ & * ~ )
  //---------------------------- HomePage:
  //current card widget :
  static const String adBanner = "adBanner";
  static const String bestSeller = "bestSeller";
  static const String exploreVendors = "exploreVendors";

  //==================================================================
  //----------------------------- const doubles ---------------------------
  //==================================================================
  static const double double0_01 = 0.01;
  static const double double0_3 = 0.3;

  static const double double0_5 = 0.5;
  static const double double0_7 = 0.7;


  static const double zero = 0.0;
  static const double one = 1.0;
  static const double two = 2.0;
  static const double three = 3.0;
  static const double four = 4.0;
  static const double five = 5.0;
  static const double six = 6.0;
  static const double seven = 7.0;
  static const double eight = 8.0;
  static const double nine = 9.0;
  static const double ten = 10.0;
  static const double double11 = 11.0;
  static const double double12 = 12.0;
  static const double double13 = 13.0;
  static const double double14 = 14.0;
  static const double double14_4 = 14.4;

  static const double double15 = 15.0;
  static const double double16 = 16.0;
  static const double double17 = 17.0;
  static const double double18 = 18.0;
  static const double double19 = 19.0;
  static const double double20 = 20.0;

  static const double double22 = 22.0;

  static const double double23 = 23.0;

  static const double double24 = 24.0;

  static const double double26 = 26.0;

  static const double double28 = 28.0;

  static const double double30 = 30.0;

  static const double double32 = 32.0;

  static const double double35 = 35.0;

  static const double double37 = 37.0;

  static const double double44 = 44.0;

  static const double double60 = 60.0;

  static const double double65 = 65.0;

  static const double double70 = 70.0;
  static const double double100 = 100.0;
  static const double double110 = 110.0;

  static const double double150 = 150.0;
  static const double double160 = 160.0;

  static const double double200 = 200.0;
  static const double double250 = 250.0;
  static const double double300 = 300.0;

  //negative:
  static const double ngtveOne = -1.0;

  //==================================================================
  //----------------------------- integers ---------------------------
  //==================================================================
  static const int zeroInt = 0;
  static const int oneInt = 1;
  static const int twoInt = 2;
  static const int threeInt = 3;
  static const int fourInt = 4;
  static const int fiveInt = 5;
  static const int sixInt = 6;

  static const int int14 = 14;
  static const int int16 = 16;

  static const int int26 = 26;
  static const int int27 = 27;

  static const int int34 = 34;
  static const int int35 = 35;

  static const int int57 = 57;

  static const int int60 = 60;
  static const int int70 = 70;

  static const int int92 = 92;

  static const int int200 = 200;

  static const int int500 = 500;

  static const int int750 = 750;

  static const int int1000 = 1000;

  static const int int2000 = 2000;
  static const int int2200 = 2200;
  static const int int2500 = 2500;
}
