import 'package:flutter/material.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'New Skirt',
      amount: 39.99,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text('CHART'),
              elevation: 2,
            ),
          ),
          Column(children: transactions.map((tx){
              // row : 1 - 2 (elements)
              return Row(
                children: <Widget>[
                  // container : price
                  Card(child: Text('${tx.amount} - '),),
                  // column : item data (2 articles) 
                  Column(children: <Widget>[
                    Text('${tx.title}'),
                    Text('${tx.date}'),
                  ],)
                ],
              );
            }).toList()
          ,),
        ],
      ),
    );
  }
}
