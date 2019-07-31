import 'dart:io';
import 'package:flutter/material.dart';

Widget inputField(String label, String hint, {bool secure, TextEditingController controller}){
  return Container(
    padding: EdgeInsets.only(
      top: 20,
      left: 20,
      right: 20,
    ),
    child: textField(label, hint, secure: secure == true, controller: controller),
  );
}

Widget textField(String label, String hint, {bool secure = false, TextEditingController controller = null}) {
  return TextField(
    controller: controller,
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