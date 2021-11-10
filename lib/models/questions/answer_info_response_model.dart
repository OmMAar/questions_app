import 'package:json_annotation/json_annotation.dart';
import 'package:question_answer_app/models/questions/answer_item_model.dart';

part 'answer_info_response_model.g.dart';

@JsonSerializable()
class AnswerInfoResponseModel {
  @JsonKey(name: "items")
  final List<AnswerItemModel>? items;
  @JsonKey(name: "has_more")
  final bool? hasMore;
  @JsonKey(name: "quota_max")
  final int? quotaMax;
  @JsonKey(name: "quota_remaining")
  final int? quotaRemaining;

  AnswerInfoResponseModel({
    this.items,
    this.hasMore,
    this.quotaMax,
    this.quotaRemaining,
  });

  factory AnswerInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerInfoResponseModelToJson(this);
}
