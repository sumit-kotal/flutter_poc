import 'package:dio/dio.dart';
import 'package:flutter_poc/data/models/search_suggestion.dart';

class SearchRepository {
  final Dio dio;

  SearchRepository(this.dio);

  Future<SearchSuggestion> getSearchResult(String searchText, String type) async {
    try {
      final response = await dio.get('https://api.example.com/searchResult', queryParameters: {
        'searchString': searchText,
        'elasticSearchType': type,
        'sizeCount': 20,
        'page': 1
      });
      return SearchSuggestion.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch search result');
    }
  }
}
