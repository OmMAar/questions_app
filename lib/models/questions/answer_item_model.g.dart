// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerItemModel _$AnswerItemModelFromJson(Map<String, dynamic> json) {
  return AnswerItemModel(
    answerId: json['answer_id'] as int?,
    isAccepted: json['is_accepted'] as bool?,
    contentLicense: json['content_license'] as String?,
    creationDate: json['creation_date'] as int?,
    lastActivityDate: json['last_activity_date'] as int?,
    owner: json['owner'] == null
        ? null
        : OwnerItemModel.fromJson(json['owner'] as Map<String, dynamic>),
    questionId: json['question_id'] as int?,
    score: json['score'] as int?,
  );
}

Map<String, dynamic> _$AnswerItemModelToJson(AnswerItemModel instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'is_accepted': instance.isAccepted,
      'score': instance.score,
      'last_activity_date': instance.lastActivityDate,
      'creation_date': instance.creationDate,
      'answer_id': instance.answerId,
      'question_id': instance.questionId,
      'content_license': instance.contentLicense,
    };
