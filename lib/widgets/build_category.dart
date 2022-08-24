import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_shop/theme/palette.dart';
import 'widgets.dart';

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
  double size = 69;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: Palette.categoryShadowColor, blurRadius: 5)
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
                height: 31,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.name,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontSize: 12,
                color: (widget.isSelected)
                    ? Theme.of(context).primaryColor
                    : Palette.secondaryColor),
          )
        ],
      ),
    );
  }
}
