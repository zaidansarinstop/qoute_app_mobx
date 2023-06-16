import 'package:flutter/material.dart';

import '../../models/single_qoute.dart';

class QuoteBox extends StatelessWidget {
  const QuoteBox({
    super.key,
    required this.item,
  });

  final SingleQoute item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black.withOpacity(0.3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            item.text,
            style: const TextStyle(fontSize: 20, color: Colors.white, shadows: [
              Shadow(blurRadius: 5, color: Colors.black, offset: Offset(2, 2))
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            item.author ?? 'Not Specified',
            style: const TextStyle(color: Colors.white, shadows: [
              Shadow(blurRadius: 5, color: Colors.black, offset: Offset(3, 3))
            ]),
          ),
        ],
      ),
    );
  }
}