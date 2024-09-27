import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'data/repositories/search_repository.dart';
import 'presentation/screens/search_screen.dart';
import 'services/api_service.dart';

void main() {
  final dio = Dio();
  final apiService = ApiService();
  final searchRepository = SearchRepository(apiService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(searchRepository),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(
        onItemClick: () {
          // Handle item click
        },
      ),
    );
  }
}
