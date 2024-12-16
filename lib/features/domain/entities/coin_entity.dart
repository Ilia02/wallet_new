class CoinEntity {
  final String symbol;
  final double bid1Price;
  final double bid1Size;
  final double ask1Price;
  final double ask1Size;
  final double lastPrice;
  final double prevPrice24h;
  final double price24hPcnt;
  final double highPrice24h;
  final double lowPrice24h;
  final double turnover24h;
  final double volume24h;
  final double usdIndexPrice;

  CoinEntity({
    required this.symbol,
    required this.bid1Price,
    required this.bid1Size,
    required this.ask1Price,
    required this.ask1Size,
    required this.lastPrice,
    required this.prevPrice24h,
    required this.price24hPcnt,
    required this.highPrice24h,
    required this.lowPrice24h,
    required this.turnover24h,
    required this.volume24h,
    required this.usdIndexPrice,
  });

  /// Factory constructor to create an instance from a JSON map
  factory CoinEntity.fromJson(Map<String, dynamic> json) {
    return CoinEntity(
      symbol: json['symbol'],
      bid1Price: (json['bid1Price'] as num).toDouble(),
      bid1Size: (json['bid1Size'] as num).toDouble(),
      ask1Price: (json['ask1Price'] as num).toDouble(),
      ask1Size: (json['ask1Size'] as num).toDouble(),
      lastPrice: (json['lastPrice'] as num).toDouble(),
      prevPrice24h: (json['prevPrice24h'] as num).toDouble(),
      price24hPcnt: (json['price24hPcnt'] as num).toDouble(),
      highPrice24h: (json['highPrice24h'] as num).toDouble(),
      lowPrice24h: (json['lowPrice24h'] as num).toDouble(),
      turnover24h: (json['turnover24h'] as num).toDouble(),
      volume24h: (json['volume24h'] as num).toDouble(),
      usdIndexPrice: (json['usdIndexPrice'] as num).toDouble(),
    );
  }

  /// Converts the instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'bid1Price': bid1Price,
      'bid1Size': bid1Size,
      'ask1Price': ask1Price,
      'ask1Size': ask1Size,
      'lastPrice': lastPrice,
      'prevPrice24h': prevPrice24h,
      'price24hPcnt': price24hPcnt,
      'highPrice24h': highPrice24h,
      'lowPrice24h': lowPrice24h,
      'turnover24h': turnover24h,
      'volume24h': volume24h,
      'usdIndexPrice': usdIndexPrice,
    };
  }
}
