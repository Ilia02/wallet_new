import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'bybit_api_entity.g.dart';

@HiveType(typeId: 1)
class BybitApiEntity extends Equatable {
  @HiveField(0)
  final String apiKey;

  @HiveField(1)
  final String apiSecret;

  const BybitApiEntity({required this.apiKey, required this.apiSecret});

  @override
  // TODO: implement props
  List<Object?> get props => [apiKey, apiSecret];

  factory BybitApiEntity.fromJson(Map<String, dynamic> json) {
    return BybitApiEntity(
      apiKey: json['apiKey'] as String,
      apiSecret: json['apiSecret'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'apiSecret': apiSecret,
    };
  }
}
