import 'package:crypto_app/common/consumer_state.dart';
import 'package:crypto_app/models/chart_data.dart';
import 'package:crypto_app/providers/coin_details_provider.dart';
import 'package:crypto_app/ui/widgets/calculator_widget.dart';
import 'package:crypto_app/ui/widgets/consumer_empty_widget.dart';
import 'package:crypto_app/ui/widgets/consumer_loading_widget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CoinDetailsScreen extends StatefulWidget {
  const CoinDetailsScreen({super.key, required this.id});

  final String id;

  @override
  State<CoinDetailsScreen> createState() => _CoinDetailsScreenState();
}

class _CoinDetailsScreenState extends State<CoinDetailsScreen> {
   Set<int> selection = <int>{1};

  @override
  void initState() {
    context.read<CoinDetailsProvider>().initCoinData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<CoinDetailsProvider>(
            builder: (_, provider, __) {
              switch (provider.coin.state) {
                case ConsumerState.loading:
                  return const ConsumerLoadingWidget();
                case ConsumerState.error:
                case ConsumerState.empty:
                  return const ConsumerEmptyWidget('No information to display');
                case ConsumerState.success:
                  final coin = provider.coin.data!;
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(coin.image),
                            ),
                            const SizedBox(width: 8),
                            Text(coin.name,
                                style: const TextStyle(fontSize: 20),
                                overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 350,
                          child: SfCartesianChart(
                            primaryXAxis: const DateTimeAxis(),
                            primaryYAxis: const NumericAxis(
                              opposedPosition: true,
                            ),
                            series: <AreaSeries>[
                              AreaSeries<ChartData, dynamic>(
                                  color: Colors.red.withOpacity(0.2),
                                  borderColor: Colors.red,
                                  borderWidth: 1,
                                  dataSource: provider.chartData,
                                  xValueMapper: (ChartData chartData, index) {
                                    return chartData.date;
                                  },
                                  yValueMapper: (ChartData chartData, index) {
                                    return chartData.price;
                                  }),
                            ],
                          ),
                        ),
                        SegmentedButton<int>(
                          showSelectedIcon: false,
                          segments: const <ButtonSegment<int>>[
                            ButtonSegment<int>(value: 1, label: Text('1D')),
                            ButtonSegment<int>(value: 7, label: Text('7D')),
                            ButtonSegment<int>(value: 28, label: Text('28D')),
                            ButtonSegment<int>(value: 90, label: Text('90D')),
                          ],
                          selected: selection,
                          onSelectionChanged: (Set<int> newSelection) {
                            setState(() {
                              selection = newSelection;
                              provider.loadChartData(newSelection.first);
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        const CalculatorWidget(),
                        const SizedBox(height: 10),
                        const Divider(),
                        ExpandableText(
                          coin.description,
                          maxLines: 6,
                          expandText: 'Show more',
                          collapseText: 'Show less',
                        ),
                      ],
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
