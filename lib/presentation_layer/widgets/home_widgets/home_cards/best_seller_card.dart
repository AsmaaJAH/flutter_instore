//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_images_paths/app_images_uri.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/control_layer/functions/home_page_functions/home_assisant.dart';
import 'package:instore/control_layer/managers/themes_manager/text_theme_manager.dart';
import 'package:instore/data_layer/providers/widgets_providers/home_page_widgets_providers/favourite_provider.dart';
import 'package:instore/presentation_layer/app_snack_bar.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/customized_button.dart';
import 'package:instore/translations/locale_keys.g.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';

class BestSellerCard extends StatefulWidget {
  const BestSellerCard({
    super.key,
    required this.imageURL,
    required this.productTitle,
    required this.productRating,
    required this.reviewsCount,
    required this.currency,
    required this.price,
    required this.discount,
    required this.onPressAddToCart,
    required this.cardIndex,
  });
  final String? imageURL;
  final String productTitle;
  final String productRating;
  final int reviewsCount;
  final int cardIndex;
  final String? currency;
  final String? price;
  final String discount;
  final void Function()? onPressAddToCart;

  @override
  State<BestSellerCard> createState() => _BestSellerCardState();
}

class _BestSellerCardState extends State<BestSellerCard> {
  String get reviewsCountWithComma {
    return HomeAssistant.putCommaInThousands(number: widget.reviewsCount);
  }

  void onPressFavourites({
    required FavouriteProviderState favouriteState,
    required bool isFavourite,
  }) {
    favouriteState.updateIsFavourite(
      index: widget.cardIndex,
      value: !isFavourite,
    );
    var isCurrentlyFavourited = favouriteState.isFavourite[widget.cardIndex];
    if (isCurrentlyFavourited) {
      AppSnackBar(
        context: context,
        message: LocaleKeys.addToFavourites,
        backgroundColor: AppColors.commonBlack,
        prefix: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Variables.ten, vertical: Variables.five),
          child: Icon(
            Icons.library_add_check_outlined,
            size: Variables.double26,
            color: AppColors.white,
          ),
        ),
      ).showAppSnackBar();
    } else {
      AppSnackBar(
        context: context,
        message: LocaleKeys.removeFromFavourites,
        backgroundColor: AppColors.commonBlack,
        prefix: const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Variables.ten, vertical: Variables.five),
          child: Icon(
            Icons.delete_outlined,
            size: Variables.double26,
            color: AppColors.white,
          ),
        ),
      ).showAppSnackBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    FavouriteProviderState favouriteState =
        context.watch<FavouriteProviderState>();
    return Card(
      color: AppColors.commonWhite,
      elevation: Variables.zero,
      margin: EdgeInsets.all(kScreenWidth * 0.018),
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
              )),
              child: Container(
                width: kScreenWidth * 0.37,
                height: kScreenHeight * 0.4 * 0.28,
                color: AppColors.commonWhite,
                child: Selector<FavouriteProviderState, bool>(
                    selector: (_, provider) =>
                        provider.isFavourite[widget.cardIndex],
                    builder: (context, isFavourite, child) {
                      return Stack(
                        children: [
                          Positioned.fill(
                            top: kScreenWidth * 0.05,
                            left: kScreenWidth * 0.285,
                            bottom: kScreenWidth * 0.138,
                            right: kScreenWidth * 0.051,
                            child: Container(
                              width: kScreenWidth * 0.01,
                              height: kScreenWidth * 0.01,
                              color: isFavourite
                                  ? AppColors.red
                                  : AppColors.grayFilling, // Color
                            ),
                          ),
                          Positioned(
                            left: kScreenWidth * 0.24,
                            child: IconButton(
                              onPressed: () {
                                onPressFavourites(
                                  favouriteState: favouriteState,
                                  isFavourite: isFavourite,
                                );
                              },
                              icon: AnimatedSwitcher(
                                duration: const Duration(
                                  milliseconds: Variables.int750,
                                ),
                                transitionBuilder: (child, animation) {
                                  return SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(
                                          Variables.ngtveOne,
                                          Variables.zero,
                                        ),
                                        end: const Offset(
                                          Variables.zero,
                                          Variables.zero,
                                        ),
                                      ).animate(animation),
                                      child: child);
                                },
                                child: Icon(
                                  key: ValueKey(isFavourite),
                                  CupertinoIcons.heart_circle_fill,
                                  color: isFavourite
                                      ? AppColors.lightRed
                                      : AppColors.grayFavouriteIcon,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: FadeInImage(
                              placeholder: MemoryImage(
                                kTransparentImage,
                              ), //in case the real image will take a long time to load
                              image: widget.imageURL != null
                                  ? NetworkImage(widget.imageURL!)
                                  : NetworkImage(AppImagesURI.placeholderImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
            SizedBox(
              height: kScreenHeight * 0.01,
            ),
            CustomLocalizedTextWidget(
              stringKey: widget.productTitle,
              isTranslate: false,
              maxLines: Variables.twoInt,
              isThreeDotsInOverFlow: HomeAssistant.getIsOverflow(
                text: widget.productTitle,
                maxLength: Variables.int34,
              ),
            ),
            SizedBox(height: kScreenHeight * 0.005),
            Row(
              children: [
                RatingBarIndicator(
                  rating: double.parse(widget.productRating),
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: AppColors.yellowStars,
                    size: Variables.double18,
                  ),
                  itemCount: Variables.fiveInt,
                  itemSize: Variables.double18,
                  direction: Axis.horizontal,
                  unratedColor: AppColors.yellowUnratedStares,
                ),
                SizedBox(
                  width: kScreenWidth * 0.01,
                ),
                CustomLocalizedTextWidget(
                  stringKey: "($reviewsCountWithComma)",
                  isTranslate: false,
                  color: AppColors.grayReviewCounts,
                  fontWeight: CustomTextWeight.lightFont,
                  fontSize: Variables.ten,
                ),
              ],
            ),
            SizedBox(height: kScreenHeight * 0.005),
            Padding(
              padding: const EdgeInsets.all(Variables.one),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: widget.currency ?? "",
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.price != null ? "  ${widget.price}" : "",
                          style: TextThemeManager.boldFont(
                            fontColor: AppColors.commonBlack,
                            fontSize: Variables.double14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: AppColors.blue,
                    width: kScreenWidth * 0.1,
                    padding: const EdgeInsets.all(Variables.one),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomLocalizedTextWidget(
                          stringKey: "${widget.discount}% ",
                          isTranslate: false,
                          color: AppColors.white,
                          fontWeight: CustomTextWeight.mediumFont,
                          fontSize: Variables.eight,
                        ),
                        const CustomLocalizedTextWidget(
                          stringKey: LocaleKeys.offerDiscount,
                          color: AppColors.white,
                          fontWeight: CustomTextWeight.mediumFont,
                          fontSize: Variables.eight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: kScreenHeight * 0.01),
            CustomizedButton(
              height: kScreenHeight * 0.03515,
              width: kScreenWidth * 0.37,
              fontSize: Variables.double11,
              fontWeight: CustomTextWeight.mediumFont,
              buttonText: LocaleKeys.addToCart,
              onPressed: widget.onPressAddToCart,
              leading: Container(),
              trailer: Padding(
                  padding: EdgeInsets.only(right: kScreenWidth * 0.035),
                  child: const Icon(
                    CupertinoIcons.cart_fill,
                    color: AppColors.white,
                    size: Variables.double15,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
