import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_shop/models/models.dart';

import '../theme/palette.dart';

class BuildBestSellerCard extends StatelessWidget {
  const BuildBestSellerCard({Key? key, required this.dataItem})
      : super(key: key);

  final BestSeller dataItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.h),
          child: Stack(children: [
            Container(
              height: 270.h,
              width: 184.w,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Palette.bestSellersShadowColor, blurRadius: 10.w)
                ],
              ),
            ),
            SizedBox(
              height: 208.h,
              width: 184.w,
              child: CachedNetworkImage(
                imageUrl: dataItem.picture,
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
            Positioned(
                right: 12.w,
                top: 14.h,
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.zero,
                  width: 30.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Palette.shadowColor, blurRadius: 20.w)
                      ],
                      shape: BoxShape.circle),
                  child: Icon(
                    (dataItem.is_favorites)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 13.5.w,
                    color: Theme.of(context).primaryColor,
                  ),
                )),
            Positioned(
                left: 22.w,
                bottom: 36.h,
                child: Row(
                  children: [
                    Text(
                      '\$${dataItem.discount_price.toString()}',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontSize: 16.sp, color: Palette.secondaryColor),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Transform.translate(
                      offset: Offset(0.0, 2.h),
                      child: Text(
                        '\$${dataItem.price_without_discount.toString()}',
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: 10.sp,
                              decoration: TextDecoration.lineThrough,
                              color: Palette.noDiscountColor,
                            ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              left: 22.w,
              bottom: 16.h,
              child: Text(
                dataItem.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(fontSize: 10.sp, color: Palette.secondaryColor),
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
