import 'package:flutter/material.dart';

import '../../data/models/search_suggestion.dart';
import '../../data/repositories/search_repository.dart';
import '../screens/search_screen.dart';

class SearchViewModel extends ChangeNotifier {
  String searchText = '';
  bool isLoading = false;
  List<Product> filteredProductsList = [];
  bool isThresholdMet = false;

  final SearchRepository searchRepository;

  SearchViewModel(this.searchRepository);

  void onSearchTextChange(String text) {
    searchText = text;

    if (text.length > 3) {
      fetchSearchResults();  // Trigger API when search text length exceeds 3 characters
      isThresholdMet = true;
    } else {
      isThresholdMet = false;
      filteredProductsList = [];  // Clear the product list when text is less than 4 characters
    }
    
    notifyListeners();
  }

  Future<void> fetchSearchResults() async {
    isLoading = true;
    notifyListeners();

    try {
      final searchResult = await searchRepository.fetchSearchResult(searchText, 'product');
      filteredProductsList = await processSearchResult(searchResult);
    } catch (e) {
      // Handle error
      print('Error fetching search results: $e');
      filteredProductsList = [];  // Clear the list in case of error
    }

    isLoading = false;
    notifyListeners();
  }

  Future<List<Product>> processSearchResult(SearchSuggestion searchResult) async {
    final suggestionWithType = searchResult.responseData?.suggestionWithType ?? [];
    return suggestionWithType.map((item) => Product(item.text)).toList();
  }

  void clearSearchText() {
    searchText = '';
    filteredProductsList = [];  // Clear the list when search text is cleared
    notifyListeners();
  }

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }
}
