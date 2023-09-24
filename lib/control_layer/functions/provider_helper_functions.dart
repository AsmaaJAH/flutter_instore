//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:instore/data_layer/providers/widgets_providers/home_page_widgets_providers/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/data_layer/providers/screens_providers/authentication_providers/login_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/email_form_provider.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/data_layer/providers/screens_providers/account_providers/account_provider.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/forget_password_provider.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/signup_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/name_form_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/password_form_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/phone_form_provider.dart';
import 'package:instore/my_app.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/verify_code_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/pin_code_provider.dart';
import 'package:instore/data_layer/providers/widgets_providers/home_page_widgets_providers/slider_with_indicator_provider.dart';


class ProviderHelperFunctions {
  ProviderHelperFunctions._();
  static late AccountProviderState accountProvider;
  static late PinCodeProviderState pinCodeProvider;
  static late LoginProviderState loginProvider;
  static late SignUpProviderState signupProvider;
  static late ForgetPasswordProviderState forgetPasswordProvider;
  static late VerifyCodeProviderState verifyCodeProvider;

  static List<SingleChildWidget> getProviders() {
    return [
      //authentication
      ChangeNotifierProvider(create: (_) => LoginProviderState()),
      ChangeNotifierProvider(create: (_) => EmailFormProviderState()),
      ChangeNotifierProvider(create: (_) => PhoneFormProviderState()),
      ChangeNotifierProvider(create: (_) => SignUpProviderState()),
      ChangeNotifierProvider(create: (_) => NameFormProviderState()),
      ChangeNotifierProvider(create: (_) => PasswordFormProviderState()),
      ChangeNotifierProvider(create: (_) => ForgetPasswordProviderState()),
      ChangeNotifierProvider(create: (_) => AccountProviderState()),
      ChangeNotifierProvider(create: (_) => PinCodeProviderState()),
      ChangeNotifierProvider(create: (_) => VerifyCodeProviderState()),
      ChangeNotifierProvider(create: (_) => SliderWithIndicatorProviderState()),
      ChangeNotifierProvider(create: (_) => FavouriteProviderState()),

    ];
  }

  static void readCurrentProviderState({required String currentOperation}) {
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      if (currentOperation == Variables.accountProvider) {
        accountProvider =
            kNavigatorKey.currentContext!.read<AccountProviderState>();
      } else if (currentOperation == Variables.verifyCodeProvider) {
        verifyCodeProvider =
            kNavigatorKey.currentContext!.read<VerifyCodeProviderState>();
      } else if (currentOperation == Variables.loginProvider) {
        loginProvider =
            kNavigatorKey.currentContext!.read<LoginProviderState>();
      } else if (currentOperation == Variables.signupProvider) {
        signupProvider =
            kNavigatorKey.currentContext!.read<SignUpProviderState>();
      } else if (currentOperation == Variables.forgetPassProvider) {
        forgetPasswordProvider =
            kNavigatorKey.currentContext!.read<ForgetPasswordProviderState>();
      } else if (currentOperation == Variables.pinCodeProvider) {
        pinCodeProvider =
            kNavigatorKey.currentContext!.read<PinCodeProviderState>();
      }
    }
  }
}
