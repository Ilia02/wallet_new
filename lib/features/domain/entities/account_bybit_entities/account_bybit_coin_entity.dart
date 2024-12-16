import 'package:equatable/equatable.dart';

class AccountBybitCoinEntity extends Equatable {
  final String availableToBorrow;
  final String bonus;
  final String accruedInterest;
  final String availableToWithdraw;
  final String totalOrderIM;
  final String equity;
  final String totalPositionMM;
  final String usdValue;
  final String spotHedgingQty;
  final String unrealisedPnl;
  final bool collateralSwitch;
  final String borrowAmount;
  final String totalPositionIM;
  final String walletBalance;
  final String cumRealisedPnl;
  final String locked;
  final bool marginCollateral;
  final String coin;

  AccountBybitCoinEntity({
    required this.availableToBorrow,
    required this.bonus,
    required this.accruedInterest,
    required this.availableToWithdraw,
    required this.totalOrderIM,
    required this.equity,
    required this.totalPositionMM,
    required this.usdValue,
    required this.spotHedgingQty,
    required this.unrealisedPnl,
    required this.collateralSwitch,
    required this.borrowAmount,
    required this.totalPositionIM,
    required this.walletBalance,
    required this.cumRealisedPnl,
    required this.locked,
    required this.marginCollateral,
    required this.coin,
  });

  @override
  List<Object?> get props => [
        availableToBorrow,
        bonus,
        accruedInterest,
        availableToWithdraw,
        totalOrderIM,
        equity,
        totalPositionMM,
        usdValue,
        spotHedgingQty,
        unrealisedPnl,
        collateralSwitch,
        borrowAmount,
        totalPositionIM,
        walletBalance,
        cumRealisedPnl,
        locked,
        marginCollateral,
        coin,
      ];
}
