import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

/// User model - serves as both model and entity.
/// Run: dart run build_runner build
@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? token;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
