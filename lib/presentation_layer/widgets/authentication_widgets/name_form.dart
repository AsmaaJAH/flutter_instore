//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/data_layer/providers/widgets_providers/authentication_widgets_providers/name_form_provider.dart';
import 'package:provider/provider.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/presentation_layer/widgets/customized_textform_field.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/translations/locale_keys.g.dart';

class NameForm extends StatefulWidget {
  const NameForm({
    super.key,
    this.onChanged,
    this.onSaved,
    this.nameController,
    this.currentOperation = Variables.signupProvider,
  });
  final String currentOperation;
  final TextEditingController? nameController;
  final void Function(String)? onChanged;

  final void Function(String?)? onSaved;

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
  late NameFormProviderState nameState;

  String? _onValidate(String? value) {
    if (value == null || value.trim().isEmpty) {
      nameState.updateIsErrorNameValidator(true);
      return LocaleKeys.nameValidator.tr();
    }
    nameState.updateIsErrorNameValidator(false);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    nameState = context.watch<NameFormProviderState>();
    final double height = kScreenHeight * 0.055;
    final double heightwithError =
        kScreenHeight * 0.055 + kScreenHeight * 0.033;
    return Selector<NameFormProviderState, bool>(
      selector: (_, provider) => provider.isErrorNameValidator,
      builder: (context, isError, child) {
        return CustomizedTextFormField(
          hint: LocaleKeys.name,
          givenHeight: isError ? heightwithError : height,
          width: kScreenWidth * 0.9,
          validator: _onValidate,
          onChanged: widget.onChanged,
          onSaved: widget.onSaved,
          controller: widget.nameController,
        );
      },
    );
  }
}
