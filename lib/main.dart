import 'package:flutter/material.dart';
import 'screens/list_selection_screen.dart';
import 'package:provider/provider.dart';
import 'package:beanie/data/item_count.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemCount(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Beba'),
          title: 'Beanie',
          themeMode: ThemeMode.dark,
          home: ListSelectionScreen(),
        ),
      ),
    );
  }
}
