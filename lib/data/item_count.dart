import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemCount extends ChangeNotifier {
  CollectionReference itemCollection = Firestore.instance.collection('items');
  static int tempCount = 0;
  int itemCount = 0;

  int getAmount() {
    return itemCount;
  }

  void updateCount() async {
    QuerySnapshot itemSnap = await itemCollection.getDocuments();
    itemCount = itemSnap.documents.length;
    notifyListeners();
  }
}
