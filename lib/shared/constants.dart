import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,

  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 1.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  )
);