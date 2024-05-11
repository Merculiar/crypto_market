import 'package:crypto_app/router/routes.dart';
import 'package:crypto_app/ui/screens/coin_details_screen.dart';
import 'package:crypto_app/ui/screens/coins_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/${Routes.coinsList.name}',
  redirect: (context, state) {
    return state.matchedLocation;
  },
  routes: [
    // Basic routes
    GoRoute(
      path: '/${Routes.coinsList.name}',
      name: Routes.coinsList.name,
      builder: (context, state) => const CoinsListScreen(),
    ),
    GoRoute(
      path: '/${Routes.coinDetails.name}',
      name: Routes.coinDetails.name,
      builder: (context, state) => CoinDetailsScreen(id: state.extra! as String),
    ),
  ],
);
