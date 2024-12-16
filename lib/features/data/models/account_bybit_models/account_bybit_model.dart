import 'package:wallet_new/features/data/models/account_bybit_models/account_bybit_coin_model.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';

class AccountBybitModel extends AccountBybitEntity {
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
  final List<AccountBybitCoinModel> coin;

  AccountBybitModel({
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
  }) : super(
            totalEquity: totalEquity,
            accountIMRate: accountIMRate,
            totalMarginBalance: totalMarginBalance,
            totalInitialMargin: totalInitialMargin,
            accountType: accountType,
            totalAvailableBalance: totalAvailableBalance,
            accountMMRate: accountMMRate,
            totalPerpUPL: totalPerpUPL,
            totalWalletBalance: totalWalletBalance,
            accountLTV: accountLTV,
            totalMaintenanceMargin: totalMaintenanceMargin,
            coin: coin);

  factory AccountBybitModel.fromJson(Map<String, dynamic> json) {
    return AccountBybitModel(
      totalEquity: json['totalEquity'],
      accountIMRate: json['accountIMRate'],
      totalMarginBalance: json['totalMarginBalance'],
      totalInitialMargin: json['totalInitialMargin'],
      accountType: json['accountType'],
      totalAvailableBalance: json['totalAvailableBalance'],
      accountMMRate: json['accountMMRate'],
      totalPerpUPL: json['totalPerpUPL'],
      totalWalletBalance: json['totalWalletBalance'],
      accountLTV: json['accountLTV'],
      totalMaintenanceMargin: json['totalMaintenanceMargin'],
      coin: (json['coin'] as List<dynamic>)
          .map((coinJson) => AccountBybitCoinModel.fromJson(coinJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEquity': totalEquity,
      'accountIMRate': accountIMRate,
      'totalMarginBalance': totalMarginBalance,
      'totalInitialMargin': totalInitialMargin,
      'accountType': accountType,
      'totalAvailableBalance': totalAvailableBalance,
      'accountMMRate': accountMMRate,
      'totalPerpUPL': totalPerpUPL,
      'totalWalletBalance': totalWalletBalance,
      'accountLTV': accountLTV,
      'totalMaintenanceMargin': totalMaintenanceMargin,
      'coin': coin.map((c) => c.toJson()).toList(),
    };
  }

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
