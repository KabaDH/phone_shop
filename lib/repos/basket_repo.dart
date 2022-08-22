import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/providers/providers.dart';
import 'package:phone_shop/models/models.dart';

final providerBasket =
    StateNotifierProvider<BasketController, AsyncValue<Basket>>(
        (ref) => BasketController(ref.read)); //or here

class BasketController extends StateNotifier<AsyncValue<Basket>> {
  final Reader _reader;

  BasketController(this._reader) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();

    if (mounted) {
      try {
        const String itemPath =
            'https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149';

        final response = await _reader(providerDio).get(
          itemPath,
        );
        final data = Map<String, dynamic>.from(response.data);

        if (response.statusCode == 200) {
          final result = List<Map<String, dynamic>>.from(data['basket']);
          List<BasketItem> _itemList = [];
          for (var e in result) {
            _itemList.add(BasketItem.fromMap(e));
          }

          state = AsyncValue.data(Basket(
              delivery: data['delivery'] ?? '',
              id: data['id'] ?? '',
              total: data['total'] ?? 0,
              basket: _itemList));
        } else {
        }
      } on DioError catch (err) {
        var responseError = jsonDecode(err.response.toString());
        print(responseError['message']);
        print(err.toString());
      } on SocketException catch (err) {
        throw err.toString();
      }
    }
  }
}
