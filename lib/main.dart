import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
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
      home: const MyHomePage(title: 'Qoute Generator App'),
    );
  }
}

final qouteStore = QouteStore();

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({required this.title, super.key});

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
                'Click on the Bottom Right Button to Generate a Random Qoute',
                textAlign: TextAlign.center,
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
              child: Text('Error Fetching Data'),
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
                      image: 'https://picsum.photos/id/$num/500/900',
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
                        child: SizedBox(
                          width: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
