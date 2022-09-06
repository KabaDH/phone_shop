import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/models/models.dart';
import 'package:phone_shop/service/api_service.dart';
import 'package:phone_shop/variables/variables.dart';

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
      final data = await _reader(providerAPI).getData(Variables.cartApiUrl);

      state = AsyncValue.data(Basket.fromMap(data!));
    }
  }
}
