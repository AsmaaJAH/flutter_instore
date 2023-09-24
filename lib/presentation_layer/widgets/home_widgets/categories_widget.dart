//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_cards/single_category_card.dart';
import 'package:instore/translations/locale_keys.g.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.data,
  });
  final List data;
  int get gridViewActualLength {
    if (data.length == Variables.zeroInt) {
      return Variables.oneInt;
    } else if (data.length < Variables.sixInt) {
      return data.length;
    } else {
      //if bigger than or equal 6 then return 6:
      return Variables.sixInt;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: kScreenWidth * 0.014),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CustomLocalizedTextWidget(
                color: AppColors.blackTitle,
                stringKey: LocaleKeys.ourCategories,
                fontSize: Variables.double18,
                fontWeight: CustomTextWeight.boldFont,
              ),
              InkWell(
                onTap: () {},
                child: const Row(
                  children: [
                    CustomLocalizedTextWidget(
                      color: AppColors.blackTitle,
                      fontSize: Variables.double12,
                      fontWeight: CustomTextWeight.boldFont,
                      stringKey: LocaleKeys.seeAll,
                    ),
                    SizedBox(
                      width: Variables.three,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.blackTitle,
                      size: Variables.double15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: kScreenHeight * 0.01,
        ),
        SizedBox(
          height: kScreenHeight * 0.34,
          child: GridView.count(
            crossAxisCount: Variables.threeInt,
            children: List<Widget>.generate(gridViewActualLength, (index) {
              if (data.length == Variables.zeroInt) {
                return const SingleCategoryCard();
              } else {
                return GridTile(
                  child: SingleCategoryCard(
                    title: data[index]["attributes"]["name"],
                    imageURL: data[index]["attributes"]["image"],
                  ),
                );
              }
            }),
          ),
        )
      ],
    );
  }
}
