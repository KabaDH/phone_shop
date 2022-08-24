import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phone_shop/models/item.dart';
import 'package:phone_shop/repos/basket_repo.dart';
import 'package:phone_shop/repos/details_repo.dart';
import 'package:phone_shop/repos/item_repo.dart';

class SomeScreen extends ConsumerWidget {
  const SomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listItems = ref.watch(providerItem);
    final listBestSellers = ref.watch(providerBestSellerItems);
    final basket = ref.watch(providerBasket);
    final details = ref.watch(providerProductDetails);

    final String assetName = 'assets/images/delete.svg';
    final Widget svgIcon = SvgPicture.asset(assetName,
        color: Colors.red, semanticsLabel: 'A red up arrow');

    buildItems(List<dynamic> items) {
      return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  Text(items[index].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Mark-Pro",
                          fontWeight: FontWeight.w400)),
                  Text(
                    'This Text From Theme',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 20),
                  ),
                  svgIcon,
                ],
              ),
            );
          });
    }

    return Scaffold(
        body: details.when(
            data: (items) {
              return buildItems(items.images);
            },
            error: (_, __) {
              return const Center(
                child: Text('Err'),
              );
            },
            loading: () => const Center(
              child: CircularProgressIndicator(),
            )));
  }
}
