import 'dart:io';
import 'package:dio/dio.dart';
import 'package:phone_shop/service/api_service.dart';
import 'package:phone_shop/variables/variables.dart';
import 'package:riverpod/riverpod.dart';
import 'package:phone_shop/providers/providers.dart';

final providerFakeAPI = Provider((ref) => ControllerFakeAPI(ref.read));

class ControllerFakeAPI extends ControllerAPI {
  final Reader _reader;

  ControllerFakeAPI(this._reader) : super(_reader);

  Future<Map<String, dynamic>?> getData(String apiUrl) async {
    try {
      final response = await _reader(providerDio).get(
        apiUrl,
      );
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);

        switch (apiUrl) {
          case Variables.itemsApiUrl:
            data['home_store'][0]['title'] = 'Iphone XXX';
            data['home_store'][0]['picture'] =
                'https://www.greenscene.co.id/wp-content/uploads/2021/11/pikachu.jpg';
            return data;
          default:
            return data;
        }
      } else {
        return null;
      }
    } on DioError catch (err) {
      throw err.toString();
    } on SocketException catch (err) {
      throw err.toString();
    }
  }
}
