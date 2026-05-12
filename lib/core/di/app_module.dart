import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/core/dio_interceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  static const String baseUrl = 'https://sales-crm-d5df0ee50153.herokuapp.com';

  @singleton
  @preResolve
  Future<SharedPreferences> getSharedPrefs() => SharedPreferences.getInstance();

  @lazySingleton
  Dio dio(DioInterceptor interceptor) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    dio.interceptors.add(interceptor);
    return dio;
  }
}
