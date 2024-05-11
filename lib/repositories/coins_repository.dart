import 'package:crypto_app/common/api_constants.dart';
import 'package:crypto_app/models/chart_data.dart';
import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/models/coin_full_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoinsRepository {
  static Future<List<Coin>> getCoinsData() async {
    try {
      final uri = ApiConstants.coinsListWithMarketDataUrl;
      var response = await http.get(uri);
      final responseData = jsonDecode(response.body) as List<dynamic>;
      final coins = List<Coin>.from(
        responseData.map(
          (note) => Coin.fromJson(note as Map<String, dynamic>),
        ),
      );

      return coins;
    } catch (error) {
      throw Exception('Failed to get data');
    }
  }

  static Future<CoinFullModel?> getFullDataByCoinId(String id) async {
    try {
      final url = ApiConstants.coinsFullDataByIdUrl(id);

      var response = await http.get(url);
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      return CoinFullModel.fromJson(responseData);
    } catch (error) {
      throw Exception('Failed to get data');
    }
  }

  static Future<List<ChartData>> fetchChartData(String id, int days) async {
    try {
      final url = ApiConstants.chartDataByDaysUrl(id, days);

      var response = await http.get(url);
      var responseData = jsonDecode(response.body);

      List<dynamic> prices = responseData['prices'];

      List<ChartData> data = [];
      for (var pricePoint in prices) {
        ChartData chartData = ChartData.fromList(pricePoint);
        data.add(chartData);
      }

      return data;
    } catch (error) {
      throw Exception('Failed to get data');
    }
  }
}
