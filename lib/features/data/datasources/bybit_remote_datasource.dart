import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:wallet_new/features/data/models/account_bybit_models/account_bybit_model.dart';
import 'package:wallet_new/features/data/models/account_bybit_models/bybit_api.dart';
import 'package:wallet_new/features/data/models/coin_model.dart';
import 'package:wallet_new/features/domain/entities/account_bybit_entities/account_bybit_entity.dart';
import 'package:wallet_new/features/domain/entities/bybit_api_entity.dart';
import 'package:wallet_new/features/domain/entities/coin_entity.dart';

abstract class BybitRemoteDatasource {
  Future<List<CoinEntity>> getAllCoins();
  Future<CoinEntity> getCoin(String name);
  Future<BybitApiEntity> bybitAuth(String apiKey, String apiSecret);
}

class BybitRemoteDatasourceImpl implements BybitRemoteDatasource {
  final Dio dio = Dio();
  static const String baseUrlDefault = 'https://api.bybit.com';
  static const String apiKeyDefault = 'hXzxaO47eJDWGuP4yJ';
  static const String apiSecretDefault = 'qwerty';

  BybitRemoteDatasourceImpl();

  /// Получение всех монет
  @override
  Future<List<CoinModel>> getAllCoins() async {
    final param = {'category': 'spot', 'apikey': apiKeyDefault};

    final response = await _makeRequest('/v5/market/tickers', param);
    return (response["result"] as List)
        .map((item) => CoinModel.fromJson(item))
        .toList();
  }

  /// Получение конкретной монеты по имени
  @override
  Future<CoinModel> getCoin(String name) async {
    final param = {'category': 'spot', 'apikey': apiKeyDefault};

    final response = await _makeRequest('/v5/market/tickers', param);
    final coinData = (response["result"]["list"] as List)
        .firstWhere((coin) => coin['symbol'] == name, orElse: () => null);
    if (coinData == null) {
      throw Exception('Coin with name $name not found');
    }
    return CoinModel.fromJson(coinData);
  }

  @override
  Future<AccountBybitEntity> bybitGetWallet(
      String apiKey, String apiSecret) async {
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

  @override
  Future<BybitApiModel> bybitAuth(String apiKey, String apiSecret) async {
    final param = {'apiKey': apiKey, 'apiSecret': apiSecret};

    final response = await _makeRequest('/v5/user/query-api', param);

    final accountData = (response["result"]["list"] as List?);

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
          await dio.get('$baseUrlDefault$endpoint', queryParameters: params);

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
    final hmac = Hmac(sha256, utf8.encode(apiSecretDefault));
    final digest = hmac.convert(utf8.encode(queryString));
    return digest.toString();
  }
}
