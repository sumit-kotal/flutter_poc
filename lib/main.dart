import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_poc/navigation/routes.dart';
import 'package:flutter_poc/presentation/viewmodels/search_viewmodel.dart';
import 'package:flutter_poc/data/repositories/search_repository.dart';
import 'package:flutter_poc/domain/usecases/search_usecase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SearchViewModel>(
          create: (_) => SearchViewModel(
            SearchRepository(Dio()),  // Pass the Dio instance here
            SearchUseCase(),          // Pass the SearchUseCase here
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.searchSuggestion,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
