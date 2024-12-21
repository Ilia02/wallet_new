import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  UserEntity(
      {required this.uid, this.email, this.name});

  @HiveField(0)
  final String? email;

  @HiveField(1)
  final String uid;

  @HiveField(2)
  final String? name;

  static final empty = UserEntity(uid: '');
}
