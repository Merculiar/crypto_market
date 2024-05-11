import 'package:crypto_app/common/consumer_data.dart';
import 'package:crypto_app/common/consumer_state.dart';
import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/repositories/coins_repository.dart';
import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

class CoinsProvider extends ChangeNotifier {
  List<Coin> _allCoins = [];

  final _coins = ConsumerData<List<Coin>?>();
  ConsumerData<List<Coin>?> get coins => _coins;

  Future<void> loadCoinsInfo() async {
    _coins.state = ConsumerState.loading;
    try {
      _allCoins = await CoinsRepository.getCoinsData();
      _coins.data = _allCoins;
      _coins.data!.isNotEmpty
          ? _coins.state = ConsumerState.success
          : _coins.state = ConsumerState.empty;
    } catch (error) {
      _coins
        ..state = ConsumerState.error
        ..error = error.toString();
    }
    notifyListeners();
  }

  void searchCoinsList(String enteredKeyword) {
    if (enteredKeyword.isEmpty) {
      _coins.data = _allCoins;
    } else {
      final names = _allCoins.map((item) => item.name).toList();
      final filterResult = extractAllSorted<String>(
        query: enteredKeyword,
        choices: names,
        cutoff: 90,
      );

      final filterNames = filterResult.map((el) => el.choice).toSet();

      _coins.data = _allCoins
          .where((element) => filterNames.contains(element.name))
          .toList();
    }

    _coins.data!.isNotEmpty
        ? _coins.state = ConsumerState.success
        : _coins.state = ConsumerState.empty;

    notifyListeners();
  }
}
