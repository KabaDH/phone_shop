import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/repos/basket_repo.dart';
import 'package:phone_shop/repos/details_repo.dart';
import 'package:phone_shop/repos/item_repo.dart';
import 'package:phone_shop/theme/palette.dart';
import 'package:phone_shop/widgets/widgets.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:phone_shop/models/models.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int selectedCategory = 0;

  final categoryList = [
    const ShopCategory(assetPath: 'assets/images/icon1.svg', name: 'Phones'),
    const ShopCategory(assetPath: 'assets/images/icon2.svg', name: 'Computer'),
    const ShopCategory(assetPath: 'assets/images/icon3.svg', name: 'Health'),
    const ShopCategory(assetPath: 'assets/images/icon4.svg', name: 'Books'),
    const ShopCategory(assetPath: 'assets/images/icon1.svg', name: 'Hidden'),
  ];

  @override
  Widget build(BuildContext context) {
    final listItems = ref.watch(providerItem);
    final listBestSellers = ref.watch(providerBestSellerItems);
    final basket = ref.watch(providerBasket);
    final details = ref.watch(providerProductDetails);

    return PixelPerfect(
      assetPath: 'assets/images/d_filters.png',
      scale: 1.05,
      offset: const Offset(0.0, -20.0),
      initOpacity: 0.3,
      child: Scaffold(
          body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ///location and filter line
            SliverPadding(
              padding: const EdgeInsets.only(left: 58, top: 17, right: 29),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                            assetPath: 'assets/images/location.svg',
                            color: Theme.of(context).primaryColor,
                            semanticsLabel: 'location',
                            height: 16,
                            onTap: () {}),
                        const SizedBox(
                          width: 11,
                        ),
                        Text(
                          'Zihuatanejo, Gro',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        GestureDetector(
                          onTap: () => debugPrint('Change location'),
                          child: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Palette.secondaryElementColor,
                            size: 20,
                          ),
                        )
                      ],
                    )),
                    SizedBox(
                      width: 13,
                      child: SvgIcon(
                        assetPath: 'assets/images/Filter.svg',
                        color: Palette.secondaryColor,
                        semanticsLabel: 'Filter',
                        height: 13.0,
                        onTap: () {
                          debugPrint('Filter called');
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///Category header
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 15, right: 30, top: 18, bottom: 10),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select Category',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: 24,
                            color: Palette.secondaryColor,
                          ),
                    ),
                    GestureDetector(
                      onTap: () => debugPrint('view all'),
                      child: Text(
                        'view all',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 14.5,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///Category list
            SliverPadding(
              padding: const EdgeInsets.only(left: 5),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 110,
                  child: ListView.builder(
                      itemCount: categoryList.length,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(top: 10),
                      itemBuilder: (context, index) {
                        var category = categoryList[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: Container(
                            child: BuildCategory(
                                assetPath: category.assetPath,
                                name: category.name,
                                isSelected: selectedCategory == index),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
