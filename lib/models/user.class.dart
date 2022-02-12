import 'package:freezed_annotation/freezed_annotation.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
part 'user.class.freezed.dart';
part 'user.class.g.dart';

@Freezed()
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String username,
    required String email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json)
  => _$UserFromJson(json);
}