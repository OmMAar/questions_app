// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponseModel _$UserInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return UserInfoResponseModel(
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    page: json['page'] as int?,
    perPage: json['perPage'] as int?,
    total: json['total'] as int?,
    totalPages: json['totalPages'] as int?,
  );
}

Map<String, dynamic> _$UserInfoResponseModelToJson(
        UserInfoResponseModel instance) =>
    <String, dynamic>{
      'page': instance.page,
      'perPage': instance.perPage,
      'total': instance.total,
      'totalPages': instance.totalPages,
      'data': instance.data,
    };
