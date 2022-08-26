import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/palette.dart';

class BuildHomeScreenHeader extends StatelessWidget {
  final String headerText;
  final String actionText;
  final VoidCallback action;

  const BuildHomeScreenHeader(
      {Key? key,
      required this.headerText,
      required this.actionText,
      required this.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            headerText,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  fontSize: 25.sp,
                  color: Palette.secondaryColor,
                ),
          ),
          GestureDetector(
            onTap: action,
            child: Text(
              actionText,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 15.sp, color: Theme.of(context).primaryColor),
            ),
          )
        ],
      ),
    );
  }
}
