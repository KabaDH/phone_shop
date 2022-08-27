import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/palette.dart';

class ButtonWithIcon extends StatelessWidget {
  const ButtonWithIcon({Key? key, required this.icon, required this.callback, required this.color})
      : super(key: key);

  final Widget icon;
  final VoidCallback callback;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: 37.w,
        height: 42.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.h)),
        child: icon,
      ),
    );
  }
}
