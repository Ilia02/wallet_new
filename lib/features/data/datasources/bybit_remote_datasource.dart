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
  Future<AccountBybitEntity> bybitGetWallet(String apiKey, String apiSecret);
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
    const apiCall = '/v5/market/tickers';
    final apiParams = {'category': 'spot'};

    final response = await _makeRequest(apiCall, _apiParamsToString(apiParams),
        apiKeyDefault, apiSecretDefault);

    return (response["result"] as List)
        .map((item) => CoinModel.fromJson(item))
        .toList();
  }

  /// Получение конкретной монеты по имени
  @override
  Future<CoinModel> getCoin(String name) async {
    const apiCall = '/v5/market/tickers';
    const apiParams = {'category': 'spot'};

    final response = await _makeRequest(apiCall, _apiParamsToString(apiParams),
        apiKeyDefault, apiSecretDefault);

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
    const apiCall = '/v5/account/wallet-balance';
    const apiParams = {'accountType': "UNIFIED"};

    final response = await _makeRequest(
        apiCall, _apiParamsToString(apiParams), apiKey, apiSecret);

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
    const apiCall = '/v5/user/query-api';
    const apiParams = '';

    final response = await _makeRequest(apiCall, apiParams, apiKey, apiSecret);

    final accountData = (response["result"] as List?);

    if (accountData == null) {
      throw Exception('Error: Account not found');
    } else {
      return accountData.first;
    }
  }

  /// Выполнение запроса с подписанными параметрами
  Future<Map<String, dynamic>> _makeRequest(
      String apiCall, String apiParams, String key, String secret) async {
    try {
      const recvWindow = 5000;
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final dataToSign = '$timestamp$key$recvWindow$apiParams';
      final hmac =
          Hmac(sha256, utf8.encode(secret)); // Используем HMAC с SHA256
      final signature = hmac.convert(utf8.encode(dataToSign)).toString();

      final headers = {
        'X-BAPI-API-KEY': key,
        'X-BAPI-TIMESTAMP': timestamp,
        'X-BAPI-SIGN': signature,
        'X-BAPI-RECV-WINDOW': recvWindow,
      };

      final response = await dio.get('$baseUrlDefault/$apiCall?$apiParams',
          //queryParameters: params,
          options: Options(
            headers: headers,
          ));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch data: ${response.statusMessage}');
      }
    } catch (error) {
      throw Exception('Error during Dio request: $error');
    }
  }

  String _apiParamsToString(Map<String, dynamic> params) {
    final sortedKeys = params.keys.toList()..sort();
    return sortedKeys.map((key) => '$key=${params[key]}').join('&');
  }
}
