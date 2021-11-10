// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionItemModel _$QuestionItemModelFromJson(Map<String, dynamic> json) {
  return QuestionItemModel(
    link: json['link'] as String?,
    title: json['title'] as String?,
    tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    acceptedAnswerId: json['accepted_answer_id'] as int?,
    answerCount: json['answer_count'] as int?,
    contentLicense: json['content_license'] as String?,
    creationDate: json['creation_date'] as int?,
    isAnswered: json['is_answered'] as bool?,
    lastActivityDate: json['last_activity_date'] as int?,
    lastEditDate: json['last_edit_date'] as int?,
    owner: json['owner'] == null
        ? null
        : OwnerItemModel.fromJson(json['owner'] as Map<String, dynamic>),
    questionId: json['question_id'] as int?,
    score: json['score'] as int?,
    viewCount: json['view_count'] as int?,
  );
}

Map<String, dynamic> _$QuestionItemModelToJson(QuestionItemModel instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'owner': instance.owner,
      'is_answered': instance.isAnswered,
      'view_count': instance.viewCount,
      'answer_count': instance.answerCount,
      'score': instance.score,
      'last_activity_date': instance.lastActivityDate,
      'creation_date': instance.creationDate,
      'question_id': instance.questionId,
      'content_license': instance.contentLicense,
      'link': instance.link,
      'title': instance.title,
      'last_edit_date': instance.lastEditDate,
      'accepted_answer_id': instance.acceptedAnswerId,
    };
