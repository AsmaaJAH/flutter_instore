//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/data_layer/models/home_page_models/banner_model.dart';
import 'package:instore/data_layer/models/home_page_models/main_categories_model.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_appbar.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/categories_widget.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_sections/home_top_section/drop_down_menu_widget.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_sections/home_actions_middle_section.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_sections/home_bottom_section.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_sections/home_top_section/notifications_icon_widget.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_sections/home_top_section/search_bar_widget.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/slider_with_indicator.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    int counter = 2;
    bool isFocus = 1 == 2;
    String country = 'Saudi Arabia';
    return Scaffold(
      backgroundColor: AppColors.commonWhite,
      appBar: CustomizedAppBar(
        height: kScreenHeight * 0.09,
        isBottomLine: true,
        isBackIcon: false,
        isCentered: false,
        searchBar: SearchBarWidget(
          isFocus: isFocus,
          searchBarHint: LocaleKeys.searchBarHint,
        ),
        actions: [
          NotificationsIconWidget(counter: counter),
        ],
      ),
      body: Container(
        color: AppColors.commonWhite,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: kScreenWidth,
                height: kScreenHeight * 0.04,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: Variables.one, color: AppColors.darkGray),
                    //top: BorderSide(width: Variables.one, color: AppColors.darkGray),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: kScreenWidth * 0.05,
                    ),
                    Image.network(
                      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/255px-Flag_of_Egypt.svg.png",
                      fit: BoxFit.fitWidth,
                      width: kScreenWidth * 0.045,
                      height: kScreenHeight * 0.03,
                    ),
                    SizedBox(
                      width: kScreenWidth * 0.04,
                    ),
                    const CustomLocalizedTextWidget(
                      stringKey: LocaleKeys.deliverTo,
                      color: AppColors.grayWritings,
                      fontSize: Variables.double12,
                    ),
                    SizedBox(
                      width: kScreenWidth * 0.01,
                    ),
                    CustomLocalizedTextWidget(
                      stringKey: country,
                      isTranslate: false,
                      color: AppColors.grayWritings,
                      fontSize: Variables.double12,
                      fontWeight: CustomTextWeight.boldFont,
                    ),
                    SizedBox(
                      width: kScreenWidth * 0.32,
                    ),
                    const DropDownMenuWidget(
                      list: <String>[
                        LocaleKeys.change,
                        'Two',
                        'Three',
                        'Four',
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: kScreenHeight * 0.015,
              ),
              SliderWithIndicator(
                isWithIndicator: true,
                mediaItemsList: kAdBannersList,
                currentSlider: Variables.adBanner,
              ),
              SizedBox(
                height: kScreenHeight * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kScreenWidth * 0.05,
                ),
                child: Column(
                  children: [
                    CategoriesWidget(
                      data: kMainCategoriesResponse["data"] as List,
                    ),
                    HomeActionsMiddleSection(
                      onPressButton: () {},
                    ),
                    SizedBox(height: kScreenHeight * 0.02),
                    HomeActionsMiddleSection(
                      title: LocaleKeys.becomeVendor,
                      titleFontSize: Variables.double18,
                      titleColor: AppColors.black,
                      buttonText: LocaleKeys.signUp,
                      backgroundColor: AppColors.darkOffWhite,
                      description: LocaleKeys.becomeVendorBody,
                      borderColor: AppColors.darkOffWhite,
                      assetImagepath: AppImagesAssets.becomeVendorImagePath,
                      onPressButton: () {},
                    ),
                    SizedBox(height: kScreenHeight * 0.015),
                    const HomeBottomSection(
                      currentCard: Variables.bestSeller,
                    ),
                    SizedBox(height: kScreenHeight * 0.004),
                    const HomeBottomSection(
                      sectionTitle: LocaleKeys.exploreVendors,
                      currentCard: Variables.exploreVendors,
                    ),
                    SizedBox(height: kScreenHeight * 0.02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
