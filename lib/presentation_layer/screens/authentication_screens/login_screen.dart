//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/control_layer/functions/authentication_functions/submit.dart';
import 'package:instore/control_layer/functions/authentication_functions/forms_reset.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/email_form_provider.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/data_layer/providers/screens_providers/authentication_providers/login_provider.dart';
import 'package:instore/my_app.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/forget_password_first_screen.dart';
import 'package:instore/presentation_layer/screens/authentication_screens/signup_screen.dart';
import 'package:instore/presentation_layer/widgets/authentication_widgets/email_form.dart';
import 'package:instore/presentation_layer/widgets/authentication_widgets/password_form.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_appbar.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_forms_keys.dart';
import 'package:instore/control_layer/functions/guest_mode_functions.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/password_form_provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = AppFormsKeys().loginFormKey;

  var loginState = kNavigatorKey.currentContext!.watch<LoginProviderState>();
  var emailState =
      kNavigatorKey.currentContext!.watch<EmailFormProviderState>();
  var passwordState =
      kNavigatorKey.currentContext!.watch<PasswordFormProviderState>();

  void _onSavedEmail(String? value) {
    // the value would never be null because we call save after validate
    if (value == null) return;

    loginState.updateEmail(value);
  }

  void _onSavedPassword(String? value) {
    // the value would never be null because we call save after validate
    if (value == null) return;

    loginState.updatePassword(value);
  }

  void onPressFlatButton() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //submit logic:
      Submit.login(isLoginAfterSignUp: false);

      //reseting everything in the form:
      //reset email
      FormsReset.resetEmailForm(loginFormKey: _formKey);

      //reset pass form
      FormsReset.resetPassWordForm(loginFormKey: _formKey);
    }
  }

  void onTapSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
    //reseting everything in the form:
    FormsReset.resetEmailForm(loginFormKey: _formKey);
    FormsReset.resetPassWordForm(loginFormKey: _formKey);
  }

  void onPressForgetPassword() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ForgetPasswordFirstScreen(),
      ),
    );

    //reseting everything in the form:
    FormsReset.resetEmailForm(loginFormKey: _formKey);
    FormsReset.resetPassWordForm(loginFormKey: _formKey);
  }

  Future<bool> onWillPop() async {
    FormsReset.onWillPop(loginFormKey: _formKey);
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
                      loginFormKey: _formKey);
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
                    stringKey: LocaleKeys.welcomeLogIn),
                SizedBox(
                  height: kScreenWidth * 0.01,
                ),
                const CustomLocalizedTextWidget(
                    color: AppColors.commonBlack,
                    fontSize: Variables.double24,
                    stringKey: LocaleKeys.signIn),
                SizedBox(
                  height: kScreenHeight * 0.075,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EmailForm(
                          onSaved: _onSavedEmail,
                        ),
                        SizedBox(
                          height: kScreenWidth * 0.04,
                        ),
                        PasswordForm(
                          isSettingNewPass: false,
                          onSaved: _onSavedPassword,
                        ),
                        SizedBox(
                          height: kScreenWidth * 0.0001,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Variables.zero,
                            right: kScreenWidth * 0.63,
                          ),
                          child: CustomizedButton(
                            width: kScreenWidth * 0.35,
                            height: kScreenWidth * 0.098,
                            backgroundColor: AppColors.commonWhite,
                            textColor: AppColors.secondary,
                            fontSize: Variables.double12,
                            fontWeight: CustomTextWeight.regularFont,
                            buttonText: LocaleKeys.forgetPassQuestion,
                            borderRadius: Variables.double150,
                            onPressed: onPressForgetPassword,
                          ),
                        ),
                        SizedBox(
                          height: kScreenHeight * 0.031,
                        ),
                        CustomizedButton(
                            width: kScreenWidth * 0.9,
                            height: kScreenHeight * 0.055,
                            buttonText: LocaleKeys.signIn,
                            onPressed: onPressFlatButton),
                      ],
                    )),
                SizedBox(
                  height: kScreenHeight * 0.06,
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
                  height: kScreenHeight * 0.06,
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
                  height: kScreenHeight * 0.13,
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
