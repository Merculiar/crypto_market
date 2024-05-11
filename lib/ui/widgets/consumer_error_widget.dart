import 'package:flutter/material.dart';

class ConsumerErrorWidget extends StatelessWidget {
  const ConsumerErrorWidget(
    this.error, {
    super.key,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.report_outlined,
          color: Colors.red[800],
          size: 48,
        ),
        const SizedBox(height: 16, width: double.infinity),
        SelectableText(
          error.isEmpty ? 'An error occured. Please try again later' : error,
        ),
      ],
    );
  }
}
