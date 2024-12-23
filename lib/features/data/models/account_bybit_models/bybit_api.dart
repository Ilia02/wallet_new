import 'package:wallet_new/features/domain/entities/bybit_api_entity.dart';

class BybitApiModel extends BybitApiEntity {
  final String apiKey;
  final String apiSecret;

  BybitApiModel({required this.apiKey, required this.apiSecret})
      : super(apiKey: apiKey, apiSecret: apiSecret);

  factory BybitApiModel.fromJson(Map<String, dynamic> json) {
    return BybitApiModel(
      apiKey: json["apiKey"] as String,
      apiSecret: json["apiSecret"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'apiKey': apiKey,
      'apiSecret': apiSecret,
    };
  }

  @override
  List<Object?> get props => [apiKey, apiSecret];
}
