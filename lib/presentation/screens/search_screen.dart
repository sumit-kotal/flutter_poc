import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_poc/data/repositories/search_repository.dart';
import 'package:flutter_poc/services/api_service.dart';
import 'package:provider/provider.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final VoidCallback onItemClick;

  SearchScreen({required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(SearchRepository(Dio() as ApiService)), // Pass the SearchRepository instance
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchContent(onItemClick: onItemClick),
        ),
      ),
    );
  }
}

class SearchContent extends StatelessWidget {
  final VoidCallback onItemClick;

  SearchContent({required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    final searchText = context.watch<SearchViewModel>().searchText;
    final isLoading = context.watch<SearchViewModel>().isLoading;
    final productsList = context.watch<SearchViewModel>().filteredProductsList;
    final isThresholdMet = context.watch<SearchViewModel>().isThresholdMet;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (text) {
                  context.read<SearchViewModel>().onSearchTextChange(text);
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: GestureDetector(
                    onTap: () {
                      context.read<SearchViewModel>().clearSearchText();
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  suffixIcon: searchText.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            context.read<SearchViewModel>().clearSearchText();
                          },
                          child: Icon(Icons.clear),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4),
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    // Navigate to a different screen
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.shopping_cart),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.red,
                    child: Text(
                      '10',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 16),
        if (isThresholdMet)
          isLoading
              ? CircularProgressIndicator()
              : productsList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: productsList.length,
                        itemBuilder: (context, index) {
                          final product = productsList[index];
                          return ListTile(
                            title: Text(product.text),
                            onTap: onItemClick,
                          );
                        },
                      ),
                    )
                  : Center(child: Text('No Results Found')),
        if (!isThresholdMet)
          RecentlySearchedSection(onItemClick: onItemClick),
      ],
    );
  }
}

class RecentlySearchedSection extends StatelessWidget {
  final VoidCallback onItemClick;

  RecentlySearchedSection({required this.onItemClick});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recently Searched',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Clear',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            context.read<SearchViewModel>().setSearchText("Dolo");
            onItemClick();
          },
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.history),
                SizedBox(width: 8),
                Text('Dolo'),
              ],
            ),
          ),
        ),
        SizedBox(height: 100),
        Column(
          children: [
            Icon(Icons.search),
            SizedBox(height: 20),
            Text(
              'Explore your medicines\nand discover substitutes!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

class SearchViewModel extends ChangeNotifier {
  String searchText = '';
  bool isLoading = false;
  List<Product> filteredProductsList = [];
  bool isThresholdMet = false;

  SearchViewModel(SearchRepository searchRepository);

  void onSearchTextChange(String text) {
    searchText = text;
    // Perform search logic
    notifyListeners();
  }

  void clearSearchText() {
    searchText = '';
    notifyListeners();
  }

  void setSearchText(String text) {
    searchText = text;
    notifyListeners();
  }
}

class Product {
  final String text;

  Product(this.text);
}
