import 'package:flutter/material.dart';
import 'package:flutter_poc/presentation/screens/search_screen.dart';
//import 'package:flutter_poc/presentation/screens/search_result_screen.dart';

class Routes {
  static const String searchSuggestion = '/searchSuggestion';
  static const String searchResult = '/searchResult';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case searchSuggestion:
        return MaterialPageRoute(builder: (_) => SearchScreen(onItemClick: () {}));
      // case searchResult:
      //   final args = settings.arguments as String;
      //   return MaterialPageRoute(builder: (_) => SearchResultScreen(searchText: args));
      default:
        return MaterialPageRoute(builder: (_) => SearchScreen(onItemClick: () {}));
    }
  }
}


