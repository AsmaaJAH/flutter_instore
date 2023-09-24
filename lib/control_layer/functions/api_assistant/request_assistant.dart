//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';
import 'package:uiblock/uiblock.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/my_app.dart';
import 'package:instore/data_layer/models/response_wrapper_model.dart';
import 'package:instore/presentation_layer/app_snack_bar.dart';
import 'package:instore/presentation_layer/widgets/linear_circular_progress_indicator.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/constants/app_assistant_values/server_constants.dart';
import 'package:instore/control_layer/managers/shared_pref_manager.dart';
import 'package:instore/translations/locale_keys.g.dart';

class RequestAssistant {
  RequestAssistant._();
  static SharedPrefManager sharedPrefManager = SharedPrefManager();

  static Future<void> makeRequest({
    required Function requestFunction,
    Function(ResponseWrapperModel)? successAction,
  }) async {
    if (kNavigatorKey.currentContext == null) {
      return;
    } else if (!kNavigatorKey.currentContext!.mounted) {
      return;
    } else {
      UIBlock.block(
        kNavigatorKey.currentContext!,
        customLoaderChild: LinearCircularProgressIndicator(
          isLinearProgressIndicator: false,
          circularProgressHeight: kScreenHeight * 0.075,
          circularProgressWidth: kScreenWidth * 0.15,
          strokeWidth: Variables.ten,
        ),
        canDissmissOnBack: false,
      );

      requestFunction().then(
        (responseWrapperModelValue) async {
          UIBlock.unblock(kNavigatorKey.currentContext!);
          if (responseWrapperModelValue != null) {
            if (responseWrapperModelValue.isSucceeded) {
              if (successAction != null) {
                await successAction(responseWrapperModelValue);
              }
            } else if (responseWrapperModelValue != null &&
                responseWrapperModelValue.error != null) {
              bool isSMSserviceDown =
                  responseWrapperModelValue.error!.message ==
                      ServerConstants.downSMSservice;
              bool isCodeExpired = responseWrapperModelValue.error!.message ==
                  ServerConstants.codeExpired;
              debugPrint("isCodeExpired${isCodeExpired.toString()}");
              if (isSMSserviceDown) {
                AppSnackBar(
                  context: kNavigatorKey.currentContext!,
                  message: LocaleKeys.invalidVictoryLink,
                  isError: true,
                  bottomMarginCloseError: Variables.seven,
                  durationInSeconds: Variables.fiveInt,
                  //contentHeight: kScreenHeight * 0.12,
                ).showAppSnackBar();
              } else if (isCodeExpired) {
                AppSnackBar(
                  context: kNavigatorKey.currentContext!,
                  message: LocaleKeys.codeExpired,
                  isError: true,
                  // contentHeight: kScreenHeight * 0.1,
                  bottomMarginCloseError: Variables.seven,
                  durationInSeconds: Variables.fiveInt,
                ).showAppSnackBar();
              } else {
                AppSnackBar(
                  context: kNavigatorKey.currentContext!,
                  isSnackBarLocalized: false,
                  bottomMarginCloseError: Variables.seven,
                  //contentHeight: kScreenHeight * 0.1,
                  isError: true,
                  message: responseWrapperModelValue.error!.message,
                ).showAppSnackBar();
              }
            }
          }
        },
      );
    }
  }
}
