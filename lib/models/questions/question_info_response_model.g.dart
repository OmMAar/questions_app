// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionInfoResponseModel _$QuestionInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return QuestionInfoResponseModel(
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => QuestionItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasMore: json['has_more'] as bool?,
    quotaMax: json['quota_max'] as int?,
    quotaRemaining: json['quota_remaining'] as int?,
  );
}

Map<String, dynamic> _$QuestionInfoResponseModelToJson(
        QuestionInfoResponseModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'has_more': instance.hasMore,
      'quota_max': instance.quotaMax,
      'quota_remaining': instance.quotaRemaining,
    };
