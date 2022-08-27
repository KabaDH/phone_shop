import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_shop/theme/palette.dart';

class BuildDetailsCard extends StatelessWidget {
  const BuildDetailsCard(
      {Key? key,
      required this.imagePath,
      required this.index,
      required this.pageController})
      : super(key: key);

  final String imagePath;
  final int index;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (BuildContext context, Widget? widget) {
        double value;
        if (pageController.position.haveDimensions) {
          value = pageController.page! - index;
        } else {
          value = 0.0 - index;
        }
        value = (1 - (value.abs() * 0.35)).clamp(0.0, 1.0);

        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 400.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            child: widget,
          ),
        );
      },
      child: Center(
        child: Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h, bottom: 20.h),
          child: Container(
            height: 405.h,
            width: 268.w,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.h),
                boxShadow: [
                  BoxShadow(
                      color: Palette.detailsShadowColor,
                      offset: Offset(0, 10.h),
                      blurRadius: 20.h)
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.h),
              child: CachedNetworkImage(
                imageUrl: imagePath,
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
