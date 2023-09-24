//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_images_paths/app_images_uri.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/home_page_functions/home_assisant.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:transparent_image/transparent_image.dart';

//-------------------------- InStore App Imports ----------------------------------

class ExploreVendorsCard extends StatelessWidget {
  const ExploreVendorsCard({
    super.key,
    this.imageURL,
    required this.vendorName,
    this.description,
    required this.onPressButton,
  });
  final String? imageURL;
  final String vendorName;
  final String? description;
  final void Function()? onPressButton;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.commonWhite,
      elevation: Variables.zero,
      margin: EdgeInsets.symmetric(horizontal: kScreenWidth * 0.018),
      child: SizedBox(
        width: kScreenWidth * 0.37,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: kScreenWidth * 0.37,
              height: kScreenHeight * 0.4 * 0.28,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.offWhiteBorder,
                ),
              ),
              child: Container(
                width: kScreenWidth * 0.37,
                height: kScreenHeight * 0.4 * 0.28,
                color: AppColors.commonWhite,
                child: Center(
                  child: FadeInImage(
                    placeholder: MemoryImage(
                      kTransparentImage,
                    ), //in case the real image will take a long time to load
                    image: imageURL != null
                        ? NetworkImage(imageURL!)
                        : NetworkImage(AppImagesURI.placeholderImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: kScreenHeight * 0.01),
            CustomLocalizedTextWidget(
              stringKey: vendorName,
              isTranslate: false,
              maxLines: Variables.oneInt,
              fontSize: Variables.double16,
              color: AppColors.blackExploreVendors,
              isThreeDotsInOverFlow: HomeAssistant.getIsOverflow(
                text: vendorName,
                maxLength: Variables.int14,
              ),
            ),
            SizedBox(height: kScreenHeight * 0.008),
            SizedBox(
              height: kScreenHeight * 0.08,
              child: CustomLocalizedTextWidget(
                stringKey: description != null ? description! : "",
                isTranslate: false,
                maxLines: Variables.threeInt,
                fontSize: Variables.double14,
                color: AppColors.commonBlack,
                isThreeDotsInOverFlow: HomeAssistant.getIsOverflow(
                  text: description,
                  maxLength: Variables.int70,
                ),
              ),
            ),
            SizedBox(height: kScreenHeight * 0.01),
            CustomizedButton(
              height: kScreenHeight * 0.035,
              width: kScreenWidth * 0.37,
              fontSize: Variables.double11,
              fontWeight: CustomTextWeight.regularFont,
              buttonText: LocaleKeys.explore,
              textColor: AppColors.primary,
              backgroundColor: AppColors.commonWhite,
              borderColor: AppColors.primary,
              borderWidth: Variables.double0_7,
              onPressed: onPressButton,
            ),
            Container(
              height: kScreenHeight * 0.01,
              color: AppColors.commonWhite,
            ),
          ],
        ),
      ),
    );
  }
}
