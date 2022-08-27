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
  final GlobalKey<ScaffoldState> key = GlobalKey();
  int selectedCategory = 0;
  bool showFilter = false;
  String? filterBrand;
  List<int>? filterPrice;

  final categoryList = [
    const ShopCategory(assetPath: 'assets/images/icon1.svg', name: 'Phones'),
    const ShopCategory(assetPath: 'assets/images/icon2.svg', name: 'Computer'),
    const ShopCategory(assetPath: 'assets/images/icon3.svg', name: 'Health'),
    const ShopCategory(assetPath: 'assets/images/icon4.svg', name: 'Books'),
    const ShopCategory(assetPath: 'assets/images/icon1.svg', name: 'Hidden'),
  ];

  final brands = ['Samsung', 'Xiaomi', 'Motorola'];

  final pricesRanges = {
    '\$0 - \$300': [0, 300],
    '\$300 - \$500': [300, 500],
    '\$500 - \$1000': [500, 1000],
    '\$1000 - \$10.000': [1000, 10000],
  };

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    final listItems = ref.watch(providerItem);
    final listBestSellers = ref.watch(providerBestSellerItems);
    final basket = ref.watch(providerBasket);
    final hotSalesPageController = usePageController();

    return PixelPerfect(
      assetPath: 'assets/images/d_filters.png',
      scale: 1.05,
      offset: const Offset(0.0, -140.0), //Offset(0.0, -20.0) -92 -140
      initOpacity: 0.3,
      child: Stack(children: [
        SizedBox(
          width: screenSize.width,
          height: screenSize.height,
        ),
        Scaffold(
          key: key,
          body: SafeArea(
            child: GestureDetector(
              onTap: () => {
                FocusScope.of(context).unfocus(),
                setState(() {
                  showFilter = false;
                })
              },
              child: CustomScrollView(
                slivers: [
                  ///location and filter line
                  SliverPadding(
                    padding:
                        EdgeInsets.only(left: 60.w, top: 18.w, right: 32.w),
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
                              setState(() {
                                showFilter = !showFilter;
                              });
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
                    ),
                    sliver: BuildHomeScreenHeader(
                        headerText: 'Select Category',
                        actionText: 'view all',
                        action: () => debugPrint('view all')),
                  ),

                  ///Category list
                  SliverPadding(
                    padding: EdgeInsets.only(left: 27.w, top: 15.h),
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
                            padding: EdgeInsets.only(
                                left: 24.w, right: 5.w, top: 9.h),
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
                    sliver: BuildHomeScreenHeader(
                        headerText: 'Hot sales',
                        actionText: 'see more',
                        action: () => debugPrint('see more')),
                  ),

                  ///Hot Sales carousel
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 230.h,
                      child: listItems.when(data: (data) {
                        if (data.isEmpty) {
                          return const SizedBox.shrink();
                        } else {
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
                        }
                      }, error: (_, __) {
                        return Container(
                          width: 380.w,
                          height: 220.h,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(11.w)),
                          child: const Center(
                              child: Text('Error loading ItemList')),
                        );
                      }, loading: () {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    ),
                  ),

                  ///Best Seller Header
                  SliverPadding(
                    padding: EdgeInsets.only(
                      left: 18.w,
                      right: 27.w,
                      top: 9.h,
                    ),
                    sliver: BuildHomeScreenHeader(
                        headerText: 'Best Seller',
                        actionText: 'see more',
                        action: () => debugPrint('see more best sellers')),
                  ),

                  ///Best Seller`s grid
                  SliverPadding(
                    padding:
                        EdgeInsets.only(left: 17.w, right: 18.w, top: 15.h),
                    sliver: listBestSellers.when(data: (data) {
                      var filteredData = data;

                      if (filterBrand != null) {
                        filteredData = filteredData
                            .where((element) =>
                                element.title.contains(RegExp(filterBrand!)))
                            .toList();
                      }
                      if (filterPrice != null) {
                        filteredData = filteredData
                            .where((element) =>
                                element.discount_price > filterPrice![0] &&
                                element.discount_price <= filterPrice![1])
                            .toList();
                      }

                      if (filteredData.isEmpty &&
                          ((filterPrice != null) || (filterBrand != null))) {
                        return SliverToBoxAdapter(
                          child: Container(
                            width: 380.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(11.w)),
                            child: const Center(
                                child: Text('No data matches to your search')),
                          ),
                        );
                      } else {
                        return SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 11.w,
                                  mainAxisSpacing: 15.h,
                                  mainAxisExtent: 270.h),
                          delegate: SliverChildBuilderDelegate(
                              childCount: filteredData.length,
                              (BuildContext context, int index) {
                            return BuildBestSellerCard(
                                dataItem: filteredData[index]);
                          }),
                        );
                      }
                    }, error: (_, __) {
                      return SliverToBoxAdapter(
                        child: Container(
                          width: 380.w,
                          height: 220.h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(11.w)),
                          child: const Center(
                              child: Text('Error loading BestSellers')),
                        ),
                      );
                    }, loading: () {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.circular(30.h),
            child: Container(
              width: screenSize.width,
              height: 82.h,
              decoration: const BoxDecoration(
                color: Palette.secondaryColor,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 15.h, bottom: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      Container(
                        width: 10.w,
                        height: 10.h,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        'Explorer',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.white, fontSize: 14.sp),
                      ),
                    ]),
                    SvgIcon(
                      assetPath: 'assets/images/shoppingBag.svg',
                      color: Colors.white,
                      semanticsLabel: 'Shopping bag',
                      width: 18.w,
                      onTap: () => debugPrint('Shopping bag called'),
                    ),
                    SvgIcon(
                      assetPath: 'assets/images/fav_outlined.svg',
                      color: Colors.white,
                      semanticsLabel: 'Favorites',
                      width: 18.w,
                      onTap: () => debugPrint('Favorites called'),
                    ),
                    SvgIcon(
                      assetPath: 'assets/images/personIcon.svg',
                      color: Colors.white,
                      semanticsLabel: 'Profile',
                      width: 18.w,
                      onTap: () => debugPrint('Profile called'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        ///Filter block
        AnimatedPositioned(
            bottom: showFilter ? 0.0 : -441.0.h,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.h),
              child: Container(
                width: screenSize.width,
                height: 441.h,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                      color: Palette.filterShadowColor,
                      blurRadius: 20,
                      offset: Offset(0, -5.h))
                ]),
                child: ListView(
                  padding: EdgeInsets.only(left: 44.w, right: 20.w, top: 21.h),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWithIcon(
                          icon: Icon(
                            Icons.close,
                            size: 20.h,
                            color: Colors.white,
                          ),
                          color: Palette.secondaryColor,
                          callback: () {
                            setState(() {
                              showFilter = !showFilter;
                              filterBrand = null;
                              filterPrice = null;
                            });
                          },
                        ),
                        Text(
                          '      Filter options',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: 18.sp,
                                  color: Palette.secondaryColor),
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                showFilter = !showFilter;
                              });
                            },
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.h)),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(fontSize: 18.sp),
                              backgroundColor: Theme.of(context).primaryColor,
                              fixedSize: Size(86.w, 37.h),
                            ),
                            child: const Text('Done'))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 1.w, right: 9.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 43.h,
                          ),
                          Text(
                            'Brand',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: 18.sp,
                                    color: Palette.secondaryColor),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.h, right: 9.w),
                            height: 45.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                border: Border.all(
                                  color: Palette.filterBorderColor,
                                  width: 1.w,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  onChanged: (e) {
                                    setState(() {
                                      filterBrand = e;
                                    });
                                  },
                                  isExpanded: true,
                                  isDense: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontSize: 18.sp,
                                          color: Palette.secondaryColor),
                                  hint: Text(brands.first),
                                  value: filterBrand ?? brands.first,
                                  items: brands
                                      .map((e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(
                                              e,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Palette.secondaryElementColor,
                                    size: 30.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Text(
                            'Price',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: 18.sp,
                                    color: Palette.secondaryColor),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.h, right: 9.w),
                            height: 45.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                border: Border.all(
                                  color: Palette.filterBorderColor,
                                  width: 1.w,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<List<int>>(
                                  onChanged: (e) {
                                    setState(() {
                                      filterPrice = e;
                                    });
                                  },
                                  isExpanded: true,
                                  isDense: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontSize: 18.sp,
                                          color: Palette.secondaryColor),
                                  hint: Text(brands.first),
                                  value: filterPrice ??
                                      pricesRanges['\$0 - \$300'],
                                  items: pricesRanges
                                      .map((key, value) => MapEntry(
                                          key,
                                          DropdownMenuItem(
                                            value: value,
                                            child: Text(key),
                                          )))
                                      .values
                                      .toList(),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Palette.secondaryElementColor,
                                    size: 30.w,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
                          Text(
                            'Size',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: 18.sp,
                                    color: Palette.secondaryColor),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.h, right: 9.w),
                            height: 45.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.h),
                                border: Border.all(
                                  color: Palette.filterBorderColor,
                                  width: 1.w,
                                )),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton<String>(
                                  onChanged: (e) {
                                    setState(() {});
                                  },
                                  isExpanded: true,
                                  isDense: true,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                          fontSize: 18.sp,
                                          color: Palette.secondaryColor),
                                  hint: const Text('4.5 to 5.5 inches'),
                                  value: '4.5 to 5.5 inches',
                                  items: const [
                                    DropdownMenuItem(
                                      value: '4.5 to 5.5 inches',
                                      child: Text('4.5 to 5.5 inches'),
                                    ),
                                  ],
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    color: Palette.secondaryElementColor,
                                    size: 30.w,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ]),
    );
  }
}
