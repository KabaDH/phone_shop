import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phone_shop/theme/palette.dart';
import 'package:phone_shop/widgets/build_detailscard.dart';
import 'package:pixel_perfect/pixel_perfect.dart';
import 'package:phone_shop/widgets/widgets.dart';

import '../repos/details_repo.dart';

class ProductDetails extends StatefulHookConsumerWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final item = ref.watch(providerProductDetails);
    final screenSize = MediaQuery.of(context).size;
    final productImagesPageController =
        usePageController(initialPage: 0, viewportFraction: 0.72);

    return PixelPerfect(
      assetPath: 'assets/images/d_details.png',
      scale: 1.05,
      offset: const Offset(0.0, -20.0), // -145
      initOpacity: 0.3,
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
                      ButtonWithIcon(
                          icon: SvgIcon(
                            assetPath: 'assets/images/shoppingBag.svg',
                            color: Colors.white,
                            semanticsLabel: 'Shopping bag',
                            width: 14.w,
                          ),
                          callback: () => Navigator.pop(context),
                          color: Theme.of(context).primaryColor)
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  width: screenSize.width,
                  height: 438.h,
                  child: item.when(data: (data) {
                    if (data.images.isEmpty) {
                      return const SizedBox.shrink();
                    } else {
                      return PageView.builder(
                        controller: productImagesPageController,
                        reverse: true,
                        itemCount: data.images.length,
                        itemBuilder: (context, index) {
                          return BuildDetailsCard(
                            imagePath: data.images[index],
                            index: index,
                            pageController: productImagesPageController,
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
            ],
          ),
        ),
      )),
    );
  }
}
