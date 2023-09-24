//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/data_layer/models/user_model.dart';

class ForgetPasswordProviderState with ChangeNotifier, DiagnosticableTreeMixin {
  var enteredPassword = '';
  var enteredPhone = '';
  var enteredCountryCode = CountryCode.fromDialCode(
    Variables.egyptPhoneCode,
  );
  UserAttributesModel userAttributes = UserAttributesModel();
  UserModel userModel = UserModel();
  
  void updateUserModel(UserModel model) {
    userModel = model;
    // debugPrint(
    //   "((-------------- the whole User Model------------)) $userModel",
    // );
    //No UI will be updated here, don't notify listeners
  }

  updateEnteredPassword(String value) {
    enteredPassword = value;
    notifyListeners();
  }

  updateEnteredPhone(String value) {
    enteredPhone = value;
    notifyListeners();
  }

  updateCountryCode(CountryCode value) {
    enteredCountryCode = value;
    notifyListeners();
  }

  void disposeController(TextEditingController controller) {
    controller.dispose();
    notifyListeners();
  }

  void putUserInfo(UserAttributesModel model) {
    userAttributes = model;
    debugPrint(
      "((-------------- User Attributes ------------)) $userAttributes",
    );
    //No UI will be updated here, don't notify listeners
  }

  ///-------------------------- Makes `EnteredPhoneState` readable inside the devtools by listing all of its properties --------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('enteredPassword', enteredPassword));
  }
}
