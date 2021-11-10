import 'package:json_annotation/json_annotation.dart';
import 'package:question_answer_app/models/user/user_model.dart';


part 'owner_item_model.g.dart';

@JsonSerializable()
class OwnerItemModel {
  @JsonKey(name: "account_id")
 final int? accountId;
  @JsonKey(name: "reputation")
  final int? reputation;
  @JsonKey(name: "user_id")
  final int? userId;
  @JsonKey(name: "user_type")
  final String? userType;
  @JsonKey(name: "profile_image")
  final String? profileImage;
  @JsonKey(name: "display_name")
  final String? displayName;
  @JsonKey(name: "link")
  final String? link;
  @JsonKey(name: "accept_rate")
  final int? acceptRate;



  OwnerItemModel(
      {
        this.userId,
        this.acceptRate,
        this.userType,
        this.accountId,
        this.displayName,
        this.link,
        this.profileImage,
        this.reputation,
      });

  factory OwnerItemModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerItemModelToJson(this);
}
