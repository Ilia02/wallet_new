import 'package:equatable/equatable.dart';

abstract class ApiCoinEntity extends Equatable {
  const ApiCoinEntity();

  @override
  List<Object> get props => [];
}

class ApiCoinBybitEntity extends ApiCoinEntity {
  final String? apiKey;
  final String? apiSecret;

  const ApiCoinBybitEntity({required this.apiKey, required this.apiSecret});
}

class ApiCoinBinanceEntity extends ApiCoinEntity {}
