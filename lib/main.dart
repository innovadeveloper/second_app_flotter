import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // para reutilizar el theme_data se puede crear una constante global ..
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        errorColor: Colors.red,
        fontFamily: 'Poppins',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            button: TextStyle(
              color: Colors.white,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 70.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //     id: 't2',
    //     title: 'New Skirt 2',
    //     amount: 29.99,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     id: 't3',
    //     title: 'New Skirt 3',
    //     amount: 159.99,
    //     date: DateTime.now().subtract(Duration(days: 5))),
  ];
  bool _selectedSwitch = true;

  /*
    * mètodo que agrega un elemento a la lista
    */
  void _addNewTransaction(
      final String title, final double amount, final DateTime date) {
    Transaction transaction = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date);
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  /*
  * Deletea la tx by id
  */
  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  /*
   * retorna el tamanio total de la pantalla sin considerar el tamanio del appbar y
   * la barra de notificaciones o notch..
   */
  double _screenTotalSize(
      ObstructingPreferredSizeWidget appBar, MediaQueryData mediaQueryData) {
    return (mediaQueryData.size.height -
        appBar.preferredSize.height -
        mediaQueryData.padding.top);
  }

  /*
   * Recupera las transaciones de los ùltimos 7 dìas
   */
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (contextModal) {
        return GestureDetector(
          onTap:
              () {}, // fixing in android : not close by touch on the background
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior
              .opaque, // fixing in android : not close by touch on the background
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ObstructingPreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              'Personal Expemses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () => _startAddNewTransaction(context),
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          )
        : AppBar(
            centerTitle: false,
            // title: Text('Flutter App', style: TextStyle(fontFamily: 'Quicksand'),),
            title: Text(
              'Flutter App 2',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    var mediaQuery = MediaQuery.of(context);
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var txListWidget = Container(
      height: _screenTotalSize(appBar, mediaQuery) * 0.7,
      child: TransactionList(
        _userTransactions,
        _deleteTransaction,
      ),
    );

    var pageBody = SafeArea(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (isLandscape)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Choose chart',
                style: Theme.of(context).textTheme.headline6,
              ),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: _selectedSwitch,
                onChanged: (picked) {
                  setState(() {
                    _selectedSwitch = picked;
                  });
                },
              )
            ],
          ),
        if (!isLandscape)
          Container(
            height: _screenTotalSize(appBar, mediaQuery) * 0.3, // min
            child: Chart(
              _recentTransactions,
            ),
          ),
        if (!isLandscape) txListWidget,
        if (isLandscape)
          _selectedSwitch
              ? Container(
                  height: _screenTotalSize(appBar, mediaQuery) * 0.7, // max
                  child: Chart(
                    _recentTransactions,
                  ),
                )
              : txListWidget
      ],
    ));
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: pageBody,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
