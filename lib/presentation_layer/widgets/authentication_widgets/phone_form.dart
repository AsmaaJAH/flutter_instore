//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/phone_form_provider.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_textform_field.dart';
import 'package:instore/translations/locale_keys.g.dart';

class PhoneForm extends StatefulWidget {
  const PhoneForm({
    super.key,
    this.onChangedPhone,
    this.onSavedPhone,
    this.onchangedPhoneCode,
    this.phoneController,
    this.currentOperation = Variables.signupProvider,
    this.onInitCountryCode,
  });
  final String currentOperation;
  final TextEditingController? phoneController;
  final void Function(String)? onChangedPhone;
  final void Function(String?)? onSavedPhone;
  final void Function(CountryCode)? onchangedPhoneCode;
  final void Function(CountryCode?)? onInitCountryCode;

  @override
  State<PhoneForm> createState() => _PhoneFormState();
}

class _PhoneFormState extends State<PhoneForm> {
  late PhoneFormProviderState phoneState;
  final double height = kScreenHeight * 0.065;
  final double heightwithError = kScreenHeight * 0.065 + kScreenHeight * 0.008;
  String? _onValidate(String? value) {
    if (value == null ||
        value.trim().isEmpty ||
        !value.contains('1') ||
        value.length < 10) {
      phoneState.updateIsErrorPhoneValidator(true);
      return LocaleKeys.pleaseEnterValidPhone.tr();
    }
    phoneState.updateIsErrorPhoneValidator(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    phoneState = context.watch<PhoneFormProviderState>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 5,
          child: Selector<PhoneFormProviderState, bool>(
              selector: (_, provider) => provider.isErrorPhoneValidator,
              builder: (context, isError, child) {
                return Container(
                  margin: EdgeInsets.only(
                      left: kScreenWidth * 0.05, right: kScreenWidth * 0.019),
                  height: isError ? heightwithError : height,
                  decoration: BoxDecoration(
                    color: AppColors.commonWhite,
                    border: Border.all(
                        color: AppColors.grayBorder,
                        width: Variables.double0_5),
                  ),
                  child: CountryCodePicker(
                    searchDecoration: InputDecoration(
                      label: CustomLocalizedTextWidget(
                        stringKey: LocaleKeys.addYourCountryCode,
                        style: TextThemeManager.regularFont(
                          fontSize: Variables.double16,
                          fontColor: AppColors.black,
                        ),
                      ),
                    ),
                    onChanged: widget.onchangedPhoneCode,
                    onInit: widget.onInitCountryCode,
                    initialSelection: 'EG',
                    favorite: const ['+20', 'EG'],
                    showCountryOnly: false,
                    showOnlyCountryWhenClosed: false,
                    showFlag: false,
                    showDropDownButton: true,
                    dialogTextStyle: TextThemeManager.regularFont(
                      fontSize: Variables.double16,
                      fontColor: AppColors.black,
                    ),
                    textStyle: TextThemeManager.lightFont(
                      fontSize: Variables.double14,
                      fontColor: AppColors.grayFilling,
                    ),
                  ),
                );
              }),
        ),
        Expanded(
          flex: 8,
          child: Selector<PhoneFormProviderState, bool>(
              selector: (_, provider) => provider.isErrorPhoneValidator,
              builder: (context, isError, child) {
                return CustomizedTextFormField(
                  givenHeight: isError ? heightwithError : height,
                  width: kScreenWidth * 0.565,
                  hint: LocaleKeys.phoneNum,
                  isAutoCorrected: false,
                  hintColor: AppColors.grayHintPhoneForm,
                  keyboardType: TextInputType.number,
                  validator: _onValidate,
                  onChanged: widget.onChangedPhone,
                  onSaved: widget.onSavedPhone,
                  controller: widget.phoneController,
                );
              }),
        ),
      ],
    );
  }
}
