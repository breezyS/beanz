import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  CollectionReference itemCollection = Firestore.instance.collection('items');
  List<String> localItemList = [];

  void addItem(itemName) async {
    int highestPost = 0;

    QuerySnapshot itemSnap = await itemCollection.getDocuments();

    itemSnap.documents.forEach((doc) {
      if (doc['pos'] >= highestPost) {
        highestPost = doc['pos'] + 1;
      }
    });

    itemCollection
        .document(itemName)
        .setData({'item': itemName, 'pos': highestPost})
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add Item: $error"));
  }

  Future<void> removeItem(itemName) {
    itemCollection
        .document(itemName)
        .delete()
        .then((value) => print("Item removed"))
        .catchError((error) => print("Failed to remove Item: $error"));

    return null;
  }

  void editItem(itemName, newItemName) async {
    DocumentSnapshot docSnap = await itemCollection.document(itemName).get();
    int savedPos = docSnap.data['pos'];

    print('oldname $itemName, newname $newItemName, pos $savedPos');

    await removeItem(itemName);

    itemCollection
        .document(newItemName)
        .setData({'item': newItemName, 'pos': savedPos})
        .then((value) => print("Item Added"))
        .catchError((error) => print("Failed to add Item: $error"));
  }

  void swapItem(int oldIndex, int newIndex) async {
    await createLocalList();

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final String item = localItemList.removeAt(oldIndex);
    localItemList.insert(newIndex, item);

    for (int i = 0; i < localItemList.length; i++) {
      itemCollection
          .document(localItemList[i])
          .setData({'item': localItemList[i], 'pos': i})
          .then((value) => print("Item Added"))
          .catchError((error) => print("Failed to add Item: $error"));
    }
  }

  Future<void> createLocalList() async {
    Query itemCollectionLocal =
        Firestore.instance.collection('items').orderBy('pos');

    QuerySnapshot itemSnap = await itemCollectionLocal.getDocuments();

    itemSnap.documents.forEach((doc) {
      localItemList.add(doc.documentID);
    });

    itemSnap.documents.forEach((doc) {
      localItemList.remove(doc);
    });

    return null;
  }
}
