import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:optom/data/auth/auth_local_data_source.dart';

@lazySingleton
class DioInterceptor extends InterceptorsWrapper {
  final AuthLocalDataSource _authLocalDataSource;

  DioInterceptor(this._authLocalDataSource);

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _authLocalDataSource.getToken();
    options.headers['Content-Type'] = 'application/json';
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = token;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    return handler.next(err);
  }
}
