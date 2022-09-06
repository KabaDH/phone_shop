import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_shop/theme/palette.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:phone_shop/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:phone_shop/controllers/controllers.dart';

class ProductDetails extends StatefulHookConsumerWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  int selectedColorIndex = 0;
  int selectedMemoryIndex = 0;
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  Widget build(BuildContext context) {
    final item = ref.watch(providerProductDetails);
    final basket = ref.watch(providerBasket);

    final screenSize = MediaQuery.of(context).size;
    final pageController =
        usePageController(initialPage: 0, viewportFraction: 0.72);
    final tabControllerSDF = useTabController(initialLength: 3);

    buildTabElement({required String assetPath, required String text}) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 32.w,
            height: 32.w,
            child: SvgIcon(
              assetPath: assetPath,
              color: Palette.iconBackgroundColor,
              semanticsLabel: text,
              boxFit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 11.sp, color: Palette.iconBackgroundColor))
        ],
      );
    }

    buildColorElement({required String color, required int index}) {
      return Center(
        child: Container(
          width: 46.w,
          height: 46.h,

          ///Показываем максимум 3 цвета, чтобы вместилось на экран
          margin: index == 1
              ? EdgeInsets.symmetric(horizontal: 13.w)
              : EdgeInsets.zero,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(int.parse('0xFF${color.substring(1)}')),
          ),
          child: index == selectedColorIndex
              ? const Icon(
                  Icons.done_outlined,
                  color: Colors.white,
                )
              : const SizedBox.shrink(),
        ),
      );
    }

    buildMemoryElement(int volume, int index) {
      bool isSelected = index == selectedMemoryIndex;

      return Center(
        child: Container(
          width: 72.w,
          height: 35.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: index == 0 ? 20.w : 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              color: (isSelected)
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          child: Text(
            volume.toString() + (isSelected ? ' GB' : ' gb'),
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                fontSize: 12.sp,
                color: isSelected ? Colors.white : Palette.unselectedColor),
          ),
        ),
      );
    }

    return PixelPerfect(
      assetPath: 'assets/images/d_details.png',
      scale: 1.05,
      offset: const Offset(0.0, -20.0), // -145 -20
      initOpacity: 0.2,
      child: Scaffold(
          body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              ///Top header
              SliverPadding(
                padding: EdgeInsets.only(
                    left: 42.w, right: 35.w, top: 40.h, bottom: 25.h),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWithIcon(
                          icon: Icon(
                            Icons.chevron_left_rounded,
                            color: Colors.white,
                            size: 30.w,
                          ),
                          callback: () => Navigator.pop(context),
                          color: Palette.secondaryColor),
                      Text(
                        'Product Details     ',
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontSize: 18.sp, color: Palette.secondaryColor),
                      ),
                      Stack(children: [
                        ButtonWithIcon(
                            icon: SvgIcon(
                              assetPath: 'assets/images/shoppingBag.svg',
                              color: Colors.white,
                              semanticsLabel: 'Shopping bag',
                              width: 14.w,
                            ),
                            callback: () =>
                                Navigator.pushNamed(context, '/cart'),
                            color: Theme.of(context).primaryColor),
                        basket.when(data: (data) {
                          var totalGoods = data.basket?.length;
                          if (totalGoods == null) {
                            return const SizedBox.shrink();
                          } else {
                            return Transform.translate(
                              offset: Offset(24.0.w, -9.0.h),
                              child: Container(
                                width: 20.w,
                                height: 20.h,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Palette.iconBackgroundColor2,
                                    border: Border.all(
                                        color: Palette.secondaryColor,
                                        width: 0.3)),
                                child: Text(
                                  totalGoods.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: Palette.secondaryColor,
                                          fontSize:
                                              totalGoods > 9 ? 8.sp : 12.sp),
                                ),
                              ),
                            );
                          }
                        }, error: (_, __) {
                          return const SizedBox.shrink();
                        }, loading: () {
                          return const SizedBox.shrink();
                        })
                      ])
                    ],
                  ),
                ),
              ),

              ///carousel
              SliverToBoxAdapter(
                child: SizedBox(
                  width: screenSize.width,
                  height: 438.h,
                  child: item.when(data: (data) {
                    if (data.images.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      return PageView.builder(
                        controller: pageController,
                        reverse: true,
                        itemCount: data.images.length,
                        itemBuilder: (context, index) {
                          return BuildDetailsCard(
                            imagePath: data.images[index],
                            index: index,
                            pageController: pageController,
                          );
                        },
                      );
                    }
                  }, error: (_, __) {
                    return Container(
                      width: screenSize.width,
                      height: 438.h,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(11.w)),
                      child: const Center(
                          child: Text('Error loading Product Images')),
                    );
                  }, loading: () {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    height: 534.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.h),
                        boxShadow: [
                          BoxShadow(
                              color: Palette.detailsBottomShadowColor,
                              offset: const Offset(0.0, -5.0),
                              blurRadius: 20.h)
                        ]),
                    child: item.when(data: (data) {
                      Map<String, String> itemParams = {
                        'assets/images/detailsIcon1.svg': data.CPU,
                        'assets/images/detailsIcon2.svg': data.camera,
                        'assets/images/detailsIcon3.svg': data.ssd,
                        'assets/images/detailsIcon4.svg': data.sd,
                      };

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///Bottom Header and favorites icon
                          Padding(
                            padding: EdgeInsets.only(
                                left: 38.w, right: 36.5.w, top: 30.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          fontSize: 24.sp,
                                          color: Palette.secondaryColor),
                                ),
                                ButtonWithIcon(
                                    icon: Icon(
                                      (data.isFavorites)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 21.h,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    callback: () =>
                                        debugPrint('Add-remove favorite'),
                                    color: Palette.secondaryColor)
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 3.h,
                          ),

                          ///Build rating Stars
                          Padding(
                            padding: EdgeInsets.only(left: 38.w, right: 36.5.w),
                            child: BuildRatingStars(
                              rating: data.rating,
                            ),
                          ),
                          SizedBox(
                            height: 36.h,
                          ),

                          ///TabBar
                          Padding(
                            padding: EdgeInsets.only(right: 15.w),
                            child: TabBar(
                              controller: tabControllerSDF,
                              labelColor: Palette.secondaryColor,
                              unselectedLabelColor: Palette.tabUnselectedColor,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorColor: Theme.of(context).primaryColor,
                              indicatorWeight: 3.sp,
                              isScrollable: false,
                              labelPadding: EdgeInsets.zero,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(
                                      color: Palette.secondaryColor,
                                      fontSize: 20.sp),
                              tabs: <Widget>[
                                Tab(
                                    height: 37.h,
                                    child: const Text('    Shop   ')),
                                Tab(
                                    height: 37.h,
                                    child: const Text('   Details    ')),
                                Tab(
                                    height: 37.h,
                                    child: const Text('   Features  '))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                          Container(
                            height: 90.h,
                            padding: EdgeInsets.only(left: 30.w, right: 48.w),
                            child: TabBarView(
                                controller: tabControllerSDF,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: itemParams
                                        .map((key, value) => MapEntry(
                                            key,
                                            buildTabElement(
                                                assetPath: key, text: value)))
                                        .values
                                        .toList(),
                                  ),
                                  Container(
                                    width: screenSize.width,
                                    alignment: Alignment.center,
                                    height: 50.h,
                                    child: const Text('Some details'),
                                  ),
                                  Container(
                                    width: screenSize.width,
                                    alignment: Alignment.center,
                                    height: 50.h,
                                    child: const Text('Some features'),
                                  ),
                                ]),
                          ),

                          SizedBox(
                            height: 20.h,
                          ),

                          ///Colors Header
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35.5.w),
                            child: Text(
                              'Select color and capacity',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    color: Palette.secondaryColor,
                                    fontSize: 16.sp,
                                  ),
                            ),
                          ),

                          SizedBox(
                            height: 17.h,
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 31.w, right: 30.w),
                            child: Row(
                              children: [
                                ///Build Colors
                                SizedBox(
                                  height: 47.h,
                                  width: screenSize.width.w / 2.45,
                                  child: ListView.builder(
                                      itemCount: data.color.length > 3
                                          ? 3
                                          : data.color.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedColorIndex = index;
                                            });
                                          },
                                          child: buildColorElement(
                                              color: data.color[index],
                                              index: index),
                                        );
                                      }),
                                ),

                                ///Build memory

                                SizedBox(
                                  height: 38.h,
                                  width: screenSize.width.w -
                                      screenSize.width.w / 2.45 -
                                      65.w,
                                  child: ListView.builder(
                                      itemCount: data.capacity.length > 2
                                          ? 2
                                          : data.capacity.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedMemoryIndex = index;
                                            });
                                          },
                                          child: buildMemoryElement(
                                              data.capacity[index], index),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 32.h,
                          ),

                          ///Add to cart button
                          Padding(
                            padding: EdgeInsets.only(left: 29.0.w),
                            child: TextButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.h)),
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(fontSize: 19.5.sp),
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  fixedSize: Size(355.w, 54.w),
                                ),
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 37.w, right: 30.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Add to Cart'),
                                      Text(formatCurrency.format(data.price)),
                                    ],
                                  ),
                                )),
                          )
                        ],
                      );
                    }, error: (_, __) {
                      return const Center(
                          child: Text('Error loading Product details'));
                    }, loading: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    })),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
