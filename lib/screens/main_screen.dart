import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/models/item.dart';
import 'package:phone_shop/repos/basket_repo.dart';
import 'package:phone_shop/repos/details_repo.dart';
import 'package:phone_shop/repos/item_repo.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listItems = ref.watch(providerItem);
    final listBestSellers = ref.watch(providerBestSellerItems);
    final basket = ref.watch(providerBasket);
    final details = ref.watch(providerProductDetails);

    buildItems(List<dynamic> items) {
      return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 30,
              child: Text(items[index].toString()),
            );
          });
    }

    return Scaffold(
        body: details.when(
            data: (items) {
              return buildItems(items.capacity);
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
