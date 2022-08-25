import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_shop/repos/basket_repo.dart';
import 'package:phone_shop/repos/details_repo.dart';
import 'package:phone_shop/repos/item_repo.dart';
import 'package:phone_shop/theme/palette.dart';
import 'package:phone_shop/widgets/widgets.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:phone_shop/models/models.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainScreen extends StatefulHookConsumerWidget {
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
    final hotSalesPageController = usePageController();

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
            ),

            /// Search Row
            SliverPadding(
              padding: EdgeInsets.only(
                  right: 32.w, left: 32.w, top: 19.h, bottom: 10.h),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      height: 40.h,
                      width: 300.w,
                      padding:
                          EdgeInsets.only(left: 24.w, right: 5.w, top: 9.h),
                      decoration: BoxDecoration(
                          color: Palette.iconBackgroundColor2,
                          borderRadius: BorderRadius.circular(50.h),
                          boxShadow: [
                            BoxShadow(
                                color: Palette.searchShadowColor,
                                blurRadius: 20.w)
                          ]),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                            isCollapsed: true,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    fontSize: 12.sp,
                                    color: Palette.secondaryColor
                                        .withOpacity(0.5)),
                            icon: SvgIcon(
                              assetPath: 'assets/images/search.svg',
                              color: Theme.of(context).primaryColor,
                              semanticsLabel: 'search',
                              height: 18.h,
                              onTap: () {
                                debugPrint('Search called');
                              },
                            )),
                      ),
                    )),
                    SizedBox(
                      width: 11.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        debugPrint('QR called');
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.h,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.primaryColor),
                        child: const SvgIcon(
                          assetPath: 'assets/images/qr.svg',
                          color: Colors.white,
                          semanticsLabel: 'qr',
                          boxFit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            ///HOT Sales Header
            SliverPadding(
              padding: EdgeInsets.only(
                left: 18.w,
                right: 33.w,
                top: 22.h,
              ),
              sliver: SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hot sales',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                            fontSize: 25.sp,
                            color: Palette.secondaryColor,
                          ),
                    ),
                    GestureDetector(
                      onTap: () => debugPrint('see more'),
                      child: Text(
                        'see more',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ),

            ///Hot Sales carousel
            SliverPadding(
              padding: EdgeInsets.only(bottom: 5.h),
              sliver: SliverToBoxAdapter(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 230.h,
                    child: listItems.when(data: (data) {
                      return PageView(
                        controller: hotSalesPageController,
                        reverse: true,
                        children: data
                            .asMap()
                            .map((key, value) => MapEntry(
                                key,
                                BuildHotSalesCard(
                                  item: data[key],
                                )))
                            .values
                            .toList(),
                      );
                    }, error: (_, __) {
                      return Container(
                        width: 380.w,
                        height: 220.h,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(11.w)),
                        child:
                            const Center(child: Text('Error loading ItemList')),
                      );
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
              ),
            )
          ],
        ),
      )),
    );
  }
}
