import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CoinListItem extends StatelessWidget {
  const CoinListItem({super.key, required this.coin});

  final Coin coin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.pushNamed(Routes.coinDetails.name, extra: coin.id);
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(coin.image),
      ),
      title: Row(
        children: [
          Flexible(child: Text(coin.name, overflow: TextOverflow.ellipsis)),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      subtitle: Text(coin.symbol.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "\$ ${coin.currentPrice!.toStringAsFixed(2)}",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          coin.priceChange,
        ],
      ),
    );
  }
}
