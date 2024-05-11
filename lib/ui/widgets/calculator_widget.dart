import 'package:crypto_app/providers/coin_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final TextEditingController textUSDController = TextEditingController();
  final TextEditingController textQuantityController = TextEditingController();

  @override
  void initState() {
    textUSDController.text = '0';
    textQuantityController.text = '0';
    super.initState();
  }

  @override
  void dispose() {
    textUSDController.dispose();
    textQuantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoinDetailsProvider>();
    return Column(
      children: [
        const Text(
          'Swap',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('USD'),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: textUSDController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,4}')),
                      ],
                      decoration: const InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          textQuantityController.text =
                              '${(double.tryParse(value) ?? 0) / provider.coin.data!.currentPrice!}';
                        });
                      },
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/switch_arrows.png',
                width: 24,
                height: 24,
              ),
              Column(
                children: [
                  Text(
                      'Quantity (${provider.coin.data!.symbol.toUpperCase()})'),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: textQuantityController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,4}')),
                      ],
                      decoration: const InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          textUSDController.text =
                              '${(double.tryParse(value) ?? 0) * provider.coin.data!.currentPrice!}';
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
