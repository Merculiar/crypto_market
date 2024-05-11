import 'package:flutter/material.dart';

class Coin {
  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate,
    required this.lastUpdated,
  });

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        image: json['image'],
        currentPrice: json['current_price']?.toDouble(),
        marketCap: json['market_cap']?.toDouble(),
        marketCapRank: json['market_cap_rank'],
        totalVolume: json['total_volume']?.toDouble(),
        high24H: json['high_24h']?.toDouble(),
        low24H: json['low_24h']?.toDouble(),
        priceChange24H: json['price_change_24h']?.toDouble(),
        priceChangePercentage24H:
            json['price_change_percentage_24h']?.toDouble(),
        marketCapChange24H: json['market_cap_change_24h']?.toDouble(),
        marketCapChangePercentage24H:
            json['market_cap_change_percentage_24h']?.toDouble(),
        ath: json['ath']?.toDouble(),
        athChangePercentage: json['ath_change_percentage']?.toDouble(),
        athDate: DateTime.parse(json['ath_date']),
        atl: json['atl']?.toDouble(),
        atlChangePercentage: json['atl_change_percentage']?.toDouble(),
        atlDate: DateTime.parse(json['atl_date']),
        lastUpdated: DateTime.parse(json['last_updated']),
      );

  final String id;
  final String symbol;
  final String name;
  final String image;
  final double? currentPrice;
  final double? marketCap;
  final int marketCapRank;
  final double? totalVolume;
  final double? high24H;
  final double? low24H;
  final double? priceChange24H;
  final double? priceChangePercentage24H;
  final double? marketCapChange24H;
  final double? marketCapChangePercentage24H;
  final double? ath;
  final double? athChangePercentage;
  final DateTime athDate;
  final double atl;
  final double atlChangePercentage;
  final DateTime atlDate;
  final DateTime lastUpdated;

  Text get priceChange {
    if (priceChange24H! < 0) {
      return Text(
        "${priceChangePercentage24H!.toStringAsFixed(2)}% (${priceChange24H!.toStringAsFixed(2)})",
        style: const TextStyle(color: Colors.red),
      );
    } else {
      return Text(
        "+${priceChangePercentage24H!.toStringAsFixed(2)}% (+${priceChange24H!.toStringAsFixed(2)})",
        style: const TextStyle(color: Colors.green),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'symbol': symbol,
        'name': name,
        'image': image,
        'current_price': currentPrice,
        'market_cap': marketCap,
        'market_cap_rank': marketCapRank,
        'total_volume': totalVolume,
        'high_24h': high24H,
        'low_24h': low24H,
        'price_change_24h': priceChange24H,
        'price_change_percentage_24h': priceChangePercentage24H,
        'market_cap_change_24h': marketCapChange24H,
        'market_cap_change_percentage_24h': marketCapChangePercentage24H,
        'ath': ath,
        'ath_change_percentage': athChangePercentage,
        'ath_date': athDate.toIso8601String(),
        'atl': atl,
        'atl_change_percentage': atlChangePercentage,
        'atl_date': atlDate.toIso8601String(),
        'last_updated': lastUpdated.toIso8601String(),
      };
}
