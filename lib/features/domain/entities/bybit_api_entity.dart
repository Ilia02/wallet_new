import 'package:equatable/equatable.dart';

class BybitApiEntity extends Equatable {
  final String? apiKey;
  final String? apiSecret;

  const BybitApiEntity({required this.apiKey, required this.apiSecret});
  
  @override
  // TODO: implement props
  List<Object?> get props => [apiKey, apiSecret];
}
