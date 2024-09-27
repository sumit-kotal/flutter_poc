import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = 'https://stage-android.truemedsapi.in/CustomerService/';
    _dio.options.connectTimeout = 5000 as Duration?;
    _dio.options.receiveTimeout = 3000 as Duration?;
  }

  Future<Response> getSearchResults({
    required String searchText,
    required String type,
    required int warehouseId,
    required int sizeCount,
    required int variantId,
    required int page,
    required bool isMultiSearch,
  }) async {
    try {
      final response = await _dio.get(
        'getSearchResult', // Ensure this matches your API endpoint
        queryParameters: {
          'warehouseId': warehouseId,
          'elasticSearchType': type,
          'searchString': searchText,
          'sizeCount': sizeCount,
          'variantId': variantId,
          'page': page,
          'isMultiSearch': isMultiSearch,
        },
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch search results: $e');
    }
  }
}
