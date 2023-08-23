import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class AdaptiveFlatButton extends StatelessWidget {
  final String text;
final VoidCallback handler;
const AdaptiveFlatButton(this.handler,this.text);
  @override
  Widget build(BuildContext context) {
    return  Platform.isIOS?
             CupertinoButton(onPressed: handler, child:  Text(text)): ElevatedButton(
                  onPressed: handler,
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white),
                  child:  Text(text));
  }
}