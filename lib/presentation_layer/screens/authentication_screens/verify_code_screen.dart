//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';
import 'package:instore/control_layer/functions/authentication_functions/submit.dart';
import 'package:instore/control_layer/functions/authentication_functions/forms_reset.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';
import 'package:instore/control_layer/functions/remove_trailing_zeros.dart';
import 'package:instore/data_layer/models/user_model.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/verify_code_provider.dart';
import 'package:instore/my_app.dart';
import 'package:instore/presentation_layer/app_snack_bar.dart';
import 'package:instore/presentation_layer/widgets/pin_code.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/guest_mode_functions.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_appbar.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({
    super.key,
  });
  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  late String pinCode;

  String get phoneNum {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    bool isFromForgetPass =
        ProviderHelperFunctions.verifyCodeProvider.isFromForgetPassword;
    bool isFromLogin = ProviderHelperFunctions.verifyCodeProvider.isFromLogin;

    if (isFromForgetPass) {
      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.forgetPassProvider,
      );
      bool isStillEmpty =
          ProviderHelperFunctions.forgetPasswordProvider.enteredPhone == '';
      if (isStillEmpty) {
        return "";
      } else {
        return "+${ProviderHelperFunctions.forgetPasswordProvider.enteredPhone}";
      }
    } else if (isFromLogin) {
      return "+${ProviderHelperFunctions.verifyCodeProvider.displayedPhone}";
    } else {
      ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.signupProvider,
      );
      UserModel userModel = ProviderHelperFunctions.signupProvider.userModel;
      bool isPhoneExist = userModel.userData != null &&
          userModel.userData!.attributes != null &&
          userModel.userData!.attributes!.phoneNumber != null;
      if (isPhoneExist) {
        return "+${ProviderHelperFunctions.signupProvider.userModel.userData!.attributes!.phoneNumber!}";
      } else {
        return "";
      }
    }
  }

  void onFinishCountdown() {
    ProviderHelperFunctions.readCurrentProviderState(
        currentOperation: Variables.verifyCodeProvider);
    ProviderHelperFunctions.verifyCodeProvider.updateIsCountingDown(false);
    if (kNavigatorKey.currentContext != null) {
      AppSnackBar(
          backgroundColor: AppColors.black,
          context: kNavigatorKey.currentContext!,
          message: LocaleKeys.verifyCodeExpired,
          prefix: const Icon(
            Icons.warning_outlined,
            color: AppColors.commonWhite,
          )).showAppSnackBar();
    } else {
      return;
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   //show app snack bar after initing state with very very small delay:
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) => AppSnackBar(
  //       context: kNavigatorKey.currentContext!,
  //       message: LocaleKeys.verifyCodeSendSuccessfully,
  //     ).showAppSnackBar(),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    ProviderHelperFunctions.verifyCodeProvider.updateIsFromForgetPass(false);
  }

  Future<bool> onWillPop() async {
    FormsReset.onWillPop();
    return true as Future<bool>;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //to control the user experience when using the device back button
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.commonWhite,
        appBar: CustomizedAppBar(
          isBackIcon: false,
          actions: [
            Padding(
              padding: EdgeInsets.all(kScreenWidth * 0.02),
              child: IconButton(
                onPressed: GuestModeFunctions.onPressCloseBtnOfQuestMode,
                icon: Icon(
                  Icons.close,
                  color: AppColors.black,
                  size: kScreenWidth * 0.065,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImagesAssets.verifyCodeImagePath,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: kScreenHeight * 0.07,
                ),
                const CustomLocalizedTextWidget(
                  color: AppColors.black,
                  stringKey: LocaleKeys.verifyCodeTitle,
                  fontWeight: CustomTextWeight.boldFont,
                  fontSize: Variables.double20,
                ),
                SizedBox(
                  height: kScreenHeight * 0.03,
                ),
                const CustomLocalizedTextWidget(
                  color: AppColors.commonGray,
                  stringKey: LocaleKeys.verifyCodeContentFirstLine,
                  fontWeight: CustomTextWeight.regularFont,
                  fontSize: Variables.double12,
                ),
                const CustomLocalizedTextWidget(
                  color: AppColors.commonGray,
                  stringKey: LocaleKeys.verifyCodeContentSecondLine,
                  fontWeight: CustomTextWeight.regularFont,
                  fontSize: Variables.double12,
                ),
                SizedBox(
                  height: kScreenHeight * 0.025,
                ),
                CustomLocalizedTextWidget(
                  color: AppColors.black,
                  stringKey: phoneNum,
                  isTranslate: false,
                  fontWeight: CustomTextWeight.boldFont,
                  fontSize: Variables.double20,
                ),
                SizedBox(
                  height: kScreenHeight * 0.07,
                ),
                const PinCode(),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      kScreenWidth * 0.3, 0, kScreenWidth * 0.3, 0),
                  child: CustomizedButton(
                    width: kScreenWidth * 0.27,
                    height: kScreenHeight * 0.055,
                    fontWeight: CustomTextWeight.regularFont,
                    fontSize: Variables.double12,
                    backgroundColor: AppColors.commonWhite,
                    onPressed: Submit.resendCode,
                    buttonText: LocaleKeys.resendCode,
                    textColor: AppColors.secondary,
                  ),
                ),
                SizedBox(
                  height: kScreenHeight * 0.1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Selector<VerifyCodeProviderState, bool>(
                        selector: (_, provider) => provider.isCountingDown,
                        builder: (context, isCountingDown, child) =>
                            isCountingDown
                                ? Countdown(
                                    interval: const Duration(
                                        seconds: Variables.oneInt),
                                    onFinished: onFinishCountdown,
                                    seconds: Variables.int60,
                                    build:
                                        (BuildContext context, double timer) =>
                                            CustomLocalizedTextWidget(
                                      stringKey:
                                          removeTrailingZeros(timer.toString()),
                                      isTranslate: false,
                                      textAlign: TextAlign.center,
                                      color: AppColors.commonGray,
                                      fontSize: Variables.double12,
                                      fontWeight: CustomTextWeight.regularFont,
                                    ),
                                  )
                                : const CustomLocalizedTextWidget(
                                    stringKey: "${Variables.zeroInt}",
                                    isTranslate: false,
                                    textAlign: TextAlign.center,
                                    color: AppColors.commonGray,
                                    fontSize: Variables.double12,
                                    fontWeight: CustomTextWeight.regularFont,
                                  ),
                      ),
                      const SizedBox(width: Variables.five),
                      const CustomLocalizedTextWidget(
                        stringKey: LocaleKeys.remainingSeconds,
                        textAlign: TextAlign.center,
                        color: AppColors.commonGray,
                        fontSize: Variables.double12,
                        fontWeight: CustomTextWeight.regularFont,
                      ),
                    ],
                  ),
                ),
                CustomizedButton(
                  width: kScreenWidth * 0.92,
                  buttonText: LocaleKeys.done,
                  onPressed: Submit.verifyAccountDoneButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
