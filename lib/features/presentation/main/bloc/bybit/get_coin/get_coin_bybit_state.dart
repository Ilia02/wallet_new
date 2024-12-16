part of 'get_coin_bybit_cubit.dart';

abstract class GetCoinBybitState extends Equatable {
  const GetCoinBybitState();

  @override
  List<Object> get props => [];
}

class GetCoinBybitInitial extends GetCoinBybitState {
  @override
  List<Object> get props => [];
}

class CoinLoading extends GetCoinBybitState {
  @override
  List<Object> get props => [];
}

class CoinLoaded extends GetCoinBybitState {
  final CoinEntity coin;

  CoinLoaded({required this.coin});

  @override
  List<Object> get props => [coin];
}

class CoinError extends GetCoinBybitState {
  final String message;

  const CoinError({required this.message});

  @override
  List<Object> get props => [message];
}
