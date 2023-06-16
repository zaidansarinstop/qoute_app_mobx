import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:qoute_app_mobx/logic/page_store.dart';
import 'package:qoute_app_mobx/logic/qoute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Quote App'),
    );
  }
}

final qouteStore = QouteStore();

final pageStore = PageStore();

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, super.key});

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
        final future = qouteStore.listOfQoutes;
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Loading Qoutes.......')
                ],
              ),
            );
          case FutureStatus.rejected:
            return const Center(
              child: Column(
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
              ),
            );
          case FutureStatus.fulfilled:
            final listData = future.result;
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: listData.length,
              itemBuilder: (context, index) {
                final item = listData[index];
                final num = Random().nextInt(1000); // max limit from random URL
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    FadeInImage.assetNetwork(
                      image: 'https://picsum.photos/id/$num/550/900',
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                        'assets/images/stock_photo.jpg',
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 1),
                      child: Center(
                        child: Container(
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
                                item.text ?? 'NA',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 5,
                                          color: Colors.black,
                                          offset: Offset(2, 2))
                                    ]),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                item.author ?? 'Not Specified',
                                style: const TextStyle(
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                          blurRadius: 5,
                                          color: Colors.black,
                                          offset: Offset(3, 3))
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
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
