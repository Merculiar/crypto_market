import 'package:crypto_app/common/consumer_state.dart';
import 'package:crypto_app/providers/coins_provider.dart';
import 'package:crypto_app/ui/widgets/coin_list_item.dart';
import 'package:crypto_app/ui/widgets/consumer_empty_widget.dart';
import 'package:crypto_app/ui/widgets/consumer_error_widget.dart';
import 'package:crypto_app/ui/widgets/consumer_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinsListScreen extends StatefulWidget {
  const CoinsListScreen({super.key});

  @override
  State<CoinsListScreen> createState() => _CoinsListScreenState();
}

class _CoinsListScreenState extends State<CoinsListScreen> {
  final searchFieldController = TextEditingController();

  @override
  void initState() {
    context.read<CoinsProvider>().loadCoinsInfo();
    super.initState();
  }

  @override
  void dispose() {
    searchFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: SizedBox(
                    height: 52,
                    child: CupertinoTextField(
                      controller: searchFieldController,
                      onChanged: (value) =>
                          context.read<CoinsProvider>().searchCoinsList(value),
                      onTapOutside: (event) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      placeholder: 'Search coin',
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.grey[500]!,
                        ),
                      ),
                    ),
                  ),
                  snap: true,
                  floating: true,
                ),
              ];
            },
            body: Consumer<CoinsProvider>(
              builder: (_, provider, __) {
                switch (provider.coins.state) {
                  case ConsumerState.loading:
                    return const ConsumerLoadingWidget();
                  case ConsumerState.error:
                    return const ConsumerErrorWidget(
                        'Too many requests. Please try again later');
                  case ConsumerState.empty:
                    return const ConsumerEmptyWidget(
                        'No information to display');
                  case ConsumerState.success:
                    final coins = provider.coins.data!;
                    return ListView.separated(
                      itemCount: coins.length,
                      itemBuilder: (context, index) {
                        return CoinListItem(coin: coins[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(height: 0);
                      },
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
