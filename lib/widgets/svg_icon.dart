import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
      {Key? key,
      required this.assetPath,
      required this.color,
      required this.semanticsLabel,
      this.height,
      this.width,
      this.onTap,
      this.boxFit})
      : super(key: key);

  final String assetPath;
  final Color color;
  final String semanticsLabel;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(assetPath,
          width: width,
          height: height,
          color: color,
          fit: boxFit ?? BoxFit.contain,
          semanticsLabel: semanticsLabel),
    );
  }
}
