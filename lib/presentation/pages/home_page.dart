// Qoutes Data Store
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:qoute_app_mobx/models/single_qoute.dart';
import 'package:qoute_app_mobx/presentation/pages/all_qoutes.dart';

import '../../logic/page_store.dart';
import '../../logic/qoute.dart';
import '../widgets/error_display.dart';
import '../widgets/loading_display.dart';
import 'single_page_quote.dart';

// Qoutes Data Store
final qouteStore = QouteStore();

// Current Page Store
final pageStore = PageStore();

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({required this.title, super.key});

  void changePage(int page) {
    pageStore.changeIndex(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Observer(builder: (_) {
        final ObservableFuture<List<SingleQoute>>? future =
            qouteStore.listOfQoutes;
        final int currentPage = pageStore.pageIndex;
        if (future == null) {
          return const Center(
            child: SizedBox(
              width: 250,
              child: Text(
                'Please click on the Bottom Right Button to Generate a Random Qoute',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        }
        switch (future.status) {
          case FutureStatus.pending:
            return const Center(
              child: LoadingDisplay(),
            );
          case FutureStatus.rejected:
            return const Center(
              child: ErrorDisplay(),
            );
          case FutureStatus.fulfilled:
            final List<dynamic> listData = future.result;
            return currentPage == 0
                ? SinglePageQoute(listData: listData)
                : AllQoutes(listData: listData);
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          qouteStore.fetch();
        },
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: Observer(builder: (_) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.quora), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'All Qoutes'),
          ],
          currentIndex: pageStore.pageIndex,
          onTap: changePage,
        );
      }),
    );
  }
}
