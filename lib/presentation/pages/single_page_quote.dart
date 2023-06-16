import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qoute_app_mobx/models/single_qoute.dart';

import '../widgets/qoute_box.dart';

class SinglePageQoute extends StatelessWidget {
  const SinglePageQoute({
    super.key,
    required this.listData,
  });

  final List<dynamic> listData;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: listData.length,
      itemBuilder: (context, index) {
        final SingleQoute item = listData[index];
        final int num = Random().nextInt(1000); // max limit from random URL
        return Stack(
          alignment: Alignment.center,
          children: [
            FadeInImage.assetNetwork(
              image: 'https://picsum.photos/id/$num/550/900',
              fit: BoxFit.cover,
              placeholder: 'assets/images/loading.gif',
              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                'assets/images/stock_photo.jpg',
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Center(
                child: QuoteBox(item: item),
              ),
            )
          ],
        );
      },
    );
  }
}
