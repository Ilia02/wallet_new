import 'package:wallet_new/features/domain/entities/coin_entity.dart';

class CoinModel extends CoinEntity {
  CoinModel({
    required String symbol,
    required double bid1Price,
    required double bid1Size,
    required double ask1Price,
    required double ask1Size,
    required double lastPrice,
    required double prevPrice24h,
    required double price24hPcnt,
    required double highPrice24h,
    required double lowPrice24h,
    required double turnover24h,
    required double volume24h,
    required double usdIndexPrice,
  }) : super(
          symbol: symbol,
          bid1Price: bid1Price,
          bid1Size: bid1Size,
          ask1Price: ask1Price,
          ask1Size: ask1Size,
          lastPrice: lastPrice,
          prevPrice24h: prevPrice24h,
          price24hPcnt: price24hPcnt,
          highPrice24h: highPrice24h,
          lowPrice24h: lowPrice24h,
          turnover24h: turnover24h,
          volume24h: volume24h,
          usdIndexPrice: usdIndexPrice,
        );
 
  factory CoinModel.fromJson(Map<String, dynamic> json) {
    return CoinModel(
      symbol: json['symbol'],
      bid1Price: double.parse(json['bid1Price']),
      bid1Size: double.parse(json['bid1Size']),
      ask1Price: double.parse(json['ask1Price']),
      ask1Size: double.parse(json['ask1Size']),
      lastPrice: double.parse(json['lastPrice']),
      prevPrice24h: double.parse(json['prevPrice24h']),
      price24hPcnt: double.parse(json['price24hPcnt']),
      highPrice24h: double.parse(json['highPrice24h']),
      lowPrice24h: double.parse(json['lowPrice24h']),
      turnover24h: double.parse(json['turnover24h']),
      volume24h: double.parse(json['volume24h']),
      usdIndexPrice: double.parse(json['usdIndexPrice']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'bid1Price': bid1Price.toString(),
      'bid1Size': bid1Size.toString(),
      'ask1Price': ask1Price.toString(),
      'ask1Size': ask1Size.toString(),
      'lastPrice': lastPrice.toString(),
      'prevPrice24h': prevPrice24h.toString(),
      'price24hPcnt': price24hPcnt.toString(),
      'highPrice24h': highPrice24h.toString(),
      'lowPrice24h': lowPrice24h.toString(),
      'turnover24h': turnover24h.toString(),
      'volume24h': volume24h.toString(),
      'usdIndexPrice': usdIndexPrice.toString(),
    };
  }
}
