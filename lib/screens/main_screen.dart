import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_shop/models/item.dart';
import 'package:phone_shop/repos/basket_repo.dart';
import 'package:phone_shop/repos/details_repo.dart';
import 'package:phone_shop/repos/item_repo.dart';
import 'package:phone_shop/theme/palette.dart';
import 'package:phone_shop/widgets/widgets.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listItems = ref.watch(providerItem);
    final listBestSellers = ref.watch(providerBestSellerItems);
    final basket = ref.watch(providerBasket);
    final details = ref.watch(providerProductDetails);

    final String assetName = 'assets/images/delete.svg';
    final Widget svgIcon = SvgPicture.asset(assetName,
        color: Colors.red, semanticsLabel: 'A red up arrow');

    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Row(
                children: [
                  Expanded(
                      child: Center(
                    child: Row(
                      children: [


                      ],
                    ),
                  )),
                  SvgIcon(
                    assetName: 'assets/images/Filter.svg',
                    color: Palette.secondaryColor,
                    semanticsLabel: 'Filter',
                    height: 13.0,
                    onTap: () {
                      debugPrint('Filter called');
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
