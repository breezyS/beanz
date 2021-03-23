import 'package:flutter/material.dart';

const kHeadlineTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 40,
  fontWeight: FontWeight.w600,
);

const kSubHeaderTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.w200,
);

const kInputTextDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF592116)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF592116)),
  ),
  filled: true,
  fillColor: Colors.white,
  hintText: 'Produkt hinzufügen...',
  hintStyle: TextStyle(color: Colors.grey),
);
