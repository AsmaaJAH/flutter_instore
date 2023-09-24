//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_images_paths/app_images_uri.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/home_page_functions/home_assisant.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleCategoryCard extends StatelessWidget {
  const SingleCategoryCard({
    super.key,
    this.imageURL,
    this.title,
  });
  final String? imageURL;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.blackBackground,
      elevation: Variables.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: Padding(
        padding: EdgeInsets.all(kScreenWidth * 0.02),
        child: Column(
          children: [
            SizedBox(height: kScreenHeight * 0.01),
            FadeInImage(
              width: kScreenWidth * 0.12,
              height: kScreenWidth * 0.12,
              placeholder: MemoryImage(
                kTransparentImage,
              ), //in case the real image will take a long time to load
              image: imageURL != null
                  ? NetworkImage(imageURL!)
                  : NetworkImage(AppImagesURI.placeholderImage),
              fit: BoxFit.cover,
            ),
            SizedBox(height: kScreenHeight * 0.008),
            title != null
                ? CustomLocalizedTextWidget(
                    stringKey: title!,
                    isTranslate: false,
                    textAlign: TextAlign.center,
                    color: AppColors.primary,
                    fontSize: Variables.double12,
                    maxLines: Variables.twoInt,
                    isThreeDotsInOverFlow: HomeAssistant.getIsOverflow(
                      text: title,
                      maxLength: Variables.int26,
                    ),
                    fontWeight: CustomTextWeight.boldFont,
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(horizontal: Variables.five),
                    child: CustomLocalizedTextWidget(
                      stringKey: LocaleKeys.someThingWentWrong,
                      isTranslate: true,
                      color: AppColors.primary,
                      fontSize: Variables.double11,
                      fontWeight: CustomTextWeight.regularFont,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
