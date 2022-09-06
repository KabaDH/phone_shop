import 'package:phone_shop/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../service/api_service.dart';
import '../variables/variables.dart';

final providerBestSellerItems = StateNotifierProvider<BestSellerItemsController,
    AsyncValue<List<BestSeller>>>((ref) => BestSellerItemsController(ref.read));

class BestSellerItemsController
    extends StateNotifier<AsyncValue<List<BestSeller>>> {
  final Reader _reader;

  BestSellerItemsController(this._reader) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();

    if (mounted) {
      final data = await _reader(providerAPI).getData(Variables.itemsApiUrl);
      state = AsyncValue.data(BestSellerList.fromMap(data!).bestSellerList);
    }
  }
}
