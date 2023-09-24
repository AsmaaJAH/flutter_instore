//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_colors.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/password_form_provider.dart';
import 'package:instore/presentation_layer/widgets/customized_textform_field.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    super.key,
    this.onPressIcon,
    required this.isSettingNewPass,
    this.isConfirmingPass = false,
    this.onChanged,
    this.onSaved,
    this.givenHeight,
    this.givenHeightWithError,
    this.passwordController,
    this.currentOperation = Variables.signupProvider,
  });

  final double? givenHeight;
  final double? givenHeightWithError;

  final TextEditingController? passwordController;
  final String currentOperation;

  final void Function()? onPressIcon;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;

  final bool isConfirmingPass;
  final bool isSettingNewPass; //true in signup screen and forget-pass screen

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  late PasswordFormProviderState passwordState;

  String? _onValidate(String? value) {
    if (widget.isSettingNewPass) {
      //--->in Sign up and forgetpassword pages
      if (widget.isConfirmingPass) {
        if (passwordState.password != value) {
          passwordState.updateIsErrorConfirmPassFormValidator(true);
          return LocaleKeys.validateConfirmPassMessage.tr();
        }
      } else {
        if (value == null || value.trim().length < 8
            // ||
            // value.trim().length > 20 ||
            // !Variables.passwordRegex.hasMatch(value)
            ) {
          passwordState.updateIsErrorPassFormValidator(true);
          return LocaleKeys.validatePassMessage.tr();
        }
      }
    } else {
      // in the case of log in only:
      if (value == null || value.trim().isEmpty
// or value!=backend recorded password
          ) {
        passwordState.updateIsErrorPassFormValidator(true);
        return LocaleKeys.logInPassWordValidator.tr();
      }
    }
    //put this below line in the onSaved function later:
    passwordState.updatePassword(value!);

    return null;
  }

  @override
  Widget build(BuildContext context) {
    passwordState = context.watch<PasswordFormProviderState>();
    final double height = widget.givenHeight ?? kScreenHeight * 0.055;
    final double heightwithError = widget.givenHeightWithError ??
        kScreenHeight * 0.055 + kScreenHeight * 0.033;
    var isObsecureConfirming =
        widget.isConfirmingPass && passwordState.isObscureConfirmPassword;
    var isObsecurePassword =
        !widget.isConfirmingPass && passwordState.isObscurePassword;
    return Selector<PasswordFormProviderState, Tuple2<bool, bool>>(
        selector: (_, provider) => Tuple2(provider.isErrorPassFormValidator,
            provider.isErrorConfirmPassFormValidator),
        builder: (
          context,
          isError,
          child,
        ) {
          var isErrorConfirming = isError.item2 && widget.isConfirmingPass;
          var isErrorPassword = isError.item1 && !widget.isConfirmingPass;

          return Builder(builder: (context) {
            return CustomizedTextFormField(
              controller: widget.passwordController,
              isObsecuredPasswordForm: true,
              givenHeight: isErrorPassword
                  ? heightwithError
                  : isErrorConfirming
                      ? heightwithError
                      : height,
              width: kScreenWidth * 0.9,
              validator: _onValidate,
              onChanged: widget.onChanged,
              onSaved: widget.onSaved,
              obscureText: widget.isConfirmingPass
                  ? passwordState.isObscureConfirmPassword
                  : passwordState.isObscurePassword,
              hint: widget.isConfirmingPass
                  ? LocaleKeys.confirmPass
                  : LocaleKeys.password,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: kScreenWidth * 0.015),
                child: IconButton(
                  onPressed: widget.isConfirmingPass
                      ? passwordState.toggleConfirmPasswordVisability
                      : passwordState.togglePasswordVisability,
                  icon: isObsecurePassword
                      ? const Icon(
                          Icons.visibility_off_outlined,
                          color: AppColors.blackIconsAndNegBtnDialog,
                        )
                      : isObsecureConfirming
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.blackIconsAndNegBtnDialog,
                            )
                          : const Icon(
                              Icons.visibility_outlined,
                              color: AppColors.blackIconsAndNegBtnDialog,
                            ),
                ),
              ),
            );
          });
        });
  }
}
