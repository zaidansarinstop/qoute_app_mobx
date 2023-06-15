import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:qoute_app_mobx/logic/qoute.dart';
import 'package:qoute_app_mobx/models/single_qoute.dart';

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
            return ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                final item = listData[index];
                return ListTile(
                  title: Text(item.text ?? 'NA'),
                  subtitle: Text(item.author ?? 'Not Specified'),
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
