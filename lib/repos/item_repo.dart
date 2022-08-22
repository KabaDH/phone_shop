import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/models/best_seller.dart';
import 'package:phone_shop/models/item.dart';
import 'package:phone_shop/providers/providers.dart';

final providerItem =
    StateNotifierProvider<ItemController, AsyncValue<List<Item>>>(
        (ref) => ItemController(ref.read)); //or here

final providerBestSellerItems = StateNotifierProvider<BestSellerItemsController,
    AsyncValue<List<BestSeller>>>((ref) => BestSellerItemsController());

class BestSellerItemsController
    extends StateNotifier<AsyncValue<List<BestSeller>>> {
  BestSellerItemsController() : super(const AsyncValue.loading());

  Future<void> setItems(List<BestSeller> items) async {
    state = AsyncValue.data(items);
  }

  Future<void> setLoading() async {
    state = const AsyncValue.loading();
  }
}

class ItemController extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader _reader;

  ItemController(this._reader) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();
    _reader(providerBestSellerItems.notifier).setLoading();

    if (mounted) {
      try {
        const String itemPath =
            'https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175';

        final response = await _reader(providerDio).get(
          itemPath,
          // queryParameters: queryParameters,
          // options: Options(contentType: Headers.formUrlEncodedContentType)
        );
        final data = Map<String, dynamic>.from(response.data);

        if (response.statusCode == 200) {
          final result = List<Map<String, dynamic>>.from(data['home_store']);
          final result2 = List<Map<String, dynamic>>.from(data['best_seller']);

          //proceed Items
          List<Item> itemList = [];
          for (var e in result) {
            itemList.add(Item.fromMap(e));
          }
          state = AsyncValue.data(itemList);
          //proceed BestSellers
          final List<BestSeller> BestSellerList = [];
          for (var e in result2) {
            BestSellerList.add(BestSeller.fromMap(e));
          }
          _reader(providerBestSellerItems.notifier).setItems(BestSellerList);
        } else {
          debugPrint('data = ' + data.toString());
        }
      } on DioError catch (err) {
        var responseError = jsonDecode(err.response.toString());
        debugPrint(responseError['message']);
        debugPrint(err.toString());
      } on SocketException catch (err) {
        throw err.toString();
      }
    }
  }
}
