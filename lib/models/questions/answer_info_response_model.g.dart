// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerInfoResponseModel _$AnswerInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return AnswerInfoResponseModel(
    items: (json['items'] as List<dynamic>?)
        ?.map((e) => AnswerItemModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasMore: json['has_more'] as bool?,
    quotaMax: json['quota_max'] as int?,
    quotaRemaining: json['quota_remaining'] as int?,
  );
}

Map<String, dynamic> _$AnswerInfoResponseModelToJson(
        AnswerInfoResponseModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'has_more': instance.hasMore,
      'quota_max': instance.quotaMax,
      'quota_remaining': instance.quotaRemaining,
    };
