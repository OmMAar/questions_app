// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerItemModel _$OwnerItemModelFromJson(Map<String, dynamic> json) {
  return OwnerItemModel(
    userId: json['user_id'] as int?,
    acceptRate: json['accept_rate'] as int?,
    userType: json['user_type'] as String?,
    accountId: json['account_id'] as int?,
    displayName: json['display_name'] as String?,
    link: json['link'] as String?,
    profileImage: json['profile_image'] as String?,
    reputation: json['reputation'] as int?,
  );
}

Map<String, dynamic> _$OwnerItemModelToJson(OwnerItemModel instance) =>
    <String, dynamic>{
      'account_id': instance.accountId,
      'reputation': instance.reputation,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'profile_image': instance.profileImage,
      'display_name': instance.displayName,
      'link': instance.link,
      'accept_rate': instance.acceptRate,
    };
