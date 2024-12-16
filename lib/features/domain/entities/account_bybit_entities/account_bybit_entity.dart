import 'package:equatable/equatable.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_coin_entity.dart';

class AccountBybitEntity extends Equatable {
  final String totalEquity;
  final String accountIMRate;
  final String totalMarginBalance;
  final String totalInitialMargin;
  final String accountType;
  final String totalAvailableBalance;
  final String accountMMRate;
  final String totalPerpUPL;
  final String totalWalletBalance;
  final String accountLTV;
  final String totalMaintenanceMargin;
  final List<AccountBybitCoinEntity> coin;

  AccountBybitEntity({
    required this.totalEquity,
    required this.accountIMRate,
    required this.totalMarginBalance,
    required this.totalInitialMargin,
    required this.accountType,
    required this.totalAvailableBalance,
    required this.accountMMRate,
    required this.totalPerpUPL,
    required this.totalWalletBalance,
    required this.accountLTV,
    required this.totalMaintenanceMargin,
    required this.coin,
  });

  @override
  List<Object?> get props => [
        totalEquity,
        accountIMRate,
        totalMarginBalance,
        totalInitialMargin,
        accountType,
        totalAvailableBalance,
        accountMMRate,
        totalPerpUPL,
        totalWalletBalance,
        accountLTV,
        totalMaintenanceMargin,
        coin,
      ];
}
