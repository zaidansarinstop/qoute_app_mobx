import 'package:flutter/material.dart';

class ErrorDisplay extends StatelessWidget {
  const ErrorDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
          size: 50,
        ),
        Text(
          'Error Fetching Data',
          style: TextStyle(fontSize: 25),
        ),
        Text('Try Clicking on the buttom right Icon to refresh.')
      ],
    );
  }
}
