import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  static const String baseUrl = 'https://sales-crm-d5df0ee50153.herokuapp.com';

  @lazySingleton
  BaseOptions provideBaseOptions() => BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
  );

  @lazySingleton
  Dio provideDio(BaseOptions baseOption) => Dio(baseOption);
}
