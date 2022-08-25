import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_shop/models/models.dart';

import '../theme/palette.dart';

class BuildHotSalesCard extends StatelessWidget {
  const BuildHotSalesCard({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.w, right: 19.w, top: 5.h, bottom: 7.h),
      child: Stack(children: [
        Container(
          width: 380.w,
          height: 220.h,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(11.w)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.w),
            child: CachedNetworkImage(
              imageUrl: item.picture,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
        ),
        (!item.is_new)
            ? const SizedBox.shrink()
            : Positioned(
                top: 19.h,
                left: 23.w,
                child: Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle),
                  padding: EdgeInsets.zero,
                  child: Center(
                    child: Text(
                      'New',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          ?.copyWith(fontSize: 9.sp, color: Colors.white),
                    ),
                  ),
                )),
        Positioned(
            left: 26.w,
            top: 73.h,
            child: Text(
              item.title,
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontSize: 24.5.sp,
                  color: Colors.white,
                  shadows: [Shadow(color: Colors.black, blurRadius: 15.sp)]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        Positioned(
            left: 26.w,
            top: 114.h,
            child: Text(
              item.subtitle,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 9.5.sp,
                  color: Colors.white,
                  letterSpacing: -0.333333.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
        Positioned(
            left: 26.w,
            top: 159.h,
            child: InkWell(
              onTap: () {
                debugPrint('Buy now!');
              },
              child: Container(
                alignment: Alignment.center,
                width: 98.w,
                height: 27.h,
                decoration: BoxDecoration(
                    color: Palette.iconBackgroundColor2,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  'Buy now!',
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Palette.secondaryColor,
                        fontSize: 11.sp,
                      ),
                ),
              ),
            ))
      ]),
    );
  }
}
