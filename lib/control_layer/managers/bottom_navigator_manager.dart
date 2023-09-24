//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';

class BottomNavigatorManager {
  const BottomNavigatorManager({
    required this.activeIconWidget,
    this.inActiveIconWidget,
    required this.title,
    this.contentPadding,
    this.iconSize,
    this.onPressed,
  });
  final Widget activeIconWidget;
  final Widget? inActiveIconWidget;
  final String title;
  final double? iconSize;
  final double? contentPadding;
  final dynamic Function(BuildContext?)? onPressed;

  PersistentBottomNavBarItem get navigatorItem {
    return PersistentBottomNavBarItem(
      contentPadding: contentPadding ?? Variables.five,
      icon: activeIconWidget,
      iconSize: iconSize ?? kScreenWidth * 0.085,
      inactiveIcon: inActiveIconWidget,
      title: title.tr(),
      onPressed: onPressed,
      activeColorPrimary: AppColors.secondary,
      inactiveColorPrimary: AppColors.gray,
      textStyle: TextThemeManager.regularFont(
        fontSize: Variables.ten,
      ),
    );
  }
}
