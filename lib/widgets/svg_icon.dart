import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
      {Key? key,
      required this.assetName,
      required this.color,
      required this.semanticsLabel,
      this.height,
      this.width,
      required this.onTap})
      : super(key: key);

  final String assetName;
  final Color color;
  final String semanticsLabel;
  final double? height;
  final double? width;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(assetName,
          width: width,
          height: height,
          color: color,
          semanticsLabel: semanticsLabel),
    );
  }
}
