import 'package:json_annotation/json_annotation.dart';
import 'package:question_answer_app/models/questions/question_item_model.dart';
import 'package:question_answer_app/models/user/user_model.dart';


part 'question_info_response_model.g.dart';

@JsonSerializable()
class QuestionInfoResponseModel {
  @JsonKey(name: "items")
 final List<QuestionItemModel>? items;
  @JsonKey(name: "has_more")
 final bool? hasMore;
  @JsonKey(name: "quota_max")
 final int? quotaMax;
  @JsonKey(name: "quota_remaining")
 final int? quotaRemaining;



 QuestionInfoResponseModel(
      {
        this.items,
        this.hasMore,
        this.quotaMax,
        this.quotaRemaining,
      });

  factory QuestionInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionInfoResponseModelToJson(this);
}
