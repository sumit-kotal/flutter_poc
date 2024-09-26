import 'package:flutter/material.dart';
import 'package:flutter_poc/data/models/search_suggestion.dart';
import 'package:flutter_poc/data/repositories/search_repository.dart';
import 'package:flutter_poc/domain/usecases/search_usecase.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRepository searchRepository;
  final SearchUseCase searchUseCase;

  List<SuggestionWithType> suggestions = [];
  bool isLoading = false;
  String error = '';

  SearchViewModel(this.searchRepository, this.searchUseCase);

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
