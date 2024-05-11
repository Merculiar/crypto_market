import 'package:crypto_app/common/consumer_data.dart';
import 'package:crypto_app/common/consumer_state.dart';
import 'package:crypto_app/models/chart_data.dart';
import 'package:crypto_app/models/coin_full_model.dart';
import 'package:crypto_app/repositories/coins_repository.dart';
import 'package:flutter/material.dart';

class CoinDetailsProvider extends ChangeNotifier {
  final _coin = ConsumerData<CoinFullModel?>();
  ConsumerData<CoinFullModel?> get coin => _coin;

  List<ChartData> chartData = [];

  Future<void> initCoinData(String id) async {
    _coin.state = ConsumerState.loading;
    try {
      _coin.data = await CoinsRepository.getFullDataByCoinId(id);
      loadChartData(1);
      _coin.data != null
          ? _coin.state = ConsumerState.success
          : _coin.state = ConsumerState.empty;
    } catch (error) {
      _coin
        ..state = ConsumerState.error
        ..error = error.toString();
    }
    notifyListeners();
  }

  Future<void> loadChartData(int days) async {
    chartData = [];
    notifyListeners();
    chartData = await CoinsRepository.fetchChartData(_coin.data!.id, days);
    notifyListeners();
  }
}
