//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
    required this.isFocus,
    this.searchBarHint,
    this.searchController,
  });
  final bool isFocus;
  final String? searchBarHint;
  final SearchController? searchController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: kScreenWidth * 0.8,
      height: kScreenHeight * 0.055,
      child: SearchAnchor(
        searchController: searchController,
        viewBackgroundColor: AppColors.commonWhite,
        viewSurfaceTintColor: AppColors.commonWhite,
        dividerColor: AppColors.primary,
        isFullScreen: false,
        builder: (
          BuildContext context,
          SearchController controller,
        ) {
          return SearchBar(
            controller: controller,
            hintText: searchBarHint != null ? searchBarHint!.tr() : null,
            textStyle: MaterialStateProperty.resolveWith(
              (states) => TextThemeManager.lightFont(
                fontColor: AppColors.commonGray,
                fontSize: Variables.double13,
              ),
            ),
            hintStyle: MaterialStateProperty.resolveWith(
              (states) {
                if (states.contains(MaterialState.focused)) {
                  return TextThemeManager.lightFont(
                    fontColor: AppColors.primary,
                    fontSize: Variables.double12,
                  );
                } else {
                  return TextThemeManager.lightFont(
                    fontColor: AppColors.commonGray,
                    fontSize: Variables.double13,
                  );
                }
              },
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Variables.ten),
              ),
            ),
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) {
                if (states.contains(MaterialState.focused)) {
                  return const BorderSide(
                    width: Variables.double0_5,
                    color: AppColors.primary,
                  );
                } else {
                  return const BorderSide(
                    width: Variables.double0_5,
                    color: AppColors.commonGray,
                  );
                }
              },
            ),
            padding: const MaterialStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(
                horizontal: Variables.double16,
              ),
            ),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: Icon(
              Icons.search,
              color: isFocus ? AppColors.primary : AppColors.commonGray,
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => AppColors.commonWhite,
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => AppColors.commonWhite,
            ),
            shadowColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => AppColors.commonWhite,
            ),
            surfaceTintColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => AppColors.commonWhite,
            ),
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) => Variables.zero,
            ),
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(
            5,
            (int index) {
              final String item = 'item $index';
              return ListTile(
                tileColor: AppColors.commonWhite,
                title: Text(item),
                onTap: () {
                  // setState(() {
                  controller.closeView(item);
                  // });
                },
              );
            },
          );
        },
      ),
    );
  }
}
