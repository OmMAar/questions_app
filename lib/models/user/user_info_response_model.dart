import 'package:json_annotation/json_annotation.dart';
import 'package:question_answer_app/models/user/user_model.dart';


part 'user_info_response_model.g.dart';

@JsonSerializable()
class UserInfoResponseModel {
 final int? page;
 final int? perPage;
 final  int? total;
 final  int? totalPages;
 final List<UserModel>? data;



 UserInfoResponseModel(
      {
        this.data,
        this.page,
        this.perPage,
        this.total,
        this.totalPages,
      });

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoResponseModelToJson(this);
}
