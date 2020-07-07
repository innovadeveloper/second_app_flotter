import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTx;

  NewTransaction(this.addTx);

  void submitData() {
    // print(titleController.text);
    // print(amountController.text);
    if (titleController.text.isEmpty || amountController.text.isEmpty) return;

    final double amount = double.parse(amountController.text);
    if(amount <= 0)return;

    this.addTx(titleController.text, amount);
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
            FlatButton(
              child: Text(
                'Add Transaction',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              textColor: Colors.purple,
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
