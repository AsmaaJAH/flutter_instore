//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/home_page_functions/home_assisant.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:transparent_image/transparent_image.dart';

class AdBannerCard extends StatelessWidget {
  const AdBannerCard({
    super.key,
    required this.adBannerTitle,
    required this.description,
    required this.imageURL,
  });
  final String adBannerTitle;
  final String description;
  final String imageURL;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: Variables.zero,
      color: AppColors.transparentBlack,
      child: Container(
        width: kScreenWidth * 0.9,
        height: kScreenHeight * 0.23,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Variables.ten)),
        ),
        child: Padding(
          padding: EdgeInsets.all(kScreenWidth * 0.06),
          child: Row(
            children: [
              SizedBox(
                width: kScreenWidth * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLocalizedTextWidget(
                      stringKey: adBannerTitle,
                      isTranslate: false,
                      color: AppColors.black,
                      fontSize: Variables.double18,
                      fontWeight: CustomTextWeight.boldFont,
                      maxLines: Variables.oneInt,
                      isThreeDotsInOverFlow: HomeAssistant.getIsOverflow(
                        text: adBannerTitle,
                        maxLength: Variables.int14,
                      ),
                    ),
                    SizedBox(
                      height: kScreenHeight * 0.01,
                    ),
                    CustomLocalizedTextWidget(
                      stringKey: description,
                      isTranslate: false,
                      color: AppColors.commonGray,
                      fontSize: Variables.double14,
                      fontWeight: CustomTextWeight.regularFont,
                      maxLines: Variables.threeInt,
                      isThreeDotsInOverFlow: HomeAssistant.getIsOverflow(
                        text: description,
                        maxLength: Variables.int57,
                      ),
                    ),
                    SizedBox(
                      height: kScreenHeight * 0.026,
                    ),
                    CustomizedButton(
                      width: kScreenWidth * 0.25,
                      backgroundColor: AppColors.totallyTransparentBlack,
                      borderColor: AppColors.primary,
                      borderRadius: Variables.eight,
                      textColor: AppColors.primary,
                      buttonText: LocaleKeys.explore,
                      onPressed: () {},
                      height: kScreenHeight * 0.04,
                      fontSize: Variables.double11,
                      fontWeight: CustomTextWeight.regularFont,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: kScreenWidth * 0.03,
              ),
              FadeInImage(
                width: kScreenWidth * 0.35,
                height: kScreenWidth * 0.35,
                placeholder: MemoryImage(
                    kTransparentImage), //in case the real image will take a long time to load
                image: NetworkImage(imageURL),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
