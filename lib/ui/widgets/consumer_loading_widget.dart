import 'package:flutter/material.dart';

class ConsumerLoadingWidget extends StatelessWidget {
  const ConsumerLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 48,
          width: 48,
          child: CircularProgressIndicator(),
        ),
        SizedBox(height: 16, width: double.infinity),
        Text('Loading data...'),
      ],
    );
  }
}
