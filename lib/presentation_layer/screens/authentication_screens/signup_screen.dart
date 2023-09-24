//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/presentation_layer/screens/authentication_screens/verify_code_screen.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_forms_keys.dart';
import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/authentication_functions/submit.dart';
import 'package:instore/control_layer/functions/authentication_functions/forms_reset.dart';
import 'package:instore/control_layer/functions/guest_mode_functions.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/signup_provider.dart';
import 'package:instore/my_app.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/login_screen.dart';
import 'package:instore/presentation_layer/widgets/authentication_widgets/email_form.dart';
import 'package:instore/presentation_layer/widgets/authentication_widgets/name_form.dart';
import 'package:instore/presentation_layer/widgets/authentication_widgets/password_form.dart';
import 'package:instore/presentation_layer/widgets/authentication_widgets/phone_form.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_appbar.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() {
    return _SignUpScreenState();
  }
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = AppFormsKeys().signUpFormKey;
  var signUpState = kNavigatorKey.currentContext!.watch<SignUpProviderState>();
  var signupState = kNavigatorKey.currentContext!.watch<SignUpProviderState>();

  void onTapSignIn() {
    //reset form and everything:
    FormsReset.resetNameForm(signUpFormKey: _formKey);
    FormsReset.resetEmailForm(signUpFormKey: _formKey);
    FormsReset.resetPhoneForm(signUpFormKey: _formKey);
    FormsReset.resetPassWordForm(signUpFormKey: _formKey);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  void _onSavedName(String? value) {
    // the value would never be null because we call save after validate
    if (value == null) return;
    signUpState.updateName(value);
  }

  void _onSavedEmail(String? value) {
    // the value would never be null because we call save after validate
    if (value == null) return;
    signUpState.updateEmail(value);
  }

  void _onSavedPhone(String? value) {
    // the value would never be null because we call save after validate
    if (value == null) return;
    signUpState.updatePhone(value);
  }

  void _onChangedPhoneCode(CountryCode value) {
    signUpState.updateCountryCode(value);
  }

  void _onSavedPassword(String? value) {
    // the value would never be null because we call save after validate
    if (value == null) return;
    signUpState.updatePassword(value);
  }

  void onPressFlatButton() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //sign up logic, then navigator here:
      Submit.signUp();

      //reseting everything in the form:
      FormsReset.resetNameForm(signUpFormKey: _formKey);
      FormsReset.resetEmailForm(signUpFormKey: _formKey);
      FormsReset.resetPhoneForm(signUpFormKey: _formKey);
      FormsReset.resetPassWordForm(signUpFormKey: _formKey);
    }
  }

  Future<bool> onWillPop() async {
    FormsReset.onWillPop(signUpFormKey: _formKey);
    return true as Future<bool>;
  }

// @override
//   void dispose() {
//     super.dispose();
//     //     if (nameController != null) {
//     //   DisposeController.disposeTextController(
//     //     controller: widget.nameController!,
//     //     currentOperation: widget.currentOperation,
//     //   );
//     // }
//   }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //to control the user experience when using the device back button
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: AppColors.commonWhite,
        appBar: CustomizedAppBar(
          height: kScreenHeight * 0.065,
          isBackIcon: false,
          actions: [
            Padding(
              padding: EdgeInsets.all(kScreenWidth * 0.02),
              child: IconButton(
                onPressed: () {
                  GuestModeFunctions.onPressCloseBtnOfQuestMode(
                      signUpFormKey: _formKey);
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
                const CustomLocalizedTextWidget(
                    color: AppColors.secondary,
                    fontSize: Variables.double28,
                    fontWeight: CustomTextWeight.mediumFont,
                    stringKey: LocaleKeys.signUp),
                SizedBox(
                  height: kScreenWidth * 0.01,
                ),
                const CustomLocalizedTextWidget(
                    color: AppColors.commonBlack,
                    fontSize: Variables.double24,
                    stringKey: LocaleKeys.createAnAcount),
                SizedBox(
                  height: kScreenHeight * 0.065,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NameForm(
                          onSaved: _onSavedName,
                          //nameController: signUpState.name,
                        ),
                        SizedBox(
                          height: kScreenWidth * 0.04,
                        ),
                        EmailForm(
                          onSaved: _onSavedEmail,
                          currentOperation: Variables.signupProvider,
                          //emailController: signUpState.email,
                        ),
                        SizedBox(
                          height: kScreenWidth * 0.03,
                        ),
                        PhoneForm(
                          onSavedPhone: _onSavedPhone,
                          onchangedPhoneCode: _onChangedPhoneCode,
                          //phoneController: signUpState.phone,
                        ),
                        SizedBox(
                          height: kScreenWidth * 0.04,
                        ),
                        PasswordForm(
                          onSaved: _onSavedPassword,
                          isSettingNewPass: true,
                          //passwordController: signUpState.password,
                        ),
                        SizedBox(
                          height: kScreenWidth * 0.04,
                        ),
                        const PasswordForm(
                          isSettingNewPass: true,
                          isConfirmingPass: true,
                        ),
                        SizedBox(
                          height: kScreenHeight * 0.03,
                        ),
                        CustomizedButton(
                          width: kScreenWidth * 0.9,
                          height: kScreenHeight * 0.055,
                          buttonText: LocaleKeys.signUp,
                          onPressed: onPressFlatButton,
                        ),
                      ],
                    )),
                SizedBox(
                  height: kScreenHeight * 0.035,
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
                  height: kScreenHeight * 0.04,
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
                          onTap: () {
                            //navigator:
                            Navigator.of(kNavigatorKey.currentContext!).push(
                              MaterialPageRoute(
                                builder: (context) => const VerifyCodeScreen(),
                              ),
                            );
                          },
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
                  height: kScreenHeight * 0.04,
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
                          stringKey: LocaleKeys.alreadyHaveAnAcount,
                        ),
                        const SizedBox(
                          width: Variables.five,
                        ),
                        InkWell(
                          onTap: onTapSignIn,
                          child: const CustomLocalizedTextWidget(
                            color: AppColors.secondary,
                            fontSize: Variables.double16,
                            fontWeight: CustomTextWeight.boldFont,
                            stringKey: LocaleKeys.signIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: kScreenWidth * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
