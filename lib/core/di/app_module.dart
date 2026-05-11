import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {

  @lazySingleton
  @preResolve
  Future<SharedPreferences> provideSharedPreferences() =>
      SharedPreferences.getInstance();

  @lazySingleton
  BaseOptions provideBaseOptions() => BaseOptions(
    baseUrl: 'https://sales-crm-d5df0ee50153.herokuapp.com',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    },
  );

  @lazySingleton
  Dio provideDio(BaseOptions baseOption) => Dio(baseOption);
}
