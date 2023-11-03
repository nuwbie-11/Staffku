import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String label;
  final void Function() onPressed;
  const MyButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: Container(
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Text(widget.label),
        ),
      ),
    );
  }
}
