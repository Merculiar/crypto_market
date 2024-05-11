import 'package:flutter/material.dart';

class ConsumerEmptyWidget extends StatelessWidget {
  const ConsumerEmptyWidget(
    this.emptyText, {
    super.key,
  });

  final String emptyText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.inbox,
          size: 36,
        ),
        const SizedBox(height: 16, width: double.infinity),
        Text(emptyText),
      ],
    );
  }
}
