import 'package:beanie/constants.dart';
import 'package:flutter/material.dart';
import 'package:beanie/services/firestore_handler.dart';
import 'package:beanie/data/item_count.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ListItem extends StatefulWidget {
  final String itemTitle;

  ListItem({this.itemTitle});

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  FirestoreService fstore = FirestoreService();
  @override
  Widget build(BuildContext context) {
    TextEditingController editController =
        TextEditingController(text: widget.itemTitle);
    return Container(
      height: 40,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 7, 8, 8),
          child: Text(
            widget.itemTitle,
            style: TextStyle(height: 0, fontSize: 20),
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                padding: EdgeInsets.fromLTRB(25, 0, 0, double.infinity),
                onPressed: () {
                  Alert(
                    context: context,
                    title: '${widget.itemTitle} bearbeiten!',
                    content: Container(
                      height: 40,
                      child: TextField(
                        controller: editController,
                        cursorHeight: 20,
                        cursorColor: Colors.black,
                        cursorWidth: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF4C5DF5)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF4C5DF5)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: '',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        style: TextStyle(fontSize: 25, height: 2.2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    buttons: [
                      DialogButton(
                        color: Color(0xFF4C5DF5),
                        child: Text(
                          "Speichern",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () {
                          if (editController.text.isNotEmpty) {
                            fstore.editItem(
                                widget.itemTitle, editController.text);
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ).show();
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                  size: 22,
                ),
              ),
              IconButton(
                padding: EdgeInsets.fromLTRB(8, 0, 0, double.infinity),
                onPressed: () {
                  Provider.of<ItemCount>((context), listen: false)
                      .updateCount();
                  fstore.removeItem(widget.itemTitle);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
