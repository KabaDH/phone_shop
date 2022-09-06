import 'dart:io';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'package:phone_shop/providers/providers.dart';

final providerAPI = Provider((ref) => ControllerAPI(ref.read));

class ControllerAPI {
  final Reader _reader;

  ControllerAPI(this._reader);

  Future<Map<String, dynamic>?> getData(String apiUrl) async {
    try {
      final response = await _reader(providerDio).get(
        apiUrl,
      );
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        return data;
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
