import 'package:beanie/components/list_item.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:beanie/services/firestore_handler.dart';

class ListViewStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Query itemCollection =
        Firestore.instance.collection('items').orderBy('pos');
    FirestoreService fstore = FirestoreService();
    return StreamBuilder<QuerySnapshot>(
      stream: itemCollection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.hasData) {
          return ReorderableListView(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            children: snapshot.data.documents.map((DocumentSnapshot document) {
              return Container(
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.lightBlueAccent,
                      width: 1,
                    ),
                  ),
                ),
                key: Key(document.data['pos'].toString()),
                child: ListItem(
                  itemTitle: document.data['item'],
                ),
              );
            }).toList(),
            onReorder: (int oldIndex, int newIndex) {
              fstore.swapItem(oldIndex, newIndex);
            },
          );
        } else {
          return ListView(
              padding: const EdgeInsets.fromLTRB(30, 8, 0, 8),
              children: [ListTile()]);
        }
      },
    );
  }
}
