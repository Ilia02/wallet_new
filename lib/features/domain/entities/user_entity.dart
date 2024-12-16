import 'package:hive/hive.dart';
import 'package:wallet_new/features/domain/entities/api_coin_entity.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  UserEntity(
      {required this.uid, this.email, this.name, List<ApiCoinEntity>? api})
      : api = api ?? [];

  @HiveField(0)
  final String? email;

  @HiveField(1)
  final String uid;

  @HiveField(2)
  final String? name;

  @HiveField(3)
  final List<ApiCoinEntity> api;

  void addApiCoin(ApiCoinEntity value) {
    api.add(value);
  }

  static final empty = UserEntity(uid: '');
}
