//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/presentation_layer/widgets/customized_textform_field.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/email_form_provider.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({
    super.key,
    this.onChanged,
    this.onSaved,
    this.emailController,
    this.currentOperation = Variables.loginProvider,
  });
  final String currentOperation;
  final TextEditingController? emailController;
  final void Function(String)? onChanged;

  final void Function(String?)? onSaved;

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  late EmailFormProviderState emailState;

  String? _onValidate(String? value) {
    if (value == null ||
        value.trim().isEmpty ||
        !Variables.emailRegex.hasMatch(value)) {
      // emailRegex:
      //     r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"

      emailState.updateIsErrorEmailValidator(true);
      return LocaleKeys.pleaseEnterValidMail.tr();
    }
    emailState.updateIsErrorEmailValidator(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    emailState = context.watch<EmailFormProviderState>();
    double height = kScreenHeight * 0.055;
    double heightwithError = kScreenHeight * 0.055 + kScreenHeight * 0.033;
    return Selector<EmailFormProviderState, bool>(
        selector: (_, provider) => provider.isErrorEmailValidator,
        builder: (context, isError, child) {
          return CustomizedTextFormField(
            givenHeight: isError ? heightwithError : height,
            width: kScreenWidth * 0.9,
            hint: LocaleKeys.email,
            validator: _onValidate,
            onChanged: widget.onChanged,
            onSaved: widget.onSaved,
            controller: widget.emailController,
          );
        });
  }
}
