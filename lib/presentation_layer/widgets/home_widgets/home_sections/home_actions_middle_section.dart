//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';

class HomeActionsMiddleSection extends StatelessWidget {
  const HomeActionsMiddleSection({
    super.key,
    this.backgroundColor,
    this.borderColor,
    this.height,
    this.title,
    this.titleFontSize,
    this.titleColor,
    this.description,
    this.descriptionColor,
    this.assetImagepath,
    this.buttonText,
    this.descriptionWidth,
    this.onPressButton,
  });
  final String? title;
  final String? buttonText;
  final String? description;
  final String? assetImagepath;

  final double? titleFontSize;
  final double? descriptionWidth;
  final double? height;

  final Color? titleColor;
  final Color? descriptionColor;
  final Color? backgroundColor;
  final Color? borderColor;

  final void Function()? onPressButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? kScreenHeight * 0.215,
      width: kScreenWidth * 0.88,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Variables.double20),
        border: Border.all(
          color: borderColor ?? AppColors.grayBorder,
          width: Variables.double0_3,
        ),
        color: backgroundColor ?? AppColors.commonWhite,
      ),
      child: Card(
        elevation: Variables.zero,
        color: backgroundColor ?? AppColors.commonWhite,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            kScreenWidth * 0.045,
            kScreenWidth * 0.045,
            kScreenWidth * 0.015,
            kScreenWidth * 0.018,
          ),
          child: Row(
            children: [
              SizedBox(
                width: kScreenWidth * 0.46,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLocalizedTextWidget(
                      stringKey: title ?? LocaleKeys.requestServicetitle,
                      isTranslate: true,
                      color: titleColor ?? AppColors.commonBlack,
                      fontSize: titleFontSize ?? Variables.double22,
                      fontWeight: CustomTextWeight.boldFont,
                    ),
                    SizedBox(
                      height: kScreenHeight * 0.01,
                    ),
                    SizedBox(
                      width: descriptionWidth ?? kScreenWidth * 0.45,
                      child: CustomLocalizedTextWidget(
                        stringKey: description ?? LocaleKeys.requestServiceBody,
                        isTranslate: true,
                        color: descriptionColor ?? AppColors.black,
                        fontSize: Variables.double12,
                        fontWeight: CustomTextWeight.regularFont,
                        //maxLines: Variables.threeInt,
                        // isThreeDotsInOverFlow: HomeAssistant.getIsOverflow(
                        //   text: description ?? LocaleKeys.requestServiceBody,
                        //   maxLength: Variables.int57,
                        // ),
                      ),
                    ),
                    SizedBox(
                      height: kScreenHeight * 0.015,
                    ),
                    CustomizedButton(
                      width: kScreenWidth * 0.225,
                      borderRadius: Variables.five,
                      buttonText: buttonText ?? LocaleKeys.request,
                      onPressed: onPressButton,
                      height: kScreenHeight * 0.04,
                      fontSize: Variables.double12,
                      fontWeight: CustomTextWeight.boldFont,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: kScreenWidth * 0.03,
              ),
              Image.asset(
                assetImagepath ?? AppImagesAssets.requestServiceImagePath,
                width: kScreenWidth * 0.3,
                height: kScreenWidth * 0.3,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
