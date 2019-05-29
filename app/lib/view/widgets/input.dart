import 'dart:io';
import 'package:flutter/material.dart';

Widget inputField(String label, String hint, {bool secure}){
  return Container(
    padding: EdgeInsets.only(
      top: 20,
      left: 20,
      right: 20,
    ),
    child: textField(label, hint, secure: secure == true),
  );
}

Widget textField(String label, String hint, {bool secure = false}) {
  return TextField(
    obscureText: secure,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
    ),
  );
}