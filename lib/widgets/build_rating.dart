import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phone_shop/widgets/svg_icon.dart';

import '../theme/palette.dart';

class BuildRatingStars extends StatelessWidget {
  const BuildRatingStars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  final double rating;

  @override
  Widget build(BuildContext context) {
    List<Widget> ratingList = [];
    int numberOfStars = rating.ceil();

    cutStar(double width) {
      return ClipRect(
        child: Align(
            alignment: Alignment.centerLeft,
            widthFactor: width,
            child: SvgIcon(
              assetPath: 'assets/images/star.svg',
              color: Palette.detailsStarRatingColor,
              semanticsLabel: 'Rating',
              width: 18.w,
            )),
      );
    }

    for (int i = 1; i <= numberOfStars; i++) {
      ratingList
          .add(cutStar(i < numberOfStars ? 1.0 : rating - (numberOfStars - 1)));
      ratingList.add(SizedBox(
        width: 9.w,
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: ratingList,
    );
  }
}
