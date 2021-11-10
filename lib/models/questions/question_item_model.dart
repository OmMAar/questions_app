import 'package:json_annotation/json_annotation.dart';
import 'package:question_answer_app/models/questions/owner_item_model.dart';
import 'dart:convert';

part 'question_item_model.g.dart';

@JsonSerializable()
class QuestionItemModel {
  @JsonKey(name: "tags")
 final List<String>? tags;
  @JsonKey(name: "owner")
  final OwnerItemModel? owner;
  @JsonKey(name: "is_answered")
  final bool? isAnswered;
  @JsonKey(name: "view_count")
  final int? viewCount;
  @JsonKey(name: "answer_count")
  final int? answerCount;
  @JsonKey(name: "score")
  final int? score;
  @JsonKey(name: "last_activity_date")
  final int? lastActivityDate;
  @JsonKey(name: "creation_date")
  final int? creationDate;
  @JsonKey(name: "question_id")
   int? questionId;
  @JsonKey(name: "content_license")
  final String? contentLicense;
  @JsonKey(name: "link")
  final String? link;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "last_edit_date")
  final int? lastEditDate;
  @JsonKey(name: "accepted_answer_id")
  final int? acceptedAnswerId;



  QuestionItemModel(
      {
        this.link,
        this.title,
        this.tags,
        this.acceptedAnswerId,

        this.answerCount,
        this.contentLicense,
        this.creationDate,
        this.isAnswered,
        this.lastActivityDate,
        this.lastEditDate,
        this.owner,
        this.questionId,
        this.score,
        this.viewCount,
      });

  factory QuestionItemModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionItemModelToJson(this);
  // id,tags, owner, isAnswered, answerCount,viewCount,score,questionId,link
  // ,title,acceptedAnswerId
  Map<String, dynamic> questionItemLocalModelToJson(QuestionItemModel instance) =>
      <String, dynamic>{
        'tags': instance.tags?.join(","),
        'owner': json.encode(instance.owner),
        'is_answered': instance.isAnswered,
        'view_count': instance.viewCount,
        'answer_count': instance.answerCount,
        'score': instance.score,
        'question_id': instance.questionId,
        'link': instance.link,
        'title': instance.title,
        'accepted_answer_id': instance.acceptedAnswerId,
      };
  static QuestionItemModel questionItemLocalModelFromJson(Map<String, dynamic> jsonItem) {
    String text = jsonItem['tags'] as String;
    List<String> tags = text.split(',');
    return QuestionItemModel(
      link: jsonItem['link'] as String?,
      title: jsonItem['title'] as String?,
      tags: tags,
      acceptedAnswerId: jsonItem['accepted_answer_id'] as int?,
      answerCount: jsonItem['answer_count'] as int?,
      isAnswered: jsonItem['is_answered'] as int == 1? true : false,
      owner: json.decode(jsonItem['owner']) == null
          ? null
          : OwnerItemModel.fromJson(json.decode(jsonItem['owner']) as Map<String, dynamic>),
      questionId: jsonItem['question_id'] as int?,
      score: jsonItem['score'] as int?,
      viewCount: jsonItem['view_count'] as int?,
    );
  }
}
