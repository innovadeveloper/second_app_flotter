import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.10,
                      width: constraints.maxWidth * 0.8,
                      child: FittedBox(
                        child: Text(
                          'Not transactions added yest!',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.05,
                    ),
                    Container(
                      height: constraints.maxHeight *
                          0.6, // 0.6 porque el padre en el main tiene 0.7
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount.toStringAsFixed(2)}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transactions[index].title}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(transactions[index].date)}',
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            label: Text('Delete'),
                            icon: Icon(Icons.delete),
                            textColor: Theme.of(context).errorColor,
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
              // children: transactions.map((tx) {}).toList(),
            ),
    );
  }
}
