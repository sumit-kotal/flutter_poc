import '../../services/api_service.dart';
import '../models/search_suggestion.dart';

class SearchRepository {
  final ApiService apiService;

  SearchRepository(this.apiService);

  Future<SearchSuggestion> fetchSearchResult(String searchText, String type) async {
    try {
      final response = await apiService.getSearchResults(
        searchText: searchText,
        type: type,
        warehouseId: 10, // Fixed as in the original Kotlin example
        sizeCount: 20,    // Fixed size count from Kotlin example
        variantId: 11,    // Fixed variant id
        page: 1,          // First page
        isMultiSearch: false, // Fixed boolean
      );

      if (response.statusCode == 200) {
        return SearchSuggestion.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch search result');
      }
    } catch (e) {
      throw Exception('Failed to fetch search result: $e');
    }
  }
}
