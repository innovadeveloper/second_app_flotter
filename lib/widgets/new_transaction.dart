import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    // print(titleController.text);
    // print(amountController.text);
    if (titleController.text.isEmpty || amountController.text.isEmpty) return;

    final double amount = double.parse(amountController.text);
    if (amount <= 0) return;

    widget.addTx(titleController.text, amount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return // inputs
        Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              Text('No Date Chosen!'),
              FlatButton(textColor: Theme.of(context).primaryColor,
              child: Text('Choose Date', style: TextStyle(fontWeight: FontWeight.bold),),
              onPressed: (){},)
            ],),
            RaisedButton(
              child: Text(
                'Add Transaction',
              ),
              color: Theme.of(context).primaryColor,
              // textColor: Colors.white,// Theme.of(context).textTheme.button.color,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: () {
                submitData();
              },
            )
          ],
        ),
      ),
    );
  }
}
