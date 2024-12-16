import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';
import 'package:wallet_new/features/domain/usecases/bybit_usecases/get_coin.dart';

part 'get_coin_bybit_state.dart';

class GetCoinBybitCubit extends HydratedCubit<GetCoinBybitState> {
  final GetCoin coin;

  GetCoinBybitCubit({required this.coin}) : super(GetCoinBybitInitial());

  Future<void> fetchCoin(String name) async {
    emit(CoinLoading());

    try {
      final failureOrCoin = await coin(GetCoinParams(name: name));
      failureOrCoin.fold(
        (error) => emit(CoinError(message: error.toString())),
        (value) => emit(CoinLoaded(coin: value)),
      );
    } catch (e) {
      emit(CoinError(message: e.toString()));
    }
  }

  @override
  GetCoinBybitState? fromJson(Map<String, dynamic> json) {
    try {
      final stateType = json['type'] as String;

      switch (stateType) {
        case 'CoinLoaded':
          return CoinLoaded(coin: CoinEntity.fromJson(json['coin']));
        case 'CoinError':
          return CoinError(message: json['message']);
        case 'CoinLoading':
          return CoinLoading();
        default:
          return GetCoinBybitInitial();
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(GetCoinBybitState state) {
    if (state is CoinLoaded) {
      return {
        'type': 'CoinLoaded',
        'coin': state.coin.toJson(),
      };
    } else if (state is CoinError) {
      return {
        'type': 'CoinError',
        'message': state.message,
      };
    } else if (state is CoinLoading) {
      return {
        'type': 'CoinLoading',
      };
    } else {
      return {
        'type': 'GetCoinBybitInitial',
      };
    }
  }
}
