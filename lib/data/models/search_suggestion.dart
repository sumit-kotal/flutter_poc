import 'package:json_annotation/json_annotation.dart';

part 'search_suggestion.g.dart';

@JsonSerializable()
class SearchSuggestion {
  final String statusValue;
  final ResponseData? responseData;
  final String message;

  SearchSuggestion({required this.statusValue, this.responseData, required this.message});

  factory SearchSuggestion.fromJson(Map<String, dynamic> json) => _$SearchSuggestionFromJson(json);
  Map<String, dynamic> toJson() => _$SearchSuggestionToJson(this);
}

@JsonSerializable()
class ResponseData {
  final String searchType;
  final List<SuggestionWithType> suggestionWithType;

  ResponseData({required this.searchType, required this.suggestionWithType});

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

@JsonSerializable()
class SuggestionWithType {
  final String type;
  final String text;
  final String? productCode;

  SuggestionWithType({required this.type, required this.text, this.productCode});

  factory SuggestionWithType.fromJson(Map<String, dynamic> json) => _$SuggestionWithTypeFromJson(json);
  Map<String, dynamic> toJson() => _$SuggestionWithTypeToJson(this);
}
