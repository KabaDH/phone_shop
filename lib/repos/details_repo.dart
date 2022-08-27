import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/providers/providers.dart';
import 'package:phone_shop/models/models.dart';

final providerProductDetails =
    StateNotifierProvider<ProductDetailsController, AsyncValue<ProductDetails>>(
        (ref) => ProductDetailsController(ref.read)); //or here

class ProductDetailsController
    extends StateNotifier<AsyncValue<ProductDetails>> {
  final Reader _reader;

  ProductDetailsController(this._reader) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();

    if (mounted) {
      try {
        const String itemPath =
            'https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5';

        final response = await _reader(providerDio).get(
          itemPath,
        );
        final data = Map<String, dynamic>.from(response.data);
        if (response.statusCode == 200) {
          var details = ProductDetails.fromMap(data);
          state = AsyncValue.data(details);
        } else {}
      } on DioError catch (err) {
        var responseError = jsonDecode(err.response.toString());
        print(responseError.toString());
        print(err.toString());
      } on SocketException catch (err) {
        throw err.toString();
      }
    }
  }
}
