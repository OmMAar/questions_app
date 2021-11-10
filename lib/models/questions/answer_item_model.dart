import 'package:json_annotation/json_annotation.dart';
import 'package:question_answer_app/models/questions/owner_item_model.dart';
import 'dart:convert';
part 'answer_item_model.g.dart';

@JsonSerializable()
class AnswerItemModel {
  @JsonKey(name: "owner")
  final OwnerItemModel? owner;
  @JsonKey(name: "is_accepted")
  final bool? isAccepted;
  final int? score;
  @JsonKey(name: "last_activity_date")
  final int? lastActivityDate;
  @JsonKey(name: "creation_date")
  final int? creationDate;
  @JsonKey(name: "answer_id")
  final int? answerId;
  @JsonKey(name: "question_id")
  final int? questionId;
  @JsonKey(name: "content_license")
  final String? contentLicense;

  AnswerItemModel({
    this.answerId,
    this.isAccepted,
    this.contentLicense,
    this.creationDate,
    this.lastActivityDate,
    this.owner,
    this.questionId,
    this.score,
  });

  factory AnswerItemModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerItemModelToJson(this);
  // id, owner, isAccepted, score,answerId,questionId
  Map<String, dynamic> answerItemModelToJson(AnswerItemModel instance) =>
      <String, dynamic>{

        'owner': json.encode(instance.owner),
        'is_accepted': instance.isAccepted,
        'score': instance.score,
        'answer_id': instance.answerId,
        'question_id': instance.questionId,
      };
  static AnswerItemModel answerItemModelFromJson(Map<String, dynamic> jsonItem) {
    return AnswerItemModel(
      answerId: jsonItem['answer_id'] as int?,
      isAccepted: jsonItem['is_accepted'] as int == 1? true : false,
      contentLicense: jsonItem['content_license'] as String?,
      creationDate: jsonItem['creation_date'] as int?,
      lastActivityDate: jsonItem['last_activity_date'] as int?,
      owner: json.decode(jsonItem['owner']) == null
          ? null
          : OwnerItemModel.fromJson(json.decode(jsonItem['owner']) as Map<String, dynamic>),
      questionId: jsonItem['question_id'] as int?,
      score: jsonItem['score'] as int?,
    );
  }
}
