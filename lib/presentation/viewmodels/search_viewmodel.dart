import 'package:flutter/material.dart';
import 'package:flutter_poc/data/models/search_suggestion.dart';
import 'package:flutter_poc/data/repositories/search_repository.dart';
import 'package:flutter_poc/domain/usecases/search_usecase.dart';

import '../screens/search_screen.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRepository searchRepository;
  final SearchUseCase searchUseCase;

  String searchText = '';
  bool isLoading = false;
  List<Product> filteredProductsList = [];
  List<SuggestionWithType> suggestions = [];
  String error = '';
  bool isThresholdMet = false;

  SearchViewModel(this.searchRepository, this.searchUseCase);

  void onSearchTextChange(String text) {
    searchText = text;
    // You can add logic for filtering products locally or call the API here.
    notifyListeners();
  }

  void clearSearchText() {
    searchText = '';
    filteredProductsList = [];
    notifyListeners();
  }

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }

  Future<void> getSearchResults(String searchText, String type) async {
    try {
      isLoading = true;
      notifyListeners();

      final searchResult = await searchRepository.getSearchResult(searchText, type);
      suggestions = await searchUseCase.processSearchResult(searchResult);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      error = e.toString();
      notifyListeners();
    }
  }
}
