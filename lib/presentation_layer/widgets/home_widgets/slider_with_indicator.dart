//-------------------------- Flutter Packages Imports ----------------------------------

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//-------------------------- InStore App Imports ----------------------------------
import 'package:instore/constants/app_colors.dart';
import 'package:instore/constants/app_screen_dimensions.dart';
import 'package:instore/data_layer/providers/widgets_providers/home_page_widgets_providers/slider_with_indicator_provider.dart';
import 'package:instore/constants/app_assistant_values/variables.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_cards/ad_banner_card.dart';
import 'package:instore/presentation_layer/widgets/home_widgets/home_cards/single_category_card.dart';

class SliderWithIndicator extends StatefulWidget {
  const SliderWithIndicator({
    super.key,
    required this.currentSlider,
    required this.mediaItemsList,
    required this.isWithIndicator,
    this.aspectRatio,
    this.height,
    this.carouselController,
    this.isAutoPlayed,
    this.isReversed,
  });
  final List mediaItemsList;
  final bool isWithIndicator;
  final bool? isAutoPlayed;
  final bool? isReversed;
  final double? aspectRatio;
  final double? height;
  final String currentSlider;
  final CarouselController? carouselController;

  @override
  State<SliderWithIndicator> createState() => _SliderWithIndicatorState();
}

class _SliderWithIndicatorState extends State<SliderWithIndicator> {
  late SliderWithIndicatorProviderState readProvider;

  @override
  void initState() {
    super.initState();
    readProvider = context.read<SliderWithIndicatorProviderState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: widget.carouselController,
          options: CarouselOptions(
            aspectRatio: widget.aspectRatio ?? 343 / 150,
            viewportFraction: Variables.one,
            initialPage: Variables.zeroInt,
            enableInfiniteScroll: true,
            reverse: widget.isReversed ?? false,
            autoPlayInterval: const Duration(milliseconds: Variables.int2200),
            autoPlayAnimationDuration:
                const Duration(milliseconds: Variables.int500),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
            autoPlay: widget.isAutoPlayed ?? true,
            height: widget.height ?? kScreenHeight * 0.26,
            onPageChanged: (index, reason) {
              readProvider.updateCurrentActiveIndex(index);
              //just to make sure
              if (index == widget.mediaItemsList.length) {
                readProvider.updateCurrentActiveIndex(0);
              }
            },
          ),
          items: widget.mediaItemsList.map((item) {
            return Builder(
              builder: (BuildContext context) {
                if (widget.currentSlider == Variables.adBanner) {
                  return AdBannerCard(
                    adBannerTitle: item["title"],
                    description: item["description"],
                    imageURL: item["image"],
                  );
                } else {
                  //else return empty card with something went wrong message:
                  return const SingleCategoryCard();
                }
              },
            );
          }).toList(),
        ),
        widget.isWithIndicator
            ? Column(
                children: [
                  SizedBox(
                    height: kScreenHeight * 0.007,
                  ),
                  Selector<SliderWithIndicatorProviderState, int>(
                    selector: (_, provider) => provider.currentActiveIndex,
                    builder: (context, currentActiveIndex, child) {
                      // if (currentActiveIndex >= widget.mediaItems.length) {
                      //   //array=[1,2,3,4,5]
                      //   //length=5
                      //   //index 0------> 4
                      //   readProvider.updateCurrentActiveIndex(0);
                      // }
                      return AnimatedSmoothIndicator(
                        activeIndex: currentActiveIndex,
                        count: widget.mediaItemsList.length,
                        effect: CustomizableEffect(
                          activeDotDecoration: DotDecoration(
                            width: Variables.double22,
                            height: Variables.six,
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(Variables.ten),
                          ),
                          dotDecoration: DotDecoration(
                            width: Variables.double22,
                            height: Variables.six,
                            color: AppColors.blackIndicator,
                            borderRadius: BorderRadius.circular(Variables.ten),
                            verticalOffset: Variables.zero,
                          ),
                          spacing: Variables.seven,
                        ),
                      );
                    },
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
