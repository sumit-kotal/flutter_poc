// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSuggestion _$SearchSuggestionFromJson(Map<String, dynamic> json) =>
    SearchSuggestion(
      statusValue: json['statusValue'] as String,
      responseData: json['responseData'] == null
          ? null
          : ResponseData.fromJson(json['responseData'] as Map<String, dynamic>),
      message: json['message'] as String,
    );

Map<String, dynamic> _$SearchSuggestionToJson(SearchSuggestion instance) =>
    <String, dynamic>{
      'statusValue': instance.statusValue,
      'responseData': instance.responseData,
      'message': instance.message,
    };

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      searchType: json['searchType'] as String,
      suggestionWithType: (json['suggestionWithType'] as List<dynamic>)
          .map((e) => SuggestionWithType.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'searchType': instance.searchType,
      'suggestionWithType': instance.suggestionWithType,
    };

SuggestionWithType _$SuggestionWithTypeFromJson(Map<String, dynamic> json) =>
    SuggestionWithType(
      type: json['type'] as String,
      text: json['text'] as String,
      productCode: json['productCode'] as String?,
    );

Map<String, dynamic> _$SuggestionWithTypeToJson(SuggestionWithType instance) =>
    <String, dynamic>{
      'type': instance.type,
      'text': instance.text,
      'productCode': instance.productCode,
    };
