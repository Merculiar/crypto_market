class CoinFullModel {
  CoinFullModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.description,
    required this.currentPrice,
  });

  factory CoinFullModel.fromJson(Map<String, dynamic> json) => CoinFullModel(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        image: json['image']['large'],
        description: json['description']['en'],
        currentPrice: json['market_data']['current_price']['usd']?.toDouble(),
      );

  final String id;
  final String symbol;
  final String name;
  final String image;
  final String description;
  final double? currentPrice;
}
