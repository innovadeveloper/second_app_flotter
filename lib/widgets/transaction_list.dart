import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (context, index) {
          // row : 1 - 2 (elements)
          return Card(
            elevation: 0,
            child: Row(
              children: <Widget>[
                // container : price
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.purple,
                    width: 2,
                  )),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // column : item data (2 articles)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${transactions[index].title}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    // Text('${DateFormat('yyyy-MM-dd').format(tx.date)}',
                    Text(
                      '${DateFormat.yMMMd().format(transactions[index].date)}',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: transactions.length,
        // children: transactions.map((tx) {}).toList(),
      ),
    );
  }
}
