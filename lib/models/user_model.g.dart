// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProfile _$_$_UserProfileFromJson(Map<String, dynamic> json) {
  return _$_UserProfile(
    id: json['id'] as String?,
    name: json['name'] as String,
    phone: json['phone'] as String,
    ratings: (json['ratings'] as num).toDouble(),
    isMechanic: json['isMechanic'] as bool? ?? false,
  );
}

Map<String, dynamic> _$_$_UserProfileToJson(_$_UserProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'ratings': instance.ratings,
      'isMechanic': instance.isMechanic,
    };
