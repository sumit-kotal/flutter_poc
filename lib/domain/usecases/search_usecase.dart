import 'package:flutter_poc/data/models/search_suggestion.dart';

class SearchUseCase {
  Future<List<SuggestionWithType>> processSearchResult(SearchSuggestion searchResult) async {
    final suggestionWithType = searchResult.responseData?.suggestionWithType ?? [];
    return suggestionWithType;
  }
}
