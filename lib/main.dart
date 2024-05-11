import 'package:crypto_app/providers/coin_details_provider.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CoinsProvider>(
          create: (_) => CoinsProvider(),
        ),
        ChangeNotifierProvider<CoinDetailsProvider>(
          create: (_) => CoinDetailsProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: child!,
          );
        },
      ),
    );
  }
}
