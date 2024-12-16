import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:wallet_new/features/data/models/account_bybit_models/account_bybit_model.dart';
import 'package:wallet_new/features/data/models/coin_model.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';
import 'package:wallet_new/features/domain/entities/user_entity.dart';

abstract class BybitRemoteDatasource {
  Future<List<CoinEntity>> getAllCoins();
  Future<CoinEntity> getCoin(String name);
  Future<UserEntity> bybitAuth(
      String apiKey, String apiSecret, UserEntity user);
}

class BybitRemoteDatasourceImpl implements BybitRemoteDatasource {
  final String apiKey;
  final Dio dio = Dio();
  final String baseUrl;

  BybitRemoteDatasourceImpl({
    this.apiKey = 'hXzxaO47eJDWGuP4yJ',
    this.baseUrl = 'https://api.bybit.com',
  });

  /// Получение всех монет
  @override
  Future<List<CoinModel>> getAllCoins() async {
    final param = {'category': 'spot', 'apikey': apiKey ?? this.apiKey};

    final response = await _makeRequest('/v5/market/tickers', param);
    return (response["result"] as List)
        .map((item) => CoinModel.fromJson(item))
        .toList();
  }

  /// Получение конкретной монеты по имени
  @override
  Future<CoinModel> getCoin(String name) async {
    final param = {'category': 'spot', 'apikey': apiKey ?? this.apiKey};

    final response = await _makeRequest('/v5/market/tickers', param);
    final coinData = (response["result"]["list"] as List)
        .firstWhere((coin) => coin['symbol'] == name, orElse: () => null);
    if (coinData == null) {
      throw Exception('Coin with name $name not found');
    }
    return CoinModel.fromJson(coinData);
  }

  @override
  Future<AccountBybitModel> bybitAuth(
      String apiKey, String apiSecret, UserEntity user) async {
    final param = {
      'accountType': "UNIFIED",
      'apiKey': apiKey,
      'apiSecret': apiSecret
    };

    final response = await _makeRequest('/v5/account/wallet-balance', param);

    final accountData = (response["result"]["list"] as List)
        .map((item) => AccountBybitModel.fromJson(item))
        .toList();

    if (accountData == null) {
      throw Exception('Error: Account not found');
    } else {
      return accountData.first;
    }
  }

  /// Выполнение запроса с подписанными параметрами
  Future<Map<String, dynamic>> _makeRequest(String endpoint, param) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    final params = {
      'timestamp': timestamp,
    };
    params.addAll(param);
    params['sign'] = _generateSignature(params);

    try {
      final response =
          await dio.get('$baseUrl$endpoint', queryParameters: params);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch data: ${response.statusMessage}');
      }
    } catch (error) {
      throw Exception('Error during Dio request: $error');
    }
  }

  /// Генерация сигнатуры HMAC-SHA256
  String _generateSignature(Map<String, dynamic> params) {
    final sortedKeys = params.keys.toList()..sort();
    final queryString =
        sortedKeys.map((key) => '$key=${params[key]}').join('&');
    final hmac = Hmac(sha256, utf8.encode(apiSecret));
    final digest = hmac.convert(utf8.encode(queryString));
    return digest.toString();
  }
}
