

//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/foundation.dart';
import 'package:instore/constants/app_enum.dart';

//-------------------------- InStore App Imports ----------------------------------


class AccountProviderState with ChangeNotifier, DiagnosticableTreeMixin  {
  AuthMode authMode = AuthMode.unauthorized;

  void updateAuthMode(AuthMode mode) {
    authMode = mode;
    notifyListeners();
  }
  
///-------------------------- Makes properties readable inside the devtools by listing all of its properties --------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
   // properties.add(StringProperty('enteredPassword', enteredPassword));
  }

}