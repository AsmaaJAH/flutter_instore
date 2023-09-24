//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instore/data_layer/models/user_model.dart';

//-------------------------- InStore App Imports ----------------------------------

class LoginProviderState with ChangeNotifier, DiagnosticableTreeMixin {
  var enteredPassword = '';
  bool obscureText = true;
  UserModel userModel = UserModel();
  
  void updateUserModel(UserModel model) {
    userModel = model;
    // debugPrint(
    //   "((-------------- the whole User Model------------)) $userModel",
    // );
    //No UI will be updated here, don't notify listeners
  }

  UserAttributesModel userAttributesModel = UserAttributesModel();
  UserAttributesModel loginAfterSignupAttributes = UserAttributesModel();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  updateEnteredPassword(String value) {
    enteredPassword = value;
    notifyListeners();
  }

  void putUserInfo(UserAttributesModel model) {
    userAttributesModel = model;
    debugPrint(
        "((-------------- User Model------------)) $userAttributesModel");
    //No UI will be updated here, don't notify listeners
  }

  void putInfoOfLoginAfterSignup(UserAttributesModel model) {
    loginAfterSignupAttributes = model;
    debugPrint(
      "((-------------- User Attributes of login after signup------------)) $loginAfterSignupAttributes",
    );
    //No UI will be updated here, don't notify listeners
  }

  void updateEmail(String value) {
    email.text = value;
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
    properties.add(StringProperty('enteredPassword', enteredPassword));
  }
}
