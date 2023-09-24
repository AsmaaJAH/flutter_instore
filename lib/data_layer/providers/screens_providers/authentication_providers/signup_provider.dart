//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/data_layer/models/user_model.dart';

class SignUpProviderState with ChangeNotifier, DiagnosticableTreeMixin {
  UserAttributesModel userAttributes = UserAttributesModel();

  UserModel userModel = UserModel();

  CountryCode countryCode = CountryCode.fromDialCode(
    Variables.egyptPhoneCode,
  );

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  void putUserInfo(UserAttributesModel model) {
    userAttributes = model;
    debugPrint(
      "((-------------- User Attributes ------------)) $userAttributes",
    );
    //No UI will be updated here, don't notify listeners
  }

  void updateUserModel(UserModel model) {
    userModel = model;
    // debugPrint(
    //   "((-------------- the whole User Model------------)) $userModel",
    // );
    //No UI will be updated here, don't notify listeners
  }

  void updateName(String value) {
    name.text = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email.text = value;
    notifyListeners();
  }

  void updatePhone(String value) {
    phone.text = value;
    notifyListeners();
  }

  void updateCountryCode(CountryCode value) {
    countryCode = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    password.text = value;
    notifyListeners();
  }

  void disposeController(TextEditingController controller) {
    controller.dispose();
    notifyListeners();
  }

  ///-------------------------- Makes `EnteredPhoneState` readable inside the devtools by listing all of its properties --------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    // properties.add(StringProperty('enteredPassword', enteredPassword));
  }
}
