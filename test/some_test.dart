import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phone_shop/controllers/controllers.dart';
import 'package:phone_shop/service/api_service.dart';
import 'package:phone_shop/service/fake_api.dart';

void main() {
  group('check basket', () {
    test('check items added', () async {
      var basket = ProviderContainer(
          overrides: [
            providerAPI.overrideWithProvider(
                Provider((ref) => ControllerFakeAPI(ref.read)))
          ]
      ).read(providerBasket);
      basket.when(data: (data) {
        expect(data.basket?.length, 2);
        expect(data.basket?[0].price, 11111);

      }, error: (_,__) {}, loading: () {});

    });

  });

}