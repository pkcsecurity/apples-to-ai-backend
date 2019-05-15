import 'package:flutter/material.dart';

Widget inputField(String label, String hint){
  return Container(
    padding: EdgeInsets.only(
      top: 20,
      left: 20,
      right: 20,
    ),
    child: textField(label, hint),
  );
}

Widget textField(String label, String hint) {
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
  );
}