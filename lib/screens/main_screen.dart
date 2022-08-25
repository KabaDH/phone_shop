import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              padding: EdgeInsets.only(left: 60.w, top: 18.w, right: 32.w),
              sliver: SliverToBoxAdapter(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                            assetPath: 'assets/images/location.svg',
                            color: Theme.of(context).primaryColor,
                            semanticsLabel: 'location',
                            height: 16.sp,
                            onTap: () {}),
                        SizedBox(
                          width: 11.w,
                        ),
                        Text(
                          'Zihuatanejo, Gro',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        GestureDetector(
                          onTap: () => debugPrint('Change location'),
                          child: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Palette.secondaryElementColor,
                            size: 21.w,
                          ),
                        )
                      ],
                    )),
                    SvgIcon(
                      assetPath: 'assets/images/Filter.svg',
                      color: Palette.secondaryColor,
                      semanticsLabel: 'Filter',
                      height: 16.h,
                      onTap: () {
                        debugPrint('Filter called');
                      },
                    )
                  ],
                ),
              ),
            ),

            ///Category header
            SliverPadding(
              padding: EdgeInsets.only(
                left: 18.w,
                right: 33.w,
                top: 22.h,
                bottom: 15.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Select Category',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: 25.sp,
                            color: Palette.secondaryColor,
                          ),
                    ),
                    GestureDetector(
                      onTap: () => debugPrint('view all'),
                      child: Text(
                        'view all',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///Category list
            SliverPadding(
              padding: EdgeInsets.only(left: 27.w),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                  height: 145.h,
                  child: ListView.builder(
                      itemCount: categoryList.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(top: 10.h),
                      itemBuilder: (context, index) {
                        var category = categoryList[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: BuildCategory(
                              assetPath: category.assetPath,
                              name: category.name,
                              isSelected: selectedCategory == index),
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
