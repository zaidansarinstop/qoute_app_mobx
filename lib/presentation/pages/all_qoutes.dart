import 'package:flutter/material.dart';
import 'package:qoute_app_mobx/models/single_qoute.dart';

class AllQoutes extends StatelessWidget {
  final List<dynamic> listData;

  const AllQoutes({super.key, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      interactive: true,
      thickness: 10,
      child: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: listData.length,
        itemBuilder: (context, index) {
          final SingleQoute item = listData[index];
          return ListTile(
            title: Text(item.text),
            subtitle: Text(item.author ?? 'Not specified'),
          );
        },
      ),
    );
  }
}
