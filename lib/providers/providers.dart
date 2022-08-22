import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final providerDio = Provider<Dio>((ref) => Dio());