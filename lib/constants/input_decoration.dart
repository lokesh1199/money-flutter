import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: 3.0,
      color: Colors.white,
    ),
    // borderRadius: BorderRadius.circular(20.0),
  ),
);

final loginTextInputDecoration = InputDecoration(
  fillColor: Colors.grey[200],
  filled: true,
  labelStyle: TextStyle(
    color: Colors.grey,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
    borderRadius: BorderRadius.circular(15.0),
  ),
);
