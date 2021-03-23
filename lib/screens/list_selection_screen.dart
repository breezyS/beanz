import 'package:flutter/material.dart';
import 'package:beanie/constants.dart';
import 'package:beanie/services/firebase_auth.dart';
import 'package:beanie/components/list_view_stream.dart';
import 'package:beanie/components/input_text.dart';
import 'package:provider/provider.dart';
import 'package:beanie/data/item_count.dart';

class ListSelectionScreen extends StatefulWidget {
  @override
  _ListSelectionScreenState createState() => _ListSelectionScreenState();
}

class _ListSelectionScreenState extends State<ListSelectionScreen> {
  final AuthService auth = AuthService();
  final ItemCount countrProv = ItemCount();
  final TextEditingController inputController = TextEditingController();
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    logInAnonymus();
  }

  void logInAnonymus() async {
    await auth.signInAnon();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ItemCount>(context, listen: false).updateCount();
    return Scaffold(
      backgroundColor: Color(0xFF592116),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 0, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: IconButton(
                          alignment: Alignment.topCenter,
                          color: Colors.white,
                          iconSize: 42,
                          icon: Icon(Icons.shop),
                          onPressed: () {},
                          padding: EdgeInsets.all(0),
                        )),
                    Text(
                      'EINKAUFSLISTE',
                      style: kHeadlineTextStyle,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    'Du hast ${Provider.of<ItemCount>(context).itemCount} Einträge',
                    style: kSubHeaderTextStyle,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListViewStream(),
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: InputTextWidget(inputController: inputController),
          )
        ],
      ),
    );
  }
}
