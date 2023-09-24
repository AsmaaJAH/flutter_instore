//-------------------------- Flutter Packages Imports ----------------------------------
import 'package:flutter/material.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_enum.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/data_layer/models/home_page_models/best_seller_model.dart';
import 'package:instore/data_layer/models/home_page_models/explore_vendors_model.dart';
import 'package:instore/presentation_layer/widgets/custom_localized_text_widget.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_cards/best_seller_card.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_cards/explore_vendors_card.dart';
import 'package:instore/translations/locale_keys.g.dart';

class HomeBottomSection extends StatelessWidget {
  const HomeBottomSection({
    super.key,
    this.sectionTitle,
    this.currentCard,
  });
  final String? sectionTitle;
  final String? currentCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: kScreenHeight * 0.01),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kScreenWidth * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomLocalizedTextWidget(
                  color: AppColors.blackTitle,
                  stringKey: sectionTitle ?? LocaleKeys.bestSeller,
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
            height: kScreenHeight * 0.3,
            child: ListView.builder(
              itemCount: Variables.fourInt,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                if (currentCard == Variables.bestSeller) {
                  var bestSellerList = kBestSellerProducts["products"] as List;
                  Map item = bestSellerList[index];
                  bool isInStock = bestSellerList[index]["in_stock"];

                  if (isInStock) {
                    return BestSellerCard(
                      cardIndex: index,
                      productTitle: item["name"],
                      productRating: item["avg_rating"],
                      reviewsCount: item["reviews_count"],
                      imageURL: item["default_variant"]["image"],
                      currency: item["default_variant"]["currency"] ??
                          item["currency"],
                      price: item["default_variant"]["price"] ?? item["price"],
                      discount: "30",
                      onPressAddToCart: () {},
                    );
                  } else {
                    return null;
                  }
                } else {
                  var vendorsList =
                      kVendorsWithoutProductsDetails["vendors"] as List;
                  return ExploreVendorsCard(
                    vendorName: vendorsList[index]["company_name"],
                    description: vendorsList[index]["company_description"],
                    onPressButton: () {},
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
