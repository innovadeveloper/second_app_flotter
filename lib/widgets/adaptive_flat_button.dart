import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlatButton extends StatelessWidget {

  final String _label;
  final Function _selectHandler;

  AdaptiveFlatButton(this._label, this._selectHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              _label,
            ),
            // color: Theme.of(context).primaryColor,
            onPressed: _selectHandler,
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            child: Text(
              _label,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: _selectHandler,
          );
  }
}
