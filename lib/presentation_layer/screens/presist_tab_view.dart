//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/flavors_layer/delete_me.dart';
import 'package:instore/presentation_layer/screens/home_screens/home_page_screen.dart';
import 'package:instore/control_layer/managers/bottom_navigator_manager.dart';

PersistentTabController kController =
    PersistentTabController(initialIndex: Variables.zeroInt);
List<Widget> _buildScreens() {
  return const [
    HomePageScreen(),
    DeleteMe(),
    DeleteMe(),
    DeleteMe(),
    DeleteMe(),
  ];
}

class PresistTabView extends StatefulWidget {
  const PresistTabView({super.key});

  @override
  State<PresistTabView> createState() => _PresistTabViewState();
}

class _PresistTabViewState extends State<PresistTabView> {
  List<PersistentBottomNavBarItem> get navBarsItems {
    return [
      const BottomNavigatorManager(
        title: LocaleKeys.home,
        activeIconWidget: Icon(Icons.home_filled),
        inActiveIconWidget: Icon(Icons.home_outlined),
      ).navigatorItem,
      const BottomNavigatorManager(
        title: LocaleKeys.categories,
        activeIconWidget: Icon(Icons.grid_view_rounded),
        inActiveIconWidget: Icon(Icons.grid_view_outlined),
      ).navigatorItem,
      const BottomNavigatorManager(
        title: LocaleKeys.wishlist,
        activeIconWidget: Icon(CupertinoIcons.heart_fill),
        inActiveIconWidget: Icon(CupertinoIcons.heart),
      ).navigatorItem,
      const BottomNavigatorManager(
        title: LocaleKeys.cart,
        activeIconWidget: Icon(CupertinoIcons.cart_fill),
        inActiveIconWidget: Icon(CupertinoIcons.cart),
      ).navigatorItem,
      const BottomNavigatorManager(
        title: LocaleKeys.account,
        activeIconWidget: Icon(CupertinoIcons.person_fill),
        inActiveIconWidget: Icon(CupertinoIcons.person),
      ).navigatorItem,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: kController,
      screens: _buildScreens(),
      items: navBarsItems,
      navBarHeight: kScreenHeight * 0.1,
      confineInSafeArea: true,
      backgroundColor: AppColors.commonWhite,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        adjustScreenBottomPaddingOnCurve: true,
        borderRadius: BorderRadius.circular(Variables.zero),
        colorBehindNavBar: AppColors.commonWhite,
        boxShadow: <BoxShadow>[
          const BoxShadow(
            color: AppColors.blackBorder,
            blurRadius: Variables.five,
          ),
        ],
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: Variables.int200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: Variables.int200),
      ),
      navBarStyle: NavBarStyle.simple,
    );
  }
}
