import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_poc/navigation/routes.dart';
import 'package:flutter_poc/presentation/viewmodels/search_viewmodel.dart';
import 'package:flutter_poc/data/repositories/search_repository.dart';
import 'package:flutter_poc/domain/usecases/search_usecase.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SearchViewModel(
            SearchRepository(Dio()),
            SearchUseCase(),
          ),
        ),
      ],
      child: MaterialApp(
        initialRoute: Routes.searchSuggestion,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
