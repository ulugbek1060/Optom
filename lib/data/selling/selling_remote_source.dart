

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@injectable
class SellingRemoteSource {
  final Dio _dio;

  SellingRemoteSource(this._dio);
}