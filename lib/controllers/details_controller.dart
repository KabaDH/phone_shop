import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phone_shop/models/models.dart';
import 'package:phone_shop/service/api_service.dart';
import 'package:phone_shop/variables/variables.dart';

final providerProductDetails =
    StateNotifierProvider<ProductDetailsController, AsyncValue<ProductDetails>>(
        (ref) => ProductDetailsController(ref.read));

class ProductDetailsController
    extends StateNotifier<AsyncValue<ProductDetails>> {
  final Reader _reader;

  ProductDetailsController(this._reader) : super(const AsyncValue.loading()) {
    retrieveItems();
  }

  Future<void> retrieveItems() async {
    state = const AsyncValue.loading();

    if (mounted) {
      final data =
          await _reader(providerAPI).getData(Variables.productDetailsApiUrl);
      var details = ProductDetails.fromMap(data!);
      state = AsyncValue.data(details);
    }
  }
}
