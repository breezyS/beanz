import 'package:flutter/material.dart';
import 'package:beanie/constants.dart';
import 'package:beanie/services/firestore_handler.dart';
import 'package:beanie/data/item_count.dart';
import 'package:provider/provider.dart';

class InputTextWidget extends StatefulWidget {
  const InputTextWidget({
    Key key,
    @required this.inputController,
  }) : super(key: key);

  final TextEditingController inputController;

  @override
  _InputTextWidgetState createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  void textFieldEvent() {
    if (widget.inputController.text.isNotEmpty) {
      Provider.of<ItemCount>((context), listen: false).updateCount();
      FirestoreService().addItem(widget.inputController.text);
      widget.inputController.text = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputController,
      enabled: true,
      decoration: kInputTextDecoration.copyWith(
        suffixIcon: IconButton(
          onPressed: () {
            textFieldEvent();
          },
          icon: Icon(
            Icons.send,
            color: Colors.green,
          ),
        ),
      ),
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
      onEditingComplete: () {
        textFieldEvent();
      },
    );
  }
}
