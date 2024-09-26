import 'package:flutter/material.dart';
import 'package:flutter_poc/presentation/viewmodels/search_viewmodel.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final searchViewModel = context.watch<SearchViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: Column(
        children: [
          TextField(
            onChanged: (text) {
              searchViewModel.getSearchResults(text, 'product');
            },
            decoration: InputDecoration(hintText: 'Enter search query'),
          ),
          if (searchViewModel.isLoading)
            CircularProgressIndicator(),
          Expanded(
            child: ListView.builder(
              itemCount: searchViewModel.suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = searchViewModel.suggestions[index];
                return ListTile(
                  title: Text(suggestion.text ?? ''),
                  onTap: () {
                    Navigator.pushNamed(context, '/searchResult', arguments: suggestion.productCode);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
