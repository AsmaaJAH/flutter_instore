//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:instore/data_layer/models/home_page_models/notification_model.dart';
import 'package:instore/presentation_layer/screens/home_screens/notifications_screen.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class NotificationsIconWidget extends StatefulWidget {
  const NotificationsIconWidget({
    super.key,
    required this.counter,
  });
  final int counter;

  @override
  State<NotificationsIconWidget> createState() => _NotificationsIconWidgetState();
}

class _NotificationsIconWidgetState extends State<NotificationsIconWidget> {
  void onTapNotificationsWidget(BuildContext context) {
    PersistentNavBarNavigator.pushNewScreen(
      context,
      screen: NotificationsScreen(
        notificationsList: kNotificationsResponse["notifications"] as List,
        //[],
      ),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapNotificationsWidget(context);
      },
      child: Stack(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications_outlined,
              size: kScreenWidth * 0.09,
              color: AppColors.primary,
            ),
            onPressed: () {
              onTapNotificationsWidget(context);
            },
          ),
          widget.counter != Variables.zeroInt
              ? Positioned(
                  right: kScreenWidth * 0.065,
                  top: kScreenHeight * 0.017,
                  child: Container(
                    padding: const EdgeInsets.all(Variables.double0_5),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(Variables.ten),
                    ),
                    constraints: BoxConstraints(
                      minWidth: kScreenWidth * 0.04,
                      minHeight: kScreenWidth * 0.04,
                    ),
                    child: CustomLocalizedTextWidget(
                      isTranslate: false,
                      stringKey: '${widget.counter}',
                      textAlign: TextAlign.center,
                      style: TextThemeManager.boldFont(
                        fontColor: AppColors.white,
                        fontSize: Variables.double12,
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
