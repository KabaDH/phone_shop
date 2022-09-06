import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:phone_shop/models/models.dart';
import 'package:phone_shop/theme/palette.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:phone_shop/widgets/widgets.dart';
import 'package:phone_shop/controllers/controllers.dart';

class MyCart extends ConsumerWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(providerBasket);
    final formatCurrency = NumberFormat.simpleCurrency(decimalDigits: 0);

    buildCartElement(BasketItem item) {
      return Container(
        height: 107.h,
        margin: EdgeInsets.only(top: 45.w),
        child: Padding(
          padding: EdgeInsets.only(
            left: 32.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Photo
              Container(
                height: 107.h,
                width: 90.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.h),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.h),
                  child: CachedNetworkImage(
                    imageUrl: item.images,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Container(
                width: 188.w,
                padding: EdgeInsets.only(top: 4.h),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190.w,
                      height: 65.h,
                      child: Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 20.sp, color: Colors.white),
                      ),
                    ),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.sp),
                    )
                  ],
                ),
              ),
              Container(
                height: 83.8.h,
                width: 26.w,
                margin: EdgeInsets.only(top: 8.h),
                decoration: BoxDecoration(
                    color: Palette.cartAddItemsElementColor,
                    borderRadius: BorderRadius.circular(26.h)),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => debugPrint('remove item'),
                      child: Text(
                        '-',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.5.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -2),
                      child: Text(
                        '2',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(color: Colors.white, fontSize: 19.sp),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -4),
                      child: GestureDetector(
                        onTap: () => debugPrint('add item'),
                        child: Text(
                          '+',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.5.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  top: 41.h,
                ),
                child: SvgIcon(
                  assetPath: 'assets/images/delete.svg',
                  color: Palette.cartDeleteIconElementColor,
                  semanticsLabel: 'delete item',
                  height: 16.5.sp,
                  onTap: () => debugPrint('delete item'),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PixelPerfect(
      assetPath: 'assets/images/d_cart.png',
      scale: 1.05,
      offset: const Offset(0.0, -20.0), // -142
      initOpacity: 0.2,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              ///Top Navigation
              SliverPadding(
                padding: EdgeInsets.only(left: 42.w, top: 40.h, right: 45.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWithIcon(
                          icon: Icon(
                            Icons.chevron_left,
                            color: Palette.iconBackgroundColor2,
                            size: 32.sp,
                          ),
                          callback: () => Navigator.of(context).pop(),
                          color: Palette.secondaryColor),
                      Row(
                        children: [
                          Text(
                            'Add address',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Palette.secondaryColor,
                                    fontSize: 15.sp),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          ButtonWithIcon(
                              icon: SvgIcon(
                                assetPath: 'assets/images/location.svg',
                                color: Palette.iconBackgroundColor2,
                                semanticsLabel: 'location',
                                height: 20.sp,
                              ),
                              callback: () => {debugPrint('Set Location')},
                              color: Palette.primaryColor),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 64.h,
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(
                  left: 42.w,
                ),

                ///My Cart
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'My Cart',
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Palette.secondaryColor,
                          fontSize: 35.sp,
                        ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 53.5.h,
                ),
              ),

              ///Bottom elements
              SliverToBoxAdapter(
                child: Container(
                    height: 820.h,
                    decoration: BoxDecoration(
                        color: Palette.secondaryColor,
                        borderRadius: BorderRadius.circular(30.w)),
                    child: basket.when(
                        data: (data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40.h,
                              ),
                              SizedBox(
                                height: 521.h,
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.basket?.length,
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    itemBuilder: (context, index) {
                                      var dataItem = data.basket![index];

                                      return buildCartElement(dataItem);
                                    }),
                              ),
                              Divider(
                                height: 2.h,
                                color: Palette.iconBackgroundColor2,
                              ),
                              SizedBox(
                                height: 21.h,
                              ),

                              ///Total and delivery block
                              Padding(
                                padding: EdgeInsets.only(left: 55.w),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 253.w,
                                      child: Text(
                                        'Total',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 15.sp),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${formatCurrency.format(data.total)} us',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 15.sp),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 14.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 55.w),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 253.w,
                                      child: Text(
                                        'Delivery',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 15.sp),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data.delivery,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            ?.copyWith(
                                                color: Colors.white,
                                                fontSize: 15.sp),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 28.h,
                              ),
                              Divider(
                                height: 1.h,
                                color: Palette.iconBackgroundColor2,
                              ),
                              SizedBox(
                                height: 33.h,
                              ),

                              ///Checkout button
                              TextButton(
                                  onPressed: () => debugPrint('Checkout'),
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
                                    fixedSize: Size(326.w, 54.w),
                                  ),
                                  child: const Text('Checkout'))
                            ],
                          );
                        },
                        error: (_, __) {},
                        loading: () {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
