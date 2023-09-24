//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';

class DropDownMenuWidget extends StatelessWidget {
  const DropDownMenuWidget({
    super.key,
    required this.list,
  });
  final List<String> list;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String dropdownValue = list.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(
        Icons.arrow_drop_down_outlined,
        color: AppColors.commonGray,
      ),
      elevation: Variables.zeroInt,
      style: TextThemeManager.lightFont(
        fontColor: AppColors.blackTitle,
        fontSize: Variables.double11,
      ),
      underline: Container(
        color: AppColors.commonWhite,
      ),
      onChanged: (String? value) {
        // setState(() {
        dropdownValue = value!;
        // });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
