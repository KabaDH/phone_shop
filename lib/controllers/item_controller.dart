import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/models/item.dart';
import 'package:phone_shop/service/api_service.dart';
import 'package:phone_shop/variables/variables.dart';

final providerItem =
    StateNotifierProvider<ItemController, AsyncValue<List<Item>>>(
        (ref) => ItemController(ref.read));

class ItemController extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader _reader;

  ItemController(this._reader) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();

    if (mounted) {
      final data = await _reader(providerAPI).getData(Variables.itemsApiUrl);
      state = AsyncValue.data(ItemList.fromMap(data!).itemList);
    }
  }
}
