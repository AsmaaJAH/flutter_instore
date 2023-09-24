//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instore/constants/app_assistant_values/server_constants.dart';

//-------------------------- InStore App Imports ----------------------------------

import 'package:instore/constants/app_images_paths/app_images_assets.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/home_page_functions/home_assisant.dart';
import 'package:instore/control_layer/functions/user_current_status.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_appbar.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({
    super.key,
    required this.notificationsList,
  });
  final List? notificationsList;

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String get currentLanguageCode {
    UserCurrentStatus.getAppCurrentLanguageCode(context);
    return ServerConstants.currentLanguageCode;
  }

  bool get isEnglishLTRdirection {
    if (currentLanguageCode == Variables.enLangCode) {
      return true;
    } else {
// currentLanguageCode== Variables.arLangCode
      return false;
    }
  }

  Widget get body {
    if (widget.notificationsList == null ||
        widget.notificationsList!.length == Variables.zeroInt) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImagesAssets.emptyNotificationsImagePath,
              fit: BoxFit.cover,
            ),
            SizedBox(height: kScreenHeight * 0.04),
            const CustomLocalizedTextWidget(
              stringKey: LocaleKeys.emptyNotifications,
              color: AppColors.blackEmptyNotifications,
              fontWeight: CustomTextWeight.mediumFont,
              fontSize: Variables.double22,
            ),
            SizedBox(height: kScreenHeight * 0.01),
            const CustomLocalizedTextWidget(
              stringKey: LocaleKeys.emptyNotificationsBody,
              color: AppColors.blackEmptyNotifications,
              fontSize: Variables.double16,
            ),
            SizedBox(height: kScreenHeight * 0.01),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: widget.notificationsList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: kScreenWidth * 0.03,
              vertical: kScreenWidth * 0.005,
            ),
            child: ListTile(
              shape: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.grayNotificationsUnderLineBorder,
                  width: Variables.double0_5,
                ),
              ),
              onTap: () {},
              focusColor: AppColors.primary,
              hoverColor: AppColors.primary,
              leading: Container(
                width: kScreenWidth * 0.13,
                height: kScreenWidth * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(kScreenWidth * 0.13),
                  border: Border.all(
                    color: AppColors.primary,
                  ),
                ),
                child:
                    const Icon(CupertinoIcons.cart, color: AppColors.primary),
              ),
              title: RichText(
                text: TextSpan(
                  locale: isEnglishLTRdirection
                      ? Variables.enUsLocale
                      : Variables.arSaLocale,
                  text: HomeAssistant.replaceDotAtEnd(
                    text: isEnglishLTRdirection
                        ? widget.notificationsList![index]["title"]
                            .toString()
                            .trim()
                        : widget.notificationsList![index]["ar_title"]
                            .toString()
                            .trim(),
                  ),
                  style: TextThemeManager.mediumFont(
                    fontColor: AppColors.grayNotifications,
                    fontSize: Variables.double16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      locale: isEnglishLTRdirection
                          ? Variables.enUsLocale
                          : Variables.arSaLocale,
                      text: isEnglishLTRdirection
                          ? widget.notificationsList![index]["message"]
                              .toString()
                          : widget.notificationsList![index]["ar_message"]
                              .toString(),
                      style: TextThemeManager.regularFont(
                        fontColor: AppColors.grayNotifications,
                        fontSize: Variables.double16,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Align(
                alignment: Alignment.bottomRight,
                child: CustomLocalizedTextWidget(
                  isTranslate: false,
                  stringKey: LocaleKeys.notificationTime.tr(namedArgs: {
                    'currentDate': HomeAssistant.formateTime(
                        timeString: widget.notificationsList![index]["sent_at"]
                            .toString())
                  }),
                  color: AppColors.grayNotifications,
                  fontSize: Variables.double12,
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.commonWhite,
      appBar: const CustomizedAppBar(
        backgroundColor: AppColors.white,
        title: LocaleKeys.notifications,
        isBottomLine: true,
      ),
      body: body,
    );
  }
}
