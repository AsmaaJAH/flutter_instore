//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/control_layer/functions/authentication_functions/submit.dart';
import 'package:instore/control_layer/functions/provider_helper_functions.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/verify_code_provider.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_forms_keys.dart';
import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/authentication_functions/forms_reset.dart';
import 'package:instore/control_layer/functions/guest_mode_functions.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/forget_password_provider.dart';
import 'package:instore/my_app.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/signup_screen.dart';
import 'package:instore/presentation_layer/widgets/authentication_widgets/phone_form.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_appbar.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';

class ForgetPasswordFirstScreen extends StatefulWidget {
  const ForgetPasswordFirstScreen({super.key});
  @override
  State<ForgetPasswordFirstScreen> createState() =>
      _ForgetPasswordFirstScreenState();
}

class _ForgetPasswordFirstScreenState extends State<ForgetPasswordFirstScreen> {
  final _formKey = AppFormsKeys().forgetPasswordFirstScreenFormKey;
  final double passwordHeight = kScreenHeight * 0.06;
  final double passwordHeightwithError =
      kScreenHeight * 0.065 + kScreenHeight * 0.023;
  var forgetPassState =
      kNavigatorKey.currentContext!.watch<ForgetPasswordProviderState>();
  var verifyCodeState =
      kNavigatorKey.currentContext!.watch<VerifyCodeProviderState>();

  void _onSavedPhone(String? value) {
    // the value would never be null because we call save after validate
    if (value == null) return;
    forgetPassState.updateEnteredPhone(value);
  }

  void _onChangedPhoneCode(CountryCode value) {
    forgetPassState.updateCountryCode(value);
  }

  void onPressFlatButton() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      ProviderHelperFunctions.readCurrentProviderState(
          currentOperation: Variables.verifyCodeProvider);

      ProviderHelperFunctions.verifyCodeProvider.updateIsCountingDown(true);
      ProviderHelperFunctions.verifyCodeProvider.updateIsFromForgetPass(true);

      debugPrint(
          "((-----Submit.sendVerificationCode() after forget pass first screen-----))");
      Submit.sendVerificationCode();

      //reseting everything in the form:
      FormsReset.resetPhoneForm(forgetPasswordFormKey: _formKey);
    }
  }

  void onTapSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
    //reseting everything in the form:
    FormsReset.resetPhoneForm(forgetPasswordFormKey: _formKey);

    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    ProviderHelperFunctions.verifyCodeProvider.updateIsFromForgetPass(false);
  }

  Future<bool> onWillPop() async {
    ProviderHelperFunctions.readCurrentProviderState(
      currentOperation: Variables.verifyCodeProvider,
    );
    ProviderHelperFunctions.verifyCodeProvider.updateIsFromForgetPass(false);

    FormsReset.onWillPop(forgetPasswordFormKey: _formKey);
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
                onPressed: () {
                  GuestModeFunctions.onPressCloseBtnOfQuestMode(
                      forgetPasswordFormKey: _formKey);
                },
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
              children: [
                Padding(
                  padding: EdgeInsets.only(right: kScreenWidth * 0.01),
                  child: const CustomLocalizedTextWidget(
                      color: AppColors.commonBlack,
                      fontSize: Variables.double24,
                      stringKey: LocaleKeys.forgetPassPhrase),
                ),
                SizedBox(
                  height: kScreenHeight * 0.1,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PhoneForm(
                        onSavedPhone: _onSavedPhone,
                        onchangedPhoneCode: _onChangedPhoneCode,
                      ),
                      SizedBox(
                        height: kScreenHeight * 0.04,
                      ),
                      CustomizedButton(
                        width: kScreenWidth * 0.9,
                        height: kScreenHeight * 0.055,
                        buttonText: LocaleKeys.send,
                        onPressed: onPressFlatButton,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: kScreenHeight * 0.07,
                ),
                SizedBox(
                  width: kScreenWidth * 0.9,
                  child: Row(
                    children: [
                      Container(
                        color: AppColors.grayBorder,
                        height: Variables.double0_5,
                        width: kScreenWidth * 0.4,
                      ),
                      SizedBox(
                        width: kScreenWidth * 0.025,
                      ),
                      const CustomLocalizedTextWidget(
                          color: AppColors.black,
                          fontSize: Variables.double14_4,
                          stringKey: LocaleKeys.or),
                      SizedBox(
                        width: kScreenWidth * 0.025,
                      ),
                      Container(
                        color: AppColors.grayBorder,
                        height: Variables.double0_5,
                        width: kScreenWidth * 0.4,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: kScreenHeight * 0.09,
                ),
                SizedBox(
                  width: kScreenWidth * 0.9,
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: Image.asset(AppImagesAssets.twitterImagePath),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: kScreenWidth * 0.09,
                        ),
                        InkWell(
                          child: Image.asset(AppImagesAssets.googleImagePath),
                          onTap: () {},
                        ),
                        SizedBox(
                          width: kScreenWidth * 0.09,
                        ),
                        InkWell(
                          child: Image.asset(AppImagesAssets.appleImagePath),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: kScreenHeight * 0.17,
                ),
                SizedBox(
                  width: kScreenWidth * 0.9,
                  child: Center(
                    child:
                        // RichText would not handle the ltr and rtl directions so I will use Row instead of it
                        // RichText( textAlign: TextAlign.center, text: TextSpan(children: [TextSpan()),
                        Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CustomLocalizedTextWidget(
                          color: AppColors.black,
                          fontSize: Variables.double16,
                          fontWeight: CustomTextWeight.lightFont,
                          stringKey: LocaleKeys.newMember,
                        ),
                        const SizedBox(
                          width: Variables.five,
                        ),
                        InkWell(
                          onTap: onTapSignUp,
                          child: const CustomLocalizedTextWidget(
                            color: AppColors.secondary,
                            fontSize: Variables.double16,
                            fontWeight: CustomTextWeight.boldFont,
                            stringKey: LocaleKeys.signUp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
