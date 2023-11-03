import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  final String hint;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final bool formatted;

  const MyTextField(
      {super.key,
      required this.hint,
      this.keyboardType = TextInputType.text,

      required this.controller,
      this.obscureText = true,
      this.formatted = false});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FilteringTextInputFormatter authFilter =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));
  final FilteringTextInputFormatter noFilter =
      FilteringTextInputFormatter.deny(RegExp(r'\s'));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 10,
        right: 10,
      ),
      child: TextField(
        inputFormatters: [
          widget.formatted ? authFilter : noFilter,
        ],
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: widget.hint),
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText,
        controller: widget.controller,
      ),
    );
  }
}
