import 'package:flutter/material.dart';
import 'package:phone_shop/theme/palette.dart';
import 'widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildCategory extends StatefulWidget {
  const BuildCategory(
      {Key? key,
      required this.assetPath,
      required this.name,
      required this.isSelected})
      : super(key: key);

  final String assetPath;
  final String name;
  final bool isSelected;

  @override
  State<BuildCategory> createState() => _BuildCategoryState();
}

class _BuildCategoryState extends State<BuildCategory> {
  double size = 73.w;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 21.5.w),
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Palette.categoryShadowColor, blurRadius: 5.sp)
              ],
              color: (widget.isSelected)
                  ? Theme.of(context).primaryColor
                  : Colors.white,
            ),
            child: Center(
              child: SvgIcon(
                assetPath: widget.assetPath,
                color: (widget.isSelected)
                    ? Colors.white
                    : Palette.secondaryColor.withOpacity(0.3),
                semanticsLabel: widget.name,
                height: 36.h,
              ),
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Text(
            widget.name,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 12.sp,
                color: (widget.isSelected)
                    ? Theme.of(context).primaryColor
                    : Palette.secondaryColor),
          )
        ],
      ),
    );
  }
}
