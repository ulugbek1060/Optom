// import 'package:dio/dio.dart';
//
// class ProfileSource {
//   final Dio _dio;
//   final String baseUrl = 'https://sales-crm-d5df0ee50153.herokuapp.com';
//
//   ProfileSource(this._dio) {
//     _setupDio();
//   }
//
//   void _setupDio() {
//     _dio.options.baseUrl = baseUrl;
//     _dio.options.connectTimeout = const Duration(seconds: 30);
//     _dio.options.receiveTimeout = const Duration(seconds: 30);
//     _dio.options.headers = {
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//   }
//
//   Future<List<WalletModel>> getWallets() async {
//     try {
//       final response = await _dio.get('/api/wallets/me');
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data;
//         return data.map((json) => WalletModel.fromJson(json)).toList();
//       } else {
//         throw DioException(
//           requestOptions: response.requestOptions,
//           response: response,
//           message: 'Failed to fetch wallets: ${response.statusCode}',
//         );
//       }
//     } on DioException catch (e) {
//       throw _handleDioError(e);
//     }
//   }
//
//   Exception _handleDioError(DioException error) {
//     switch (error.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         return Exception(
//           'Connection timeout. Please check your internet connection.',
//         );
//
//       case DioExceptionType.connectionError:
//         return Exception('Network error. Please check your connection.');
//
//       case DioExceptionType.badResponse:
//         final statusCode = error.response?.statusCode;
//         final message = _getErrorMessageFromResponse(error.response);
//
//         if (statusCode == 401) {
//           return Exception('Unauthorized access. Please login again.');
//         } else if (statusCode == 404) {
//           return Exception('Wallets not found.');
//         } else if (statusCode == 500) {
//           return Exception('Server error. Please try again later.');
//         }
//
//         return Exception(message ?? 'Server error: $statusCode');
//
//       case DioExceptionType.cancel:
//         return Exception('Request was cancelled.');
//
//       default:
//         return Exception('Unexpected error occurred: ${error.message}');
//     }
//   }
//
//   String? _getErrorMessageFromResponse(Response? response) {
//     try {
//       if (response?.data != null && response!.data is Map) {
//         return response.data['message'] ?? response.data['error'];
//       }
//       return null;
//     } catch (e) {
//       return null;
//     }
//   }
// }
