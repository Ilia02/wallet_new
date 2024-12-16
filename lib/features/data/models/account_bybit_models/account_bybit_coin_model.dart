import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_coin_entity.dart';

class AccountBybitCoinModel extends AccountBybitCoinEntity {
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

  AccountBybitCoinModel({
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
  }) : super(
            availableToBorrow: availableToBorrow,
            bonus: bonus,
            accruedInterest: accruedInterest,
            availableToWithdraw: availableToWithdraw,
            totalOrderIM: totalOrderIM,
            equity: equity,
            totalPositionMM: totalPositionMM,
            usdValue: usdValue,
            spotHedgingQty: spotHedgingQty,
            unrealisedPnl: unrealisedPnl,
            collateralSwitch: collateralSwitch,
            borrowAmount: borrowAmount,
            totalPositionIM: totalPositionIM,
            walletBalance: walletBalance,
            cumRealisedPnl: cumRealisedPnl,
            locked: locked,
            marginCollateral: marginCollateral,
            coin: coin);

  factory AccountBybitCoinModel.fromJson(Map<String, dynamic> json) {
    return AccountBybitCoinModel(
      availableToBorrow: json['availableToBorrow'],
      bonus: json['bonus'],
      accruedInterest: json['accruedInterest'],
      availableToWithdraw: json['availableToWithdraw'],
      totalOrderIM: json['totalOrderIM'],
      equity: json['equity'],
      totalPositionMM: json['totalPositionMM'],
      usdValue: json['usdValue'],
      spotHedgingQty: json['spotHedgingQty'],
      unrealisedPnl: json['unrealisedPnl'],
      collateralSwitch: json['collateralSwitch'],
      borrowAmount: json['borrowAmount'],
      totalPositionIM: json['totalPositionIM'],
      walletBalance: json['walletBalance'],
      cumRealisedPnl: json['cumRealisedPnl'],
      locked: json['locked'],
      marginCollateral: json['marginCollateral'],
      coin: json['coin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'availableToBorrow': availableToBorrow,
      'bonus': bonus,
      'accruedInterest': accruedInterest,
      'availableToWithdraw': availableToWithdraw,
      'totalOrderIM': totalOrderIM,
      'equity': equity,
      'totalPositionMM': totalPositionMM,
      'usdValue': usdValue,
      'spotHedgingQty': spotHedgingQty,
      'unrealisedPnl': unrealisedPnl,
      'collateralSwitch': collateralSwitch,
      'borrowAmount': borrowAmount,
      'totalPositionIM': totalPositionIM,
      'walletBalance': walletBalance,
      'cumRealisedPnl': cumRealisedPnl,
      'locked': locked,
      'marginCollateral': marginCollateral,
      'coin': coin,
    };
  }
}
